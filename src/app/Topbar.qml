import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5
	
Rectangle {
	id: ip
	color: bg_color
	border.color: root.border_color
	border.width: ipHoverHandler.hovered ? 3 : 1
	HoverHandler {
		id: ipHoverHandler
	}
	Item {
		anchors.fill: parent
		anchors.margins: 20
		Layout.alignment: Qt.AlignVCenter
		RowLayout {
			anchors.fill: parent
			anchors.rightMargin: parent.width * 3 / 8
			spacing: parent.width / 80
			CustomText {
				text: "IP Address:"
				Layout.fillWidth: false
				size: 24
			}
			CustomTextField {
				id: "textField"
				Layout.fillWidth: true
				enabled: !manager.connected
				Keys.onPressed: (event) => { 
					if (event.key == Qt.Key_Return) {
						connectButton.pressed = true
					}
				}
				Keys.onReleased: (event) => { 
					if (event.key == Qt.Key_Return) {
						connectButton.pressed = false
						connectButton.clicked()
					}
				}
			}
		}
		Item {
			width: connectButton.width
			height: connectButton.height
			anchors.right: parent.right
			anchors.verticalCenter: parent.verticalCenter
			CustomButton {
				Layout.alignment: Qt.AlignVCenter
				id: connectButton
				text: !manager.connected ? "Connect" : "Disconnect"
				onClicked: { rootLayout.focus = true; textField.focus = false; manager.establish_connection(textField.text); }
			}
		}
	}
}
