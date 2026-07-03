// TODO: brightness control
import qs
import Quickshell
import Quickshell.Io
import QtQuick

PopupWindow {
    id: popup
    required property var parentWindow
    visible: false
    
    implicitHeight: items.height 
    implicitWidth: items.width 

    anchor.window: parentWindow
    anchor.rect.x: parentWindow.width 
    anchor.rect.y: parentWindow.height * 1.1   
    grabFocus: true

    color: "transparent"

    // to highlight the correct one after shell reload or whatever
    // doesn't work if you run the command manuall, but who the fuck does that anyway
    Process {
        command: ["sh", "-c", "hyprctl -j getoption decoration:screen_shader"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                var obj = JSON.parse(this.text)
                items.activeshader = obj.str
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: Colors.background
        Column {
            id: items
            property string activeshader: ""
            spacing: 4
            padding: 4

            ShaderButton {
                label: "no filter"
                shader: ""
                active: items.activeshader === shader
                anchors.horizontalCenter: parent.horizontalCenter
            }

            ShaderButton {
                label: "grayscale"
                shader: "/home/verti/.config/hypr/shaders/grayscale.frag"
                active: items.activeshader === shader
                anchors.horizontalCenter: parent.horizontalCenter
            }

            ShaderButton {
                label: "blue light filter"
                shader: "/home/verti/.config/hypr/shaders/blue_light_filter.frag"
                active: items.activeshader === shader
                anchors.horizontalCenter: parent.horizontalCenter
            }            
        }
    }
}