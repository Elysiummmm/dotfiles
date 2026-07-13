import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

WrapperItem {
    leftMargin: 15

    Text {
        text: Time.timeMinutes
        color: "#FFFFFF"

        font {
            pointSize: 25
            family: "Montserrat"
        }
    }
}