import QtQuick
import Qt.labs.folderlistmodel

Item {
    id: root

    property string dir: ""
    property var extensions: ["*.png", "*.jpg", "*.jpeg"]
    property string path: ""

    FolderListModel {
        id: folderModel
        folder: "file://" + root.dir
        showDirs: false
        nameFilters: root.extensions
    }

    function reroll() {
        if (folderModel.status !== FolderListModel.Ready || folderModel.count === 0) return
        const idx = Math.floor(Math.random() * folderModel.count)
        root.path = folderModel.get(idx, "filePath")
    }    
}