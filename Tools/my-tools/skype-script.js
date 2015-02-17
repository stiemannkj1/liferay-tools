var clickEvent = document.createEvent('MouseEvents');
clickEvent.initEvent('mousedown', true, true);
var messageButton = document.getElementById('c_hiconm');
messageButton.dispatchEvent(clickEvent);

var leftCol = document.getElementsByClassName('ContentLeft Unselectable fadeOnHoverTarget');
leftCol[0].parentElement.removeChild(leftCol[0]);

var middleCol = document.getElementsByClassName('masterSizerBar sizerBarY c-SizerBar');
middleCol[0].parentNode.removeChild(middleCol[0]);

var rightCol = document.getElementsByClassName('ContentRight RPOff');
rightCol[0].parentNode.removeChild(rightCol[0]);

var sidebar = document.getElementById('sidebar');
sidebar.style.width = '100%';

var style = document.createElement('style');
style.type = 'text/css';
style.appendChild(document.createTextNode(
	'*::-moz-selection { background-color: #FF6600; }\n' +
	'.ModernConversationHistoryControl, .ModernConversationControlBottom { width: 60%; padding-left: 20%; }\n' + 
	'.ModernConversationHistoryControl ul, .ModernConversationHistoryControl li, .ModernConversationHistoryItem,\n' +
	'.ModernConversationControlBottom div, .ModernConversationControlBottom textarea { width: 98.5% !important; }\n'
));

document.getElementsByTagName('head')[0].appendChild(style);
