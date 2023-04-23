import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5

ApplicationWindow {
	id: root
    visible: true
	width: 400
    height: 600
    title: "Sharo Console"
    flags: Qt.Window
	property color bg_color: "black"		
	property color fg_color: "#FF6A00"			
	property color fg_darker_color: "#7f3500"			
	property color cool_color: "#BF4E00"
	property color border_color: "#FF6A00"
	FontLoader {
		id: ethnocentric
		source: "ethnocentric.otf"
	}
	Loading {
		visible: manager.loading
	}	
	ColumnLayout {
		id: rootLayout
		visible: !manager.loading
		Keys.onPressed: (event) => controls.onKeyPressed(event)
		Keys.onReleased: (event) => controls.onKeyReleased(event)
		layer.enabled: true
		layer.samples: 16
		anchors.fill: parent			
		spacing: 0
		Topbar {
			Layout.preferredWidth: parent.width
			Layout.preferredHeight: parent.height / 12
			Layout.fillWidth: true
		}
		RowLayout {
			spacing: 0
			Layout.preferredWidth: parent.width
			Layout.preferredHeight: parent.height * 8 / 12
			Layout.fillHeight: true
			Video {
				id: video
			}
			Controls {
				id: controls
			}
		}
		Bottombar {
			Layout.preferredWidth: parent.width
			Layout.preferredHeight: parent.height * 3 / 12
			Layout.fillWidth: true
		}
	}
}

