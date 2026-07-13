import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

PopupWindow {    
    required property var menuHandle

    id: menu
    
    color: "transparent"
    anchor {
        item: parent
        rect {
            x: -10
            y: 50
        }
    }

    implicitHeight: wrapper.height
    implicitWidth: wrapper.width

    WrapperRectangle {
        id: wrapper
        color: "#af000000"
        radius: 12

        margin: 12

        ColumnLayout {
            spacing: 5
            
            Repeater {
                model: menuItems.children.values

                WrapperMouseArea {
                    required property var modelData

                    cursorShape: {
                        modelData.isSeparator
                            ? Qt.ArrowCursor
                            : Qt.PointingHandCursor
                    }

                    enabled: !modelData.isSeparator

                    child: {
                        modelData.isSeparator
                            ? separator
                            : menuEntry
                    }

                    onClicked: {
                        modelData.triggered()
                        menu.visible = false
                    }

                    Layout.fillWidth: true

                    Rectangle {
                        id: separator
                        color: "#ffffff"

                        implicitHeight: 1
                    }

                    WrapperRectangle {
                        id: menuEntry
                        color: "transparent"

                        Text {
                            text: modelData.text

                            color: "white"
                            font {
                                pointSize: 16
                                weight: 300
                                family: "Fredoka"
                            }
                        }
                    }
                }
            }
        }
    }

    QsMenuOpener {
        id: menuItems
        menu: menuHandle
    }
}