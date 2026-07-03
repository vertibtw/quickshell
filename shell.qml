//@ pragma UseQApplication
import Quickshell
import QtQuick

import qs.modules.bar
import qs.modules.wallpaper
import qs.modules.osd

ShellRoot {
    Wallpaper {id: wall}
    Bar {wallpapermod: wall}
    VolumeOsd {}
}