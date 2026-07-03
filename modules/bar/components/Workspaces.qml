import qs
import qs.modules.bar

import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

Item {
    id: root
    implicitWidth: bg.childrenRect.width + 20 // +20 is for 10px margins on each side of the thing
    implicitHeight: bg.childrenRect.height
    anchors.verticalCenter: parent.verticalCenter

    Rectangle {
        id: bg
        anchors.fill: parent

        color: Colors.background2 
        radius: Math.max(height, width) / 2

        Row {
            spacing: 4
            anchors.verticalCenter: parent.verticalCenter
            anchors.centerIn: parent // so the margins work

            Repeater {
                model: Hyprland.workspaces
                delegate: Rectangle {
                    id: workspace
                    required property HyprlandWorkspace modelData

                    property bool idVisible: false;

                    implicitWidth: modelData.focused ? 48 : 24
                    implicitHeight: bar.height / 2 

                    radius: Math.max(height, width) / 2

                    color: modelData.focused ? Colors.blue : Colors.grey

                    Text {
                        anchors.centerIn: parent

                        text: workspace.modelData.id
                        visible: workspace.idVisible
                        color: parent.modelData.focused ? Colors.background : Colors.foreground // ying yang or something
                    }

                    Behavior on implicitWidth {
                        NumberAnimation {
                            duration: 150
                            easing.type: Easing.InCubic
                        }
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            workspace.idVisible = true;
                        }
                        onExited: {
                            workspace.idVisible = false;
                        }
                        onClicked: {
                            Hyprland.dispatch("hl.dsp.focus({ workspace = " + workspace.modelData.id + "})");
                        }
                    }
                } 
            } 
        }
    }
}