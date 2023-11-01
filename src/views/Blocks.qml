import QtQuick 6.6
import QtQuick.Controls 6.6
import QtQuick.Layouts 6.6
import QtWebView 6.6

Rectangle {
	id: blocks
	color: root.bg_color
	Text {
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		visible: blocksEditor.loading
		text: "Loading..."
		color: fg_color
		font.family: ethnocentric.font.family
		font.pixelSize: 24
		smooth: true
	}
	WebView {
		id: blocksEditor
		url: "qrc:/sharo/imports/views/blocks/dist/index.html"
		visible: !blocksEditor.loading
		anchors.fill: parent
		anchors.leftMargin: parent.width / 100 
		anchors.rightMargin: parent.width / 100 
		anchors.topMargin: parent.height / 100 
		anchors.bottomMargin: parent.height / 100 
	}
}
