import QtQuick 6.6
import QtQuick.Controls 6.6
import QtQuick.Layouts 6.6
import QtMultimedia 6.6


Rectangle {
	id: video
	color: root.bg_color
	HoverHandler {
		id: videoMouse
		cursorShape: Qt.CrossCursor
	}
	CustomText {
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		visible: !manager.connected
		text: "No Video"
		font.pointSize: 16
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
				id: videoButton
				text: "Record"
				onClicked: imageProvider.toggleRecord(videoButton.pressed)
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

