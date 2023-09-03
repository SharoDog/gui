import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5

Rectangle {
	id: code
	color: root.bg_color
	Text {
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		text: "Coming Soon"
		color: fg_color
		font.family: ethnocentric.font.family
		font.pixelSize: 24
		smooth: true
	}
}
