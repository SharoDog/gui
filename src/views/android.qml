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
	property color cool_color: "#BF4E00"
	property color border_color: "#FF6A00"
	property int border_width: 3
	FontLoader {
		id: ethnocentric
		source: "ethnocentric.otf"
	}
	Loading {
		visible: manager.loading
	}	
	Rectangle {
		id: app
		anchors.fill: parent			
		border.color: root.border_color
		border.width: root.border_width
		SplitView {
			id: rootLayout
			orientation: Qt.Vertical
			handle: Separator {
				horizontal: true
			}
			visible: !manager.loading
			Keys.onPressed: (event) => main.onKeyPressed(event)
			Keys.onReleased: (event) => main.onKeyReleased(event)
			layer.enabled: true
			layer.samples: 16
			anchors.fill: parent			
			anchors.margins: root.border_width
			spacing: 0
			Topbar {
				SplitView.preferredHeight: parent.height / 12
				SplitView.fillWidth: true
			}
			Main {
				id: main
				SplitView.fillWidth: true
				SplitView.fillHeight: true
			}
			BottomBar {
				SplitView.preferredHeight: parent.height * 3 / 12
				SplitView.fillWidth: true
			}
		}
	}
}

