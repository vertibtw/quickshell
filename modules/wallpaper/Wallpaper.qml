import qs
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick

Item {
    id: root
    property string src

    FileView {
        id: srcfile
        path: "/home/verti/.wallpaper"
        watchChanges: true
        
        onFileChanged: reload()
        onLoaded:      src = "file://" + text().trim()
        onTextChanged: src = "file://" + text().trim()
    }

    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: wallpaper_win
            required property var modelData
            screen: modelData

            anchors {
                left:true
                right:true
                top:true
                bottom:true
            }

            color: "transparent"
            WlrLayershell.layer: WlrLayer.Background

            Image {
                id: wallpaper
                source: root.src
                fillMode: Image.PreserveAspectCrop
                anchors.fill: parent
            }
        }
    }
}