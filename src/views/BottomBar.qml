import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5

Item {
	SplitView {
		spacing: 0
		 handle: Separator {
			 horizontal: false
		 }
		anchors.fill: parent
		Rectangle {
			id: left
			color: root.bg_color
			SplitView.preferredWidth: parent.width / 3
			SplitView.fillHeight: true
			HoverHandler {
				id: leftMouse
			}
			ColumnLayout {
				spacing: 2
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter
				CustomText {
					text: "Attitude"
					font.pointSize: 16
					Layout.alignment: Qt.AlignHCenter
				}
				CustomText {
					text: "No Data"
					visible: !manager.connected || !manager.attData
					Layout.alignment: Qt.AlignHCenter
				}
				ColumnLayout {
					Layout.alignment: Qt.AlignHCenter
					visible: manager.connected && manager.attData
					CustomText {
						visible: false
						text: qsTr("Heading: ") + manager.heading.toFixed(2) + String.fromCodePoint(0x00B0)
					}
					CustomText {
						text: qsTr("Pitch:      ") + manager.pitch.toFixed(2) + String.fromCodePoint(0x00B0)
					}
					CustomText {
						text: qsTr("Roll:       ") + manager.roll.toFixed(2) + String.fromCodePoint(0x00B0)
					}								
				}
			}
		}
		Rectangle {
			id: mid
			color: root.bg_color
			SplitView.preferredWidth: parent.width / 3
			SplitView.fillWidth: true
			SplitView.fillHeight: true
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
					font.pointSize: 24
					smooth: true
					Layout.alignment: Qt.AlignHCenter
				}
				Text {
					text: "Operator Console"
					color: root.fg_color
					font.family: ethnocentric.font.family
					font.italic: true
					font.pointSize: 8
					smooth: true
					Layout.alignment: Qt.AlignHCenter
				}						
			}		
		}
		Rectangle {
			id: right
			color: root.bg_color
			SplitView.preferredWidth: parent.width / 3
			SplitView.fillHeight: true
			HoverHandler {
				id: rightMouse
			}
			ColumnLayout {
				spacing: 2
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter
				CustomText {
					text: "GPS"
					font.pointSize: 16
					Layout.alignment: Qt.AlignHCenter
				}
				CustomText {
					text: "No Signal"
					visible: !manager.connected || !manager.gpsSignal
					Layout.alignment: Qt.AlignHCenter
				}
				ColumnLayout {
					Layout.alignment: Qt.AlignHCenter
					visible: manager.connected && manager.gpsSignal
					CustomText {
						text: qsTr("Lat: ") + manager.lat.toFixed(2) + String.fromCodePoint(0x00B0)
					}
					CustomText {
						text: qsTr("Lon: ") + manager.lon.toFixed(2) + String.fromCodePoint(0x00B0)
					}
					CustomText {
						text: qsTr("Alt: ") + manager.alt.toFixed(2) + qsTr("m")
					}								
				}						
			}
		}
	}
}
