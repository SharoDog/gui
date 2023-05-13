import QtQuick 6.5
import QtQuick.Controls 6.5

Rectangle {
	property bool horizontal
	id: handle
	implicitWidth: 4
	implicitHeight: 4
	color: SplitHandle.pressed ? root.fg_darker_color
		: (SplitHandle.hovered ? Qt.darker(root.fg_color) : root.fg_color)
	containmentMask: Item {
		width: handle.width * (horizontal ? 1 : 5)
		height: handle.height * (horizontal ? 5 : 1)
		x: (handle.width - width) / 2
		y: (handle.height - height) / 2
	}
}
