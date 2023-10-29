import QtQuick 6.6
import QtQuick.Shapes 6.6
import QtQuick.Controls 6.6

Shape {
	id: "button"
	property alias text: content.text
	property alias pixelSize: content.font.pixelSize
	property bool pressed: false
	signal clicked
	CustomText {
		anchors.verticalCenter: parent.verticalCenter
		anchors.horizontalCenter: parent.horizontalCenter
		id: "content"
		text: "Text"
		color: button.pressed ? root.bg_color : root.fg_color
		verticalAlignment: Text.AlignVCenter
	}
	height: content.contentHeight * 3 / 2
	width: content.contentWidth + content.contentHeight * 3 / 4
	ShapePath {
		strokeWidth: 3
		strokeColor: root.border_color
		fillColor: button.pressed ? root.border_color : "transparent"
		startX: 0; startY: button.height / 4
		PathLine { x: button.height / 2; y: 0 }
		PathLine { x: button.width; y: 0 }	
		PathLine { x: button.width; y: button.height * 3 / 4 }	
		PathLine { x: button.width - button.height / 2; y: button.height }	
		PathLine { x: 0; y: button.height }	
		PathLine { x: 0; y: button.height / 4 }	
	}
	MouseArea {
		id: mouse
		anchors.fill: parent
		onClicked: { button.clicked() }
		onPressed: { button.pressed = true; }
		onReleased: { button.pressed = false; }
	}
}
