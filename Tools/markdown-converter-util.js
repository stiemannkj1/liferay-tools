/**
 *    Copyright (c) 2000-2017 Liferay, Inc. All rights reserved.
 *
 *    This library is free software; you can redistribute it and/or modify it under
 *    the terms of the GNU Lesser General Public License as published by the Free
 *    Software Foundation; either version 2.1 of the License, or (at your option)
 *    any later version.
 *
 *    This library is distributed in the hope that it will be useful, but WITHOUT
 *    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 *    FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 *    details.
 **/

function MarkdownConverter(markdownRenderer) {

    marked.setOptions({
        renderer: markdownRenderer,
        gfm: true,
        tables: true,
        breaks: true,
        pedantic: false,
        sanitize: false,
        smartLists: true,
        smartypants: false
    });

    this.convert = function(markdownTextarea, convertedTextarea) {
        var markdownText = markdownTextarea.value;
        var convertedText = marked(markdownText);

        if (convertedText.charAt(0) === '\n') {
            convertedText = convertedText.substring(1);
        }

        convertedTextarea.value = convertedText;
    };
};

var Util = new (function() {

    function indentOrUnindentSelectedLines(indent, markdownTextarea) {
        var selectionStart = markdownTextarea.selectionStart;
        var selectionEnd = markdownTextarea.selectionEnd;
        var firstLineIndex = markdownTextarea.value.substring(0, selectionStart).lastIndexOf('\n') + 1;

        if (firstLineIndex === -1) {
            firstLineIndex = 0;
        }

        var stringBeforeSelection = markdownTextarea.value.substring(0, firstLineIndex);
        var stringAfterSelection = markdownTextarea.value.substring(selectionEnd);
        var changedLines;
        var newSelectionIndex;

        if (indent) {
            newSelectionIndex = selectionStart + 4;
            changedLines = '    ' + markdownTextarea.value.substring(firstLineIndex, selectionEnd)
                    .replace(/\n/g, '\n    ');
        } else {
            var textToUnindent = markdownTextarea.value.substring(firstLineIndex, markdownTextarea.selectionEnd);
            newSelectionIndex = selectionStart + (textToUnindent.startsWith('    ') ? -4 : 0);
            changedLines = textToUnindent.replace(/^    /, '')
                    .replace(/\n    /g, '\n');
        }

        markdownTextarea.value = stringBeforeSelection + changedLines + stringAfterSelection;
        markdownTextarea.focus();
        markdownTextarea.selectionStart = newSelectionIndex;
        markdownTextarea.selectionEnd = markdownTextarea.value.lastIndexOf(stringAfterSelection);
    }

    this.indentSelectedLines = function(markdownTextarea) {
        indentOrUnindentSelectedLines(true, markdownTextarea);
    };

    this.unindentSelectedLines = function(markdownTextarea) {
        indentOrUnindentSelectedLines(false, markdownTextarea);
    };

    this.unescapeXML = function(text) {
        // split and join are used instead of replace since replace does not replace all occurences. For more
        // details see: http://stackoverflow.com/questions/1144783/how-to-replace-all-occurrences-of-a-string-in-javascript#1145525
        return text.split('&lt;').join('<')
                .split('&gt;').join('>')
                .split('&quot;').join('"')
                .split('&#39;').join("'")
                .split('&amp;').join('&');
    };
})();
