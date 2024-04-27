import QtQuick 6.5
import QtQuick.Shapes 6.5
import QtQuick.Controls 6.5

Shape {
	id: "button"
	property alias text: content.text
	property bool pressed: false
	signal clicked
	Text {
		anchors.verticalCenter: parent.verticalCenter
		anchors.horizontalCenter: parent.horizontalCenter
		id: "content"
		text: "Text"
		color: button.pressed ? root.bg_color : root.fg_color
		font.family: ethnocentric.font.family
		font.pointSize: 24
		smooth: true
	}
	height: content.contentHeight + 4
	width: content.contentWidth + button.height / 2
	ShapePath {
		strokeWidth: 3
		strokeColor: root.border_color
		fillColor: button.pressed ? root.border_color : "transparent"
		startX: 0; startY: button.height / 8
		PathLine { x: button.height / 4; y: 0 }
		PathLine { x: button.width; y: 0 }	
		PathLine { x: button.width; y: button.height * 7 / 8 }	
		PathLine { x: button.width - button.height / 4; y: button.height }	
		PathLine { x: 0; y: button.height }	
		PathLine { x: 0; y: button.height / 8 }	
	}
	MouseArea {
		anchors.fill: parent
		onClicked: { button.clicked() }
		onPressed: { parent.pressed = true }
		onReleased: { parent.pressed = false }
	}
}
