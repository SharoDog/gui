import QtQuick 6.5

Rectangle {
	color: root.bg_color
	anchors.fill: parent
	CustomText {
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		text: "Loading..."
		font.pixelSize: 64
	}
}
