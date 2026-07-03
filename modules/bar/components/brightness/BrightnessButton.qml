import qs

import Quickshell
import QtQuick

Item {
    id: root
    height: icon.height
    width: icon.width

    property var brightness_popup

    Text {
        id: icon
        text: "󰖨"
        color: Colors.foreground
        MouseArea {
            anchors.fill: parent
            onClicked : {
                console.log("visible", brightness_popup.visible)
                brightness_popup.visible = !brightness_popup.visible
            }
        }
    }
}