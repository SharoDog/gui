import QtQuick 6.6
import QtQuick.Shapes 6.6
import QtQuick.Controls 6.6
import QtQuick.Layouts 6.6

Rectangle {
	id: tabbar
	property int currentIndex: 0
	property alias model: repeater.model
	color: root.bg_color
	implicitHeight: layout.implicitHeight 
	RowLayout {
		id: layout
		anchors.fill: parent
		spacing: 0
		Repeater {
			id: repeater
			Shape {
				Layout.minimumWidth: content.contentWidth
				Layout.fillWidth: true
				Text {
					id: content
					color: root.fg_color
					anchors.verticalCenter: parent.verticalCenter
					anchors.horizontalCenter: parent.horizontalCenter
					text: modelData
					font.family: ethnocentric.font.family
					font.pointSize: 12
					smooth: true
				}
				height: content.contentHeight + root.ratio
				ShapePath {
					strokeWidth: tabbar.currentIndex == index ? 5 : 1
					strokeColor: root.border_color
					startX: content.x
					startY: content.contentHeight 
					PathLine { x: content.x + content.contentWidth; y: content.contentHeight }
				}
				MouseArea {
					anchors.fill: parent
					onClicked: { tabbar.currentIndex = index }
				}
			}		
		}
	}
}
