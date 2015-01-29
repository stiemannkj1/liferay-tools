package com.liferay.docs;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

/**
 * Copyright (c) 2000-2013 Liferay, Inc. All rights reserved.
 * 
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 * 
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
public class WikiParser {

	private static final String ESCAPED_DOT = "\\.";
	private static final char EQUALS = '=';
	private static final char IMG_END_TAG = '>';
	private static final String IMG_BEGIN_TAG = "<img";
	private static final String DIV_PAGE_ACTIONS_TOP_ACTIONS_START_TAG = "<div class=\"page-actions top-actions\">";
	private static final String DIV_PAGE_ACTIONS_START_TAG = "<div class=\"page-actions\">";
	private static final String F_OPTION = "-f";
	private static final int DIV_START_TAG_LENGTH = "<div>".length();
	private static final String DIV_CHILD_PAGES_START_TAG = "<div class=\"child-pages\">";
	private static final String DIV_WIKI_BODY_START_TAG = "<div class=\"wiki-body\">";
	private static final int DIV_END_TAG_LENGTH = "</div>".length();
	private static final String HTML_H1_START_TAG = "<h1 class=\"header-title\">";
	private static final char QUOTE_CHAR = '"';
	private static final String LIFERAY_COM = "//www.liferay.com";
	private static final String HTTP = "http:";
	private static final String HTML_END_TAGS = "</body></html>";
	private static final String HTML_BEGIN_TAGS = "<html><head></head><body>";

	public static void main(String[] args) {

		String wikis = new String("");
		List<String> arguments = new ArrayList<String>();

		if (args.length == 0) {

			System.err
					.println("wikiparser [-p parentWikiURL] [url, ...] [-f [filename.html]]");
			return;
		} else {

			for (String arg : args) {
				arguments.add(arg);
			}
		}

		String filename = null;
		String imageFolderName = null;

		if (arguments.indexOf(F_OPTION) > 0) {

			filename = "wikis.html";

			if (arguments.indexOf(F_OPTION) + 1 < arguments.size()) {

				filename = arguments.get(arguments.indexOf(F_OPTION) + 1);
				arguments.remove(arguments.indexOf(F_OPTION) + 1);
			}

			arguments.remove(arguments.indexOf(F_OPTION));
			imageFolderName = filename.split(ESCAPED_DOT)[0];
			File imageFolder = new File(imageFolderName);
			
			if (!imageFolder.exists()) {

				boolean success = imageFolder.mkdirs();

				if (!success) {
					System.err
							.println("[Error : The directory was not created for downloaded image files. The filename must be off the form [fileName].html]");
				}
			}
		}

		for (int i = 0; i < arguments.size(); i++) {

			if (i == 0 && arguments.get(0).equals("-p")) {

				arguments.addAll(getChildWikis(arguments.get(1)));
				String htmlFile = arguments.get(arguments.size() - 1);
				wikis = wikis + htmlFile;
				downloadImages(htmlFile, imageFolderName);
				arguments.remove(arguments.size() - 1);
			} else {

				System.out.println("Getting html from: " + arguments.get(i)
						+ "...");
				String htmlFile = getHTMLfromURL(arguments.get(i));
				System.out.println("Parsing wiki from: " + arguments.get(i)
						+ "...");
				String wiki = parseWiki(htmlFile);

				if (filename != null) {

					System.out.println("Downloading images from: "
							+ arguments.get(i) + "...");
					downloadImages(wiki, imageFolderName);
				}

				wikis = wikis + wiki;
			}
		}

		wikis = wrapWikis(wikis);

		if (filename != null) {
			outputToFile(wikis, filename);
		} else {
			System.out.println(wikis);
		}

	}

	protected static List<String> getChildWikis(String url) {

		String parentHTML = getHTMLfromURL(url);
		int ulStart = parentHTML.indexOf(DIV_CHILD_PAGES_START_TAG);
		int ulEnd = parentHTML.indexOf(DIV_PAGE_ACTIONS_START_TAG) - 1;
		String ul = parentHTML.substring(ulStart, ulEnd);

		// Skip the first two elements within quotes because they are not urls
		int urlStart = ul.indexOf(QUOTE_CHAR) + 1;
		int urlEnd = ul.indexOf(QUOTE_CHAR, urlStart);
		urlStart = ul.indexOf(QUOTE_CHAR, urlEnd) + 1;
		urlEnd = ul.indexOf(QUOTE_CHAR, urlStart);
		urlStart = ul.indexOf(QUOTE_CHAR, urlEnd) + 1;
		urlEnd = ul.indexOf(QUOTE_CHAR, urlStart);
		List<String> urls = new ArrayList<String>();

		while (urlEnd > 0 && urlStart > 0) {

			urls.add(ul.substring(urlStart, urlEnd));
			urlStart = ul.indexOf(QUOTE_CHAR, urlEnd) + 1;
			urlEnd = ul.indexOf(QUOTE_CHAR, urlStart);

			if (urlEnd > 0 && urlStart > 0) {
				urlStart = ul.indexOf(QUOTE_CHAR, urlEnd) + 1;
				urlEnd = ul.indexOf(QUOTE_CHAR, urlStart);
			}
		}

		int headerStart = parentHTML.indexOf(HTML_H1_START_TAG);
		int headerEnd = parentHTML
				.indexOf(DIV_PAGE_ACTIONS_TOP_ACTIONS_START_TAG)
				- DIV_END_TAG_LENGTH - 1;
		String wiki = parentHTML.substring(headerStart, headerEnd);
		int bodyStart = parentHTML.indexOf(DIV_WIKI_BODY_START_TAG)
				- DIV_START_TAG_LENGTH - 1;
		int bodyEnd = parentHTML.indexOf(DIV_CHILD_PAGES_START_TAG) - 1;
		wiki = wiki + parentHTML.substring(bodyStart, bodyEnd);

		// Since we already had to download the html for the parent wiki page,
		// parse it and pass it back to main at the end of the list of urls, so 
		// that we don't download it twice.
		urls.add(parseWiki(parentHTML));

		return urls;
	}

	protected static String getHTMLfromURL(String urlString) {

		URL url = null;
		InputStream inputStream = null;
		String htmlFile = null;

		try {
			url = new URL(urlString);
			inputStream = url.openStream();

			InputStreamReader inputStreamReader = new InputStreamReader(
					inputStream);
			StringBuilder stringBuilder = new StringBuilder();
			BufferedReader bufferedReader = new BufferedReader(
					inputStreamReader);
			String read = bufferedReader.readLine();

			while (read != null) {

				stringBuilder.append(read);
				read = bufferedReader.readLine();
			}

			htmlFile = stringBuilder.toString();

		} catch (MalformedURLException mue) {
			System.err
					.println("[Error: The html could not be downloaded because the URL was incorrect.]");
		} catch (IOException ioe) {
			System.err.println("[Error: The output could not be read.]"); // TODO
		} finally {
			try {
				if (inputStream != null)
					inputStream.close();
			} catch (IOException ioe) {

			}

			if (htmlFile == null) {
				System.err
						.println("[Error: The Downloaded html file is empty.]");
			}
		}

		return htmlFile;

	}

	protected static String parseWiki(String htmlFile) {

		int headerStart = htmlFile.indexOf(HTML_H1_START_TAG);
		int headerEnd = htmlFile
				.indexOf(DIV_PAGE_ACTIONS_TOP_ACTIONS_START_TAG)
				- DIV_END_TAG_LENGTH - 1;
		String wiki = htmlFile.substring(headerStart, headerEnd);

		int bodyStart = htmlFile.indexOf(DIV_WIKI_BODY_START_TAG)
				- DIV_START_TAG_LENGTH - 1;
		int bodyEnd = htmlFile.indexOf(DIV_PAGE_ACTIONS_START_TAG) - 1;

		if (bodyStart > 0 && bodyEnd > 0) {
			wiki = wiki + htmlFile.substring(bodyStart, bodyEnd);
		}

		return wiki;
	}

	protected static void downloadImage(String imageLink,
			String destinationFolder) throws IOException {

		String imageName = imageLink
				.substring(imageLink.lastIndexOf(EQUALS) + 1);
		URL url = new URL(imageLink);
		InputStream is = url.openStream();
		File file;
		file = new File(destinationFolder, imageName);

		if (!file.exists()) {
			file.createNewFile();
		}

		OutputStream os = new FileOutputStream(file);
		byte[] b = new byte[2048];
		int length;

		while ((length = is.read(b)) != -1) {
			os.write(b, 0, length);
		}

		is.close();
		os.close();
	}

	protected static void downloadImages(String htmlFile, String imagesFolder) {

		int startImageTag = htmlFile.indexOf(IMG_BEGIN_TAG);
		int endImageTag = htmlFile.indexOf(IMG_END_TAG, startImageTag);
		int srcAttribute;
		int startImageLink;
		int endImageLink;

		while (startImageTag > 0 && endImageTag > 0) {

			srcAttribute = htmlFile.indexOf("src=\"", startImageTag);
			startImageLink = htmlFile.indexOf(QUOTE_CHAR, srcAttribute) + 1;
			endImageLink = htmlFile.indexOf(QUOTE_CHAR, startImageLink);
			
			String imageLink = htmlFile.substring(startImageLink, endImageLink);
			
			if(!imageLink.contains(LIFERAY_COM)) {
				imageLink = HTTP + LIFERAY_COM + imageLink;
			}

			try {
				downloadImage(imageLink, imagesFolder);
			} catch (IOException e) {

				System.err.println("[Error: " + imageLink
						+ " failed to download.]");
			}

			startImageTag = htmlFile.indexOf(IMG_BEGIN_TAG, endImageTag) + 1;
			endImageTag = htmlFile.indexOf(IMG_END_TAG, startImageTag);
		}
	}

	protected static String wrapWikis(String wiki) {
		return HTML_BEGIN_TAGS + wiki + HTML_END_TAGS;
	}

	protected static void outputToFile(String wikis, String fileName) {

		try {

			File file;
			file = new File(fileName);

			if (!file.exists()) {
				file.createNewFile();
			}

			FileWriter fileWriter = new FileWriter(file.getAbsoluteFile());
			BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
			bufferedWriter.write(wikis);
			bufferedWriter.close();

		} catch (IOException e) {
			System.err.println("[Error: The file could not be written to.]");
		}
	}
}