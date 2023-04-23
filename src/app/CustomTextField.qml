import QtQuick 6.5
import QtQuick.Shapes 6.5
import QtQuick.Controls 6.5

TextField {
	id: "field"
	color: root.fg_color
	selectionColor: root.fg_color
	selectedTextColor: root.bg_color
	font.family: ethnocentric.font.family	
	font.pixelSize: 24
	text: "10.42.0.1"
	leftPadding: field.height / 4
	topPadding: 2
	bottomPadding: 2
	background: Shape {
		ShapePath {
			strokeWidth: 3
			strokeColor: root.border_color
			fillColor: "transparent"
			startX: 0; startY: field.height / 4
			PathLine { x: field.height / 2; y: 0 }
			PathLine { x: field.width; y: 0 }	
			PathLine { x: field.width; y: field.height * 3 / 4 }	
			PathLine { x: field.width - field.height / 2; y: field.height }	
			PathLine { x: 0; y: field.height }	
			PathLine { x: 0; y: field.height / 4 }	
		}
	}
}
