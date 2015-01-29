/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.freemarker.generator;

import freemarker.ext.dom.NodeModel;
import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;
import freemarker.template.Version;
import java.io.File;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

/**
 * @author Kyle Stiemann
 */
public class FreemarkerGenerator {

	public static void main(String[] args) {

		// Get xml
		File xmlFile = new File(args[0]);
		NodeModel xml = null;

		try {
			xml = NodeModel.parse(xmlFile);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// Add xml to the freemarker context
		Map root = new HashMap();
		root.put("doc", xml);

		// Get freemarker file
		File freemarkerFile = new File(args[1]);
//		File freemarkerFolder = freemarkerFile.getParentFile();

		// Set freemarker configuration
		Configuration configuration = new Configuration();

//		try {
//			configuration.setDirectoryForTemplateLoading(freemarkerFolder);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}

        configuration.setObjectWrapper(new DefaultObjectWrapper());
        configuration.setDefaultEncoding("UTF-8");
        configuration.setTemplateExceptionHandler(TemplateExceptionHandler.DEBUG_HANDLER);
        configuration.setIncompatibleImprovements(new Version(2, 3, 20));

		// Get the freemarker template
		Template template = null;

		try {
			template = configuration.getTemplate(freemarkerFile.getName());
		} catch (Exception e) {
			e.printStackTrace();
		}

		Writer out = new OutputStreamWriter(System.out);

		try {
			template.process(root, out);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
