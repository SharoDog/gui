import QtQuick 6.6 
import QtQuick.Controls 6.6

SplitView {
	spacing: 0
	handle: Separator {
		horizontal: false
	}
	Video {
		id: video
		SplitView.preferredWidth: parent.width / 2
		SplitView.fillWidth: true
		SplitView.fillHeight: true
	}
	Main {
		id: main
		SplitView.preferredWidth: parent.width / 2
		SplitView.fillHeight: true
	}
}

