// modified https://github.com/quickshell-mirror/quickshell-examples/blob/master/volume-osd/shell.qml
import qs
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Scope {
	id: root

	PwObjectTracker {
		objects: [ Pipewire.defaultAudioSink ]
	}

	Connections {
		target: Pipewire.defaultAudioSink?.audio

		function onVolumeChanged() {
			root.shouldShowOsd = true;
			hideTimer.restart();
		}
	}

	property bool shouldShowOsd: false
    property double vol: Pipewire.defaultAudioSink?.audio.volume * 100 ?? 0

	Timer {
		id: hideTimer
		interval: 500
		onTriggered: root.shouldShowOsd = false
	}

	LazyLoader {
		active: root.shouldShowOsd && States.bar_vol_popup_visible

		PanelWindow {
			anchors.bottom: true
			margins.bottom: screen.height / 10
			exclusiveZone: 0

			implicitWidth: 400
			implicitHeight: 50
			color: "transparent"

			mask: Region {}

			Rectangle {
				anchors.fill: parent
				radius: height / 2
				color: Colors.background

				RowLayout {
					anchors {
						fill: parent
						leftMargin: 10
						rightMargin: 15
					}

                    Text {
                        text: {
                            if (root.vol === 0) {
                                return "󰝟"
                            } else if (root.vol <= 30) {
                                return "󰕿"
                            } else if (root.vol <= 60) {
                                return "󰖀"
                            } else if (root.vol <= 100) {
                                return "󰕾"
                            }
                        }
                        color: Colors.foreground
                        font.pixelSize: 30
                    }

					Rectangle {
						Layout.fillWidth: true

						implicitHeight: 10
						radius: 20
						color: Colors.grey

						Rectangle {
							anchors {
								left: parent.left
								top: parent.top
								bottom: parent.bottom
							}

							implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
							radius: parent.radius
						}
					}
				}
			}
		}
	}
}