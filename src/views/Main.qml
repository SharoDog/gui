import QtQuick 6.6
import QtQuick.Controls 6.6
import QtQuick.Layouts 6.6

ColumnLayout {
	id: main
	focus: true
	Keys.onPressed: (event) => {
		if (tabbar.currentIndex == 0) {
			controlsTab.onKeyPressed(event);	
		}
	}
	Keys.onReleased: (event) => {
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
			parent.forceActiveFocus()
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
