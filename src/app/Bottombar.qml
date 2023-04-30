import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5

Item {
	RowLayout {
		spacing: 0
		anchors.fill: parent
		Rectangle {
			id: left
			color: root.bg_color
			Layout.preferredWidth: parent.width / 3
			Layout.preferredHeight: parent.height
			border.color: root.border_color
			border.width: leftMouse.hovered ? 3 : 1
			HoverHandler {
				id: leftMouse
			}
			ColumnLayout {
				spacing: 2
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter
				CustomText {
					text: "Attitude"
					size: 36
					Layout.alignment: Qt.AlignHCenter
				}
				CustomText {
					text: "No Data"
					visible: !manager.connected || !manager.attData
					size: 24
					Layout.alignment: Qt.AlignHCenter
				}
				ColumnLayout {
					Layout.alignment: Qt.AlignHCenter
					visible: manager.connected && manager.attData
					CustomText {
						visible: false
						text: qsTr("Heading: ") + manager.heading.toFixed(2) + String.fromCodePoint(0x00B0)
						size: 24
					}
					CustomText {
						text: qsTr("Pitch:      ") + manager.pitch.toFixed(2) + String.fromCodePoint(0x00B0)
						size: 24
					}
					CustomText {
						text: qsTr("Roll:       ") + manager.roll.toFixed(2) + String.fromCodePoint(0x00B0)
						size: 24
					}								
				}
			}
		}
		Rectangle {
			id: mid
			color: root.bg_color
			Layout.preferredWidth: parent.width / 3
			Layout.preferredHeight: parent.height
			border.color: root.border_color
			border.width: midMouse.hovered ? 3 : 1
			HoverHandler {
				id: midMouse
			}
			ColumnLayout {
				spacing: 2
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter
				Text {
					text: "Sharo"
					color: root.fg_color
					font.family: ethnocentric.font.family
					font.pixelSize: 48
					smooth: true
					Layout.alignment: Qt.AlignHCenter
				}
				Text {
					text: "Operator Console"
					color: root.fg_color
					font.family: ethnocentric.font.family
					font.italic: true
					font.pixelSize: 16
					smooth: true
					Layout.alignment: Qt.AlignHCenter
				}						
			}		
		}
		Rectangle {
			id: right
			color: root.bg_color
			Layout.preferredWidth: parent.width / 3
			Layout.preferredHeight: parent.height
			border.color: root.border_color
			border.width: rightMouse.hovered ? 3 : 1
			HoverHandler {
				id: rightMouse
			}
			ColumnLayout {
				spacing: 2
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter
				CustomText {
					text: "GPS"
					size: 36
					Layout.alignment: Qt.AlignHCenter
				}
				CustomText {
					text: "No Signal"
					visible: !manager.connected || !manager.gpsSignal
					size: 24
					Layout.alignment: Qt.AlignHCenter
				}
				ColumnLayout {
					Layout.alignment: Qt.AlignHCenter
					visible: manager.connected && manager.gpsSignal
					CustomText {
						text: qsTr("Lat: ") + manager.lat.toFixed(2) + String.fromCodePoint(0x00B0)
						size: 24
					}
					CustomText {
						text: qsTr("Lon: ") + manager.lon.toFixed(2) + String.fromCodePoint(0x00B0)
						size: 24
					}
					CustomText {
						text: qsTr("Alt: ") + manager.alt.toFixed(2) + qsTr("m")
						size: 24
					}								
				}						
			}
		}
	}
}
