import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5
import QtMultimedia 6.5


Rectangle {
	id: video
	color: root.bg_color
	HoverHandler {
		id: videoMouse
		cursorShape: Qt.CrossCursor
	}
	Text {
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		visible: !manager.connected
		text: "No Video"
		color: fg_color
		font.family: ethnocentric.font.family
		font.pixelSize: 24
		smooth: true
	}    
	ColumnLayout {
		visible: manager.connected
		anchors.fill: parent
		anchors.bottomMargin: 15
		Image {
			id: feedImage
			Layout.fillWidth: true
			Layout.fillHeight: true
			fillMode: Image.PreserveAspectFit
			cache: false
			source: "image://ImageProvider/img"
			property bool counter: false

			function reloadImage() {
				counter = !counter
				source = "image://ImageProvider/img?id=" + counter
			}
		} 
		RowLayout {
			Layout.alignment: Qt.AlignHCenter
			spacing: 10
			CustomButton {
				text: "Photo"
				onClicked: imageProvider.takePicture()
			}
			ToggleButton {
				text: "Record"
			}
		}
	}

    Connections {
        target: imageProvider
        function onImageChanged(image) {
            feedImage.reloadImage()
        }        
    }
}

