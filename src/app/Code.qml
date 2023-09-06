import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5

Pane {
	id: code
	background: Rectangle {
		color: root.bg_color
	}
	focusPolicy: Qt.ClickFocus
	ColumnLayout{
		anchors.fill: parent
		anchors.margins: 20
		spacing: 10
		RowLayout {
			spacing: 10
			CustomButton {
				text: "Save..."
				onClicked: console.log("Saved")
			}
			CustomButton {
				text: "Open..."
				onClicked: console.log("Open")
			}
			CustomButton {
				text: "Run..."
				onClicked: console.log("Running")
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
				font.family: ethnocentric.font.family
				font.pixelSize: 12
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
