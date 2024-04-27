import QtQuick 6.6
import QtQuick.Controls 6.6
import QtQuick.Layouts 6.6

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
	property bool vertical: root.width < root.height
	property int refDpi: 96
	property int lWidth: 1280
	property int mWidth: 800
	property int sWidth: 300
	property int ratio: 1
	function calcRatio () {
		ratio = 1
		if (root.width >= sWidth) {
			ratio = 2
		}
		if (root.width >= mWidth) {
			ratio = 3
		}
		if (root.width >= lWidth) {
			ratio = 4
		}
	}
	onWidthChanged: calcRatio()
	// onHeightChanged: calcRatio()
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
			layer.enabled: true
			layer.samples: 16
			anchors.fill: parent			
			anchors.margins: root.border_width
			spacing: 0
			Topbar {
				SplitView.preferredHeight: parent.height / 12
				SplitView.minimumHeight: 60
				SplitView.maximumHeight: 80
				SplitView.fillWidth: true
			}
			Loader {
				id: mainLoader
				SplitView.preferredHeight: parent.height * 8 / 12
				SplitView.fillWidth: true
				SplitView.fillHeight: true
				source: (Qt.platform.os == "android") ? "Android.qml" : "Desktop.qml"
			}
			BottomBar {
				// visible: Qt.platform.os != "android"
				SplitView.preferredHeight: parent.height * 3 / 12
				SplitView.fillWidth: true
			}
		}
	}
}

