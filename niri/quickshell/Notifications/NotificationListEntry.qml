import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs

ClippingWrapperRectangle {
    id: root
    required property var notification
    
    color: '#222222'
    radius: 12

    implicitHeight: 128
    implicitWidth: 484

    margin: 6

    RowLayout {
        WrapperMouseArea {
            cursorShape: Qt.PointingHandCursor

            implicitWidth: 38

            onClicked: {
                Notifs.remove(root.notification)
                notification.dismiss()
            }
                
            IconImage {
                source: Utils.resolvedUrl("icons/xmark-solid.png")
                implicitSize: 32
            }
        }

        WrapperRectangle {
            implicitWidth: 428
            implicitHeight: 116
            color: 'transparent'

            ColumnLayout {      
                Text {
                    text: root.notification.summary

                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter

                    Layout.alignment: Qt.AlignVCenter | Qt.AlignTop

                    font {
                        pointSize: 15
                        family: "Montserrat"
                        weight: 600
                    }
                }

                WrapperRectangle {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    color: 'transparent'

                    Text {
                        text: root.notification.body

                        color: "white"

                        wrapMode: Text.Wrap

                        font {
                            pointSize: 13
                            family: "Montserrat"
                        }
                    }
                }
            }
        }
    }
}