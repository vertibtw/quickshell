import qs
import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls

PopupWindow {
    id: root
    visible: false

    PwObjectTracker {
        objects: [ Pipewire.defaultAudioSink ]
    }

    required property var parentWindow
    property double vol: Pipewire.defaultAudioSink?.audio.volume * 100 ?? 0

    anchor.window: parentWindow

    anchor.rect.x: parentWindow.width 
    anchor.rect.y: parentWindow.height * 1.1  

    implicitWidth: content.width
    implicitHeight: content.height
    grabFocus: true

    Rectangle {
        id: content
        implicitWidth: r.width * 1.2
        implicitHeight: r.height * 2

        color: Colors.background

        // row stays for now
        Row {
            id: r
            spacing: 4
            anchors.centerIn: parent

            Slider {
                id: slider
                from: 0
                to: 100
                value: root.vol

                anchors.verticalCenter: parent.verticalCenter
                
                background: Rectangle {
                    id: bg
                    color: Colors.grey
                    implicitWidth: 100
                    implicitHeight: root.parentWindow.height * 0.4 

                    Rectangle {
                        implicitHeight: parent.height
                        implicitWidth: root.vol
                        color: Colors.blue
                    }
                }

                handle: Rectangle {
                    x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                    implicitHeight: bg.height
                    implicitWidth: height
                    border.color: Colors.blue
                    border.width: 2
                    radius: 8
                }

                onMoved: {
                    if (Pipewire.defaultAudioSink)
                        Pipewire.defaultAudioSink.audio.volume = value / 100
                }
            }
        }
    }
}