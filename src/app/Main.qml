import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts 6.5

ColumnLayout {
	id: main
	function onKeyPressed(event) { 
		if (tabbar.currentIndex == 0) {
			controlsTab.onKeyPressed(event);	
		}
	}
	function onKeyReleased(event) { 
		if (tabbar.currentIndex == 0) {
			controlsTab.onKeyReleased(event);	
		}
	}
	spacing: 0
	CustomTabBar {
		id: tabbar	
		Layout.fillWidth: true	
		model: ["Controls", "Code", "Blocks"]				
		onCurrentIndexChanged: {
			parent.parent.forceActiveFocus()
		}
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
