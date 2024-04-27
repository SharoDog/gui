import QtQuick 6.6
import QtQuick.Controls 6.6
import QtQuick.Layouts 6.6
import QtQuick.Dialogs 6.6

CustomPane {
	id: code
	focusPolicy: Qt.ClickFocus
	ColumnLayout{
		anchors.fill: parent
		anchors.margins: 20
		spacing: 10
		RowLayout {
			spacing: 10
			CustomButton {
				text: "Save"
				onClicked: saveDialog.open()
			}
			CustomButton {
				text: "Open"
				onClicked: openDialog.open()
			}
			CustomButton {
				text: (manager.connected && manager.code) ? "Stop" : "Run"
				visible: manager.connected
				onClicked: manager.code ? manager.sendCommand(qsTr("stand")) : manager.sendCommand(qsTr("code:") + input.text)
			}
			CustomText {
				text: "Not connected"
				visible: !manager.connected
			}
		}	
		FileDialog {
			id: openDialog
			title: "Choose a file"
			nameFilters: ["Python (*.py)"]
			onAccepted: {
				input.text = manager.openFile(openDialog.selectedFile)
				visible = false
			}
		}	
		FileDialog {
			id: saveDialog
			title: "Save file"
			acceptLabel: "Save"
			fileMode: FileDialog.SaveFile
			defaultSuffix: "py"
			nameFilters: ["Python files (*.py)"]
			onAccepted: {
				manager.saveFile(saveDialog.selectedFile, input.text)
				visible = false
			}
		}
		ScrollView {
			id: scrollView
			Layout.fillWidth: true
			Layout.fillHeight: true
			TextArea {
				id: input
				placeholderText: "# Write your code here or open an existing file"
				placeholderTextColor: Qt.tint(root.fg_color, "#48000000")
				color: root.fg_color
				font.pixelSize: 3 * root.ratio
				smooth: true
			}	
			ScrollBar.vertical: ScrollBar {
				parent: scrollView
				x: scrollView.width - width
				y: scrollView.topPadding	
				z: 1 
				visible: parent.height < parent.contentHeight
                contentItem: Rectangle {
                    implicitWidth: 6
                    implicitHeight: scrollView.availableHeight - 6 * 2
                    radius: width/2
                    color: parent.pressed ? Qt.darker(root.fg_color) : root.fg_color
                }
			}
			ScrollBar.horizontal: ScrollBar {
				parent: scrollView
				x: scrollView.leftPadding	
				y: scrollView.height - height
				z: 1
				visible: parent.width < parent.contentWidth
                contentItem: Rectangle {
                    implicitHeight: 6
                    implicitWidth: scrollView.availableWidth - 6 * 2
                    radius: height / 2
                    color: parent.pressed ? Qt.darker(root.fg_color) : root.fg_color
                }
			}
		}
	}
}
