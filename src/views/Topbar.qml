import QtQuick 6.6
import QtQuick.Controls 6.6
import QtQuick.Layouts 6.6
	
Rectangle {
	id: ip
	color: root.bg_color
	HoverHandler {
		id: ipHoverHandler
	}
	RowLayout {
		anchors.fill: parent
		anchors.margins: root.height / 100
		Item {
			Layout.fillWidth: true
			Layout.fillHeight: true
			Layout.rightMargin: parent.width / 8
			GridLayout {
				anchors.fill: parent
				columnSpacing: parent.width / 80
				rowSpacing: 0
				flow: root.vertical ? GridLayout.TopToBottom : GridLayout.LeftToRight
				CustomText {
					Layout.fillWidth: root.vertical ? true : false
					Layout.fillHeight: root.vertical ? false : true
					Layout.preferredHeight: root.vertical ? parent.height / 3 : -1
					id: "iptext"
					text: "IP Address:"
					font.pixelSize: 24
					fontSizeMode: Text.VerticalFit
					verticalAlignment: Text.AlignVCenter
				}
				CustomTextField {
					id: "textField"
					Layout.fillHeight: root.vertical ? false : true
					Layout.fillWidth: true
					Layout.preferredHeight: root.vertical ? parent.height / 2 : -1
					Layout.maximumHeight: root.vertical ? -1 : 50
					enabled: !manager.connected
					font.pixelSize: iptext.fontInfo.pixelSize
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
		}
		CustomButton {
			Layout.alignment: Qt.AlignVCenter
			Layout.minimumWidth: connectButton.width
			id: connectButton
			pixelSize: iptext.fontInfo.pixelSize
			text: !manager.connected ? "Connect" : "Disconnect"
			onClicked: { mainLoader.focus = true; textField.focus = false; manager.establishConnection(textField.text); }
		}
	}
}

