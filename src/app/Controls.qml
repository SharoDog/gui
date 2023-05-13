import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5

Rectangle {
	id: controls
	color: bg_color
	HoverHandler {
		id: controlsMouse
	}	
	function onKeyPressed(event) {
		if (manager.connected) {
			switch (event.key) {
				case Qt.Key_Up:
					forwardButton.pressed = true	
					break
				case Qt.Key_Down:
					backwardButton.pressed = true	
					break
				case Qt.Key_Left:
					leftButton.pressed = true	
					break
				case Qt.Key_Right:
					rightButton.pressed = true	
					break
				case Qt.Key_PageUp:
					counterclockwiseButton.pressed = true	
					break
				case Qt.Key_PageDown:
					clockwiseButton.pressed = true	
					break
				case Qt.Key_C:
					sitButton.pressed = true	
					break
				case Qt.Key_Space:
					standButton.pressed = true	
					break
				case Qt.Key_X:
					lieButton.pressed = true	
					break
				case Qt.Key_1:
					emote1Button.pressed = true	
					break
				case Qt.Key_2:
					emote2Button.pressed = true	
					break
				case Qt.Key_3:
					emote3Button.pressed = true	
					break
				case Qt.Key_4:
					emote4Button.pressed = true
					break
			}			
		}
	}
	function onKeyReleased(event) {
		if (manager.connected) {
			switch (event.key) {
				case Qt.Key_Up:
					forwardButton.pressed = false	
					manager.sendCommand("forward")
					break
				case Qt.Key_Down:
					backwardButton.pressed = false	
					manager.sendCommand("backward")
					break
				case Qt.Key_Left:
					leftButton.pressed = false	
					manager.sendCommand("left")
					break
				case Qt.Key_Right:
					rightButton.pressed = false	
					manager.sendCommand("right")
					break
				case Qt.Key_PageUp:
					counterclockwiseButton.pressed = false	
					manager.sendCommand("counterclockwise")
					break
				case Qt.Key_PageDown:
					clockwiseButton.pressed = false	
					manager.sendCommand("clockwise")
					break
				case Qt.Key_C:
					sitButton.pressed = false	
					manager.sendCommand("sit")
					break
				case Qt.Key_Space:
					standButton.pressed = false	
					manager.sendCommand("stand")
					break
				case Qt.Key_X:
					lieButton.pressed = false	
					manager.sendCommand("lie")
					break
				case Qt.Key_1:
					emote1Button.pressed = false	
					manager.sendCommand("emote1")
					break
				case Qt.Key_2:
					emote2Button.pressed = false	
					manager.sendCommand("emote2")
					break
				case Qt.Key_3:
					emote3Button.pressed = false	
					manager.sendCommand("emote3")
					break
				case Qt.Key_4:
					emote4Button.pressed = false	
					manager.sendCommand("emote4")
					break
			}
		}
	}
	Text {
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		visible: !manager.connected
		text: "Not Connected"
		color: fg_color
		font.family: ethnocentric.font.family
		font.pixelSize: 24
		smooth: true
	}
	ColumnLayout {
		visible: manager.connected
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		spacing: 20
		CustomText {
			text: qsTr("Cmd: ") + manager.command
			size: 24
		}
		CustomText {
			text: qsTr("Steering: ") + manager.steering.toFixed(2)
			size: 24
		}
		CustomText {
			text: qsTr("Speed: ") + manager.speed.toFixed(2)
			size: 24
		}
		RowLayout {
			spacing: 10
			Layout.alignment: Qt.AlignHCenter
			CustomButton {
				id: "sitButton"
				text: "Sit"
				onClicked: manager.sendCommand("sit")
			}
			CustomButton {
				id: "standButton"
				text: "Stand"
				onClicked: manager.sendCommand("stand")
			}
			CustomButton {
				id: "lieButton"
				text: "Lie"
				onClicked: manager.sendCommand("lie")
			}	
		}
		RowLayout {
			spacing: 10
			Layout.alignment: Qt.AlignHCenter
			CustomButton {
				id: "emote1Button"
				text: "Emote 1"
				onClicked: manager.sendCommand("emote1")
			}
			CustomButton {
				id: "emote2Button"
				text: "Emote 2"
				onClicked: manager.sendCommand("emote2")
			}		
		}
		RowLayout {
			spacing: 10
			Layout.alignment: Qt.AlignHCenter
			CustomButton {
				id: "emote3Button"
				text: "Emote 3"
				onClicked: manager.sendCommand("emote3")
			}
			CustomButton {
				id: "emote4Button"
				text: "Emote 4"
				onClicked: manager.sendCommand("emote4")
			}
		}
		CustomButton {
			id: "offRoadWalkButton"
			text: "Off Road"
			onClicked: manager.sendCommand("off road")
			Layout.alignment: Qt.AlignHCenter
		}
		ColumnLayout {
			Layout.alignment: Qt.AlignHCenter
			Layout.fillWidth: false
			spacing: 20
			GridLayout {
				rowSpacing: 10
				columnSpacing: 10
				rows: 2
				columns: 3
				Layout.alignment: Qt.AlignHCenter
				ArrowButton {
					id: "counterclockwiseButton"
					text: String.fromCodePoint(0x21BA)
					onClicked: manager.sendCommand("counterclockwise")
				}
				ArrowButton {
					id: "forwardButton"
					text: String.fromCodePoint(0x2191)
					onClicked: manager.sendCommand("forward")
				}
				ArrowButton {
					id: "clockwiseButton"
					text: String.fromCodePoint(0x21BB)
					onClicked: manager.sendCommand("clockwise")
				}	
				ArrowButton {
					id: "leftButton"
					text: String.fromCodePoint(0x2190)
					onClicked: manager.sendCommand("left")
				}
				ArrowButton {
					id: "backwardButton"
					text: String.fromCodePoint(0x2193)
					onClicked: manager.sendCommand("backward")
				}
				ArrowButton {
					id: "rightButton"
					text: String.fromCodePoint(0x2192)
					onClicked: manager.sendCommand("right")
				}
			}
			ColumnLayout {
				Layout.fillWidth: true
				CustomText {
					text: "Steering:"	
					size: 20
				}
				CustomSlider {
					id: steeringSlider
					Layout.fillWidth: true
					from: -1
					to: 1
					onMoved: manager.updateSteering(steeringSlider.value)
				}
				CustomText {
					text: "Speed:"	
					size: 20
				}
				CustomSlider {
					id: speedSlider
					Layout.fillWidth: true
					initialValue: 1
					from: 0.5
					to: 2
					onMoved: manager.updateSpeed(speedSlider.value)
				}				
			}
			ToggleButton {
				id: "sensorsButton"
				text: "Sensors"
				onClicked: manager.toggleSensors(sensorsButton.pressed)
				Layout.alignment: Qt.AlignHCenter
			}
		}
	}
}
