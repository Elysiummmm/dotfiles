import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs

WrapperRectangle {
    id: systemTray

    visible: SystemTray.items.values.length > 0

    color: '#4f000000'
    radius: 12

    Layout.preferredHeight: 55
    
    margin: 10

    signal beforeMenuOpened

    RowLayout {
        layoutDirection: Qt.RightToLeft
        spacing: 10

        Repeater {
            model: SystemTray.items.values

            WrapperMouseArea {
                required property var modelData

                cursorShape: Qt.PointingHandCursor
                acceptedButtons: {
                    let buttons = Qt.LeftButton
                    if (modelData.hasMenu) { buttons |= Qt.RightButton }

                    return buttons
                }

                onClicked: mouse => {
                    if (mouse.button == Qt.LeftButton) { modelData.activate() }
                    else if (mouse.button == Qt.RightButton) {
                        if (!menu.visible) {
                            systemTray.beforeMenuOpened()
                            menu.visible = true
                        } else {
                            menu.visible = false
                        }
                    }
                }

                IconImage {
                    id: icon

                    implicitSize: 32
                    source: {
                        modelData.id == "spotify-client"
                            ? Utils.resolvedUrl("spotify.png")
                            : modelData.icon
                    }
                }

                SystemTrayMenu {
                    id: menu
                    menuHandle: modelData.menu

                    Component.onCompleted: {
                        systemTray.beforeMenuOpened.connect(() => {
                            visible = false
                        });
                    }
                }
            }
        }
    }
}