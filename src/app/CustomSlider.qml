import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5

Item {
	id: slider
	implicitHeight: 26
	property alias from: control.from
	property alias to: control.to
	property real initialValue: 0.0
	property alias value: control.value
	signal moved
	RowLayout {
		anchors.fill: parent
		Slider {
			id: control
			value: initialValue
			implicitWidth: parent.width
			implicitHeight: 10
			stepSize: 0.05
			snapMode: Slider.SnapAlways
			onMoved: slider.moved()
			background: Rectangle {
				x: control.leftPadding
				y: control.topPadding + control.availableHeight / 2 - height / 2
				implicitWidth: parent.width
				implicitHeight: 10
				radius: 2
				color: root.fg_darker_color

				Rectangle {
					width: control.visualPosition * parent.width
					height: parent.height
					color: root.fg_color
					radius: 2
				}
			}

			handle: Rectangle {
				x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
				y: control.topPadding + control.availableHeight / 2 - height / 2
				implicitWidth: 26
				implicitHeight: 26
				radius: 13
				color: root.fg_color
				border.width: 2
				border.color: root.border_color		
			}
		}
	}
}
