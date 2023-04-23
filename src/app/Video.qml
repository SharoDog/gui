import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5
import QtMultimedia 6.5


Rectangle {
	id: video
	color: root.bg_color
	border.color: root.border_color
	border.width: videoMouse.hovered ? 3 : 1
	Layout.preferredWidth: 1
	Layout.fillWidth: true
	Layout.fillHeight: true
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
	Image {
        id: feedImage
		visible: manager.connected
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectFit
        cache: false
        source: "image://ImageProvider/img"
        property bool counter: false

        function reloadImage() {
            counter = !counter
            source = "image://ImageProvider/img?id=" + counter
        }
    } 

    Connections {
        target: imageProvider
        function onImageChanged(image) {
            feedImage.reloadImage()
        }        
    }
}

