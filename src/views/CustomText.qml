import QtQuick 6.5

Text {
	id: "text"
	property alias size: text.font.pixelSize
	property alias text: text.text
	text: "IP Address"
	color: root.fg_color
	font.family: ethnocentric.font.family
	smooth: true
}
