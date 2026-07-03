import qs
import Quickshell
import QtQuick

Item {
    id: ss

    implicitHeight: btn.height
    implicitWidth: btn.width

    Rectangle {
        id: btn
        implicitHeight: icon.height
        implicitWidth: icon.width

        color: "transparent"
        
        Text {
            id: icon
            color: Colors.foreground
            font.pixelSize: 15
            text: "󰩭"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    Quickshell.execDetached([
                        "sh",
                        "-c",
                        'grim -g "$(slurp)" - | convert - -resize 200% png:- | wl-copy'
                    ])
                }
            }
        }    
    }
}