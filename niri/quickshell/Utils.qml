import Quickshell
import QtQuick

pragma Singleton

Singleton {
    function cutOffString(string, maxLength) {
        if (string.length <= maxLength) { return string }

        return string.slice(0, maxLength - 3) + "..."
    }

    function resolvedUrl(url) {
        return Qt.resolvedUrl(url)
    }

    function volumeToIcon(node) {
        if (node.audio.volume < 0.01 || node.audio.muted) { return resolvedUrl("icons/audio/volume-xmark-solid.png") }
        else if (node.audio.volume < 0.34) { return resolvedUrl("icons/audio/volume-low-solid.png") }
        else if (node.audio.volume < 0.67) { return resolvedUrl("icons/audio/volume-solid.png") }
        else { return resolvedUrl("icons/audio/volume-high-solid.png") }
    }
}