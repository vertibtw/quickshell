import QtQuick
import Quickshell

import qs

Rectangle {
    id: root
    required property string label
    required property string shader
    required property bool active

    implicitHeight: labelText.contentHeight * 1.2
    implicitWidth: labelText.contentWidth * 1.2
    color: active ? Colors.mauve : "transparent"

    Text {
        id: labelText
        text: parent.label
        anchors.centerIn: parent
        color: parent.active ? Colors.background : Colors.foreground
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.parent.activeshader = root.shader
            Quickshell.execDetached([
                "sh", "-c",
                `hyprctl eval 'hl.config({ decoration = { screen_shader = "${parent.shader}" } })'`
            ])
        }
    }
}