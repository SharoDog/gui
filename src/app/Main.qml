import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5

Rectangle {
	id: main
	function onKeyPressed(event) { console.log("Test") }
	function onKeyReleased(event) { console.log("Test2") }
	ColumnLayout {
		anchors.fill: parent
		spacing: 0
		CustomTabBar {
			id: tabbar	
			Layout.fillWidth: true	
			model: ["Controls", "Code", "Blocks"]
		}
		StackLayout {
			Layout.fillWidth: true
			Layout.fillHeight: true
			currentIndex: tabbar.currentIndex
			Controls {
				id: controlsTab
				Layout.fillWidth: true
				Layout.fillHeight: true
			}
			Code {
				id: codeTab
				Layout.fillWidth: true
				Layout.fillHeight: true
			}
			Blocks {
				id: blocksTab
				Layout.fillWidth: true
				Layout.fillHeight: true
			}
		}
	}
}
