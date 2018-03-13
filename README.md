# Kyle's Liferay Tools

This repo contains the tools and configuration that I use for my work at Liferay. This repo contains prototype quality code, so use it with caution. As the GPL states:

> This library is distributed in the hope that it will be useful, but WITHOUT
> ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
> FOR A PARTICULAR PURPOSE.

The code in this repo is licensed under [the GNU Lesser General Public License version 2.1 (see **`LICENSE.md`** for more details)](https://github.com/stiemannkj1/liferay-tools/blob/master/LICENSE.md).

If you want to access one of my (html + JS) markdown converters without cloning my repo you can use https://rawgit.com/:

- [Markdown to JIRA (Confluence) Converter](https://cdn.rawgit.com/stiemannkj1/liferay-tools/030309e190477b85fcd08a148169e588da7d0727/Tools/markdown-to-jira-confluence-converter.html)
- [Markdown to Liferay Forums (BBCode) Converter](https://cdn.rawgit.com/stiemannkj1/liferay-tools/62afd0496ba4c726f09792ff0526ef479f886647/Tools/markdown-to-liferay-forums-bbcode-converter.html)

To view the generated html of this **`README.md`** file locally:

    pandoc -i README.md -o README.html && firefox README.html
