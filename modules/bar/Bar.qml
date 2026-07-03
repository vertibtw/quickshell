import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.modules.bar.components
import qs.modules.bar.components.brightness
import qs.modules.bar.components.volume

Item {
    id: root
    width: childrenRect.width
    height: childrenRect.height
    required property var wallpapermod 

    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property var modelData
            screen: modelData

            id: bar

            visible: States.bar_visible

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: screen.height * 0.02
            color: Colors.background

            Brightness {
                id: brightness_popup
                parentWindow: bar
            }

            Volume {
                id: vol_popup
                parentWindow: bar
            }

            Rectangle {
                implicitHeight: rl.implicitHeight 
                implicitWidth: rl.implicitWidth + 20 // +20 for padding

                anchors.left: parent.left
                anchors.leftMargin: 4

                anchors.verticalCenter: parent.verticalCenter

                color: Colors.background2
                radius: Math.max(height, width) / 2
                Row {
                    id: rl
                    anchors.left: parent.left
                    spacing: 6
                    anchors.centerIn: parent

                    // components
                    RandomWallpaper { wal: root.wallpapermod }
                    Screenshot {}
                    Media {}
                    Workspaces {}
                }
            }

            Row {
                spacing: 4
                anchors.centerIn: parent

                // components
                // Workspaces {}
            }

            Rectangle {
                implicitHeight: rr.implicitHeight 
                implicitWidth: rr.implicitWidth + 20 // +20 for padding

                anchors.right: parent.right
                anchors.rightMargin: 4

                anchors.verticalCenter: parent.verticalCenter

                color: Colors.background2
                radius: Math.max(height, width) / 2

                Row {
                    id: rr
                    spacing: 6
                    anchors.centerIn: parent
                    Clock {}
                    Tray {parentwindow: bar}
                    BrightnessButton{brightness_popup: brightness_popup}
                    VolumeButton {volwidget: vol_popup}
                    Battery {}
                }
            }
        }
    }
}