import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Services.Mpris
import qs
import qs.Components

WrapperRectangle {
    id: nowPlaying

    property var mprisPlayers: Mpris.players
    property var activePlayer: {
        if (mprisPlayers.values.length == 0) { return undefined }

        for (const player of mprisPlayers.values) {
            if (player.isPlaying) { return player }
        }

        return mprisPlayers.values[0]
    }

    color: '#4f000000'
    radius: 12

    Layout.preferredHeight: 55
    
    margin: 5
    leftMargin: 7.5

    child: activePlayer ? layout : nothingPlaying

    FrameAnimation {
        running: activePlayer.playbackState == MprisPlaybackState.Playing
        onTriggered: activePlayer.positionChanged()
    }

    Text {
        id: nothingPlaying
        visible: !activePlayer

        text: "No music playing"
        color: "#4dffffff"

        font {
            pointSize: 24
            family: "Fredoka"
        }
    }

    RowLayout {
        id: layout
        spacing: 10

        visible: !!activePlayer

        implicitHeight: 55

        RowLayout {
            spacing: 5

            PlayerControlButton {
                onClicked: { activePlayer.previous() }

                IconImage {
                    source: Utils.resolvedUrl("icons/mediaButtons/rewind.png")
                    implicitSize: 32
                }
            }

            PlayerControlButton {
                onClicked: { activePlayer.togglePlaying() }

                IconImage {
                    source: {
                        activePlayer.isPlaying
                            ? Utils.resolvedUrl("icons/mediaButtons/pause.png")
                            : Utils.resolvedUrl("icons/mediaButtons/play.png")
                    }
                    implicitSize: 32
                }
            }

            PlayerControlButton {
                onClicked: { activePlayer.next() }

                IconImage {
                    source: Utils.resolvedUrl("icons/mediaButtons/forward.png")
                    implicitSize: 32
                }
            }
        }

        WrapperMouseArea {
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                mediaPopup.visible = !mediaPopup.visible
                clipWrapper.state == ""
                    ? clipWrapper.state = "opened"
                    : clipWrapper.state = ""
            }

            ColumnLayout {
                spacing: 0

                Text {
                    text: {
                        Utils.cutOffString(activePlayer.trackTitle, 100)
                    }

                    color: "white"

                    font {
                        pointSize: 16
                        family: "Fredoka"
                        weight: 500
                    }
                }

                Text {
                    text: {
                        activePlayer.trackArtist
                    }

                    color: "white"

                    font {
                        pointSize: 12
                        family: "Fredoka"
                        weight: 300
                    }
                }
            }
        }

        ClippingWrapperRectangle {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight

            radius: 12
            color: "transparent"

            Layout.preferredHeight: 45
            Layout.preferredWidth: 45

            Image {
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit

                source: activePlayer.trackArtUrl
            }
        }
    }

    PopupWindow {
        id: mediaPopup
        color: "transparent"

        anchor {
            item: nowPlaying
            rect {
                y: 60
            }
        }

        implicitWidth: nowPlaying.width
        implicitHeight: 424

        Image {
            id: bgImage
            anchors.fill: parent
            source: activePlayer.trackArtUrl
            fillMode: Image.PreserveAspectCrop
            visible: false
        }

        MultiEffect {
            id: background
            source: bgImage
            anchors.fill: bgImage

            blurEnabled: true
            blur: 1.0
            blurMax: 64
            blurMultiplier: 2

            z: -1
        }

        ClippingWrapperRectangle {
            id: bgWrapper
            color: "black"
            radius: 12

            implicitWidth: parent.width
            implicitHeight: 0

            child: background // idk why this works i hate it here
        }

        ClippingWrapperRectangle {
            id: clipWrapper

            color: "transparent"
            radius: 12
            
            implicitWidth: parent.width
            implicitHeight: 0

            states: [
                State {
                    name: "opened"
                    PropertyChanges { target: clipWrapper; height: parent.height }
                    PropertyChanges { target: bgWrapper; height: parent.height }
                }
            ]
            
            transitions: Transition {
                NumberAnimation {
                    properties: "height"
                    easing.type: Easing.InOutQuad
                    duration: 350
                }
            }            

            ColumnLayout {
                anchors.fill: parent

                ClippingWrapperRectangle {
                    Layout.topMargin: 24
                    Layout.preferredWidth: 256
                    Layout.preferredHeight: 256
                    radius: 12

                    anchors.horizontalCenter: parent.horizontalCenter

                    Image {
                        fillMode: Image.PreserveAspectFit
                        source: activePlayer.trackArtUrl
                    }
                }

                Text {
                    text: {
                        Utils.cutOffString(
                            activePlayer.trackTitle,
                            Math.floor(nowPlaying.width / 16)
                    )}

                    color: "white"

                    anchors.horizontalCenter: parent.horizontalCenter

                    font {
                        pointSize: 24
                        family: "Fredoka"
                    }
                }

                Text {
                    text: {
                        Utils.cutOffString(
                            `${activePlayer.trackArtist} - ${activePlayer.trackAlbum}`,
                            Math.floor(nowPlaying.width / 8)
                    )}

                    color: "white"

                    anchors.horizontalCenter: parent.horizontalCenter

                    font {
                        pointSize: 12
                        family: "Fredoka"
                    }
                }

                Text {
                    text: {
                        let minutes = Math.floor(activePlayer.position / 60)
                        let seconds = Math.floor(activePlayer.position % 60)
                        let endMins = Math.floor(activePlayer.length / 60)
                        let endSecs = Math.floor(activePlayer.length % 60)

                        return `${minutes}:${String(seconds).padStart(2, "0")} / ${endMins}:${String(endSecs).padStart(2, "0")}`
                    }
                    color: "white"

                    anchors.horizontalCenter: parent.horizontalCenter

                    font {
                        pointSize: 12
                        family: "Fredoka"
                    }
                }

                RowLayout {
                    spacing: 5

                    PlayerControlButton {
                        onClicked: { activePlayer.shuffle = !activePlayer.shuffle }
                        highlightOverride: activePlayer.shuffle

                        IconImage {
                            source: Utils.resolvedUrl("icons/mediaButtons/shuffle.png")
                            implicitSize: 32
                        }
                    }
                    
                    WrapperMouseArea {
                        id: songProgress

                        Layout.fillWidth: true
                        Layout.preferredHeight: 20

                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onPressed: {
                            activePlayer.position = mouseX / width * activePlayer.length
                        }

                        onEntered: { trackPositionPreview.visible = true }
                        onExited: { trackPositionPreview.visible = false }

                        Rectangle {
                            radius: 25
                            color: "#20ffffff"

                            Rectangle {
                                color: "#ffffff"
                                radius: 256

                                x: 4; y: 4

                                width: activePlayer.position / activePlayer.length * parent.width - 8
                                height: parent.height - 8
                            }
                        }
                    }

                    PlayerControlButton {
                        onClicked: { 
                            switch (activePlayer.loopState) {
                                case MprisLoopState.None:
                                    activePlayer.loopState = MprisLoopState.Playlist
                                    break
                                case MprisLoopState.Playlist:
                                    activePlayer.loopState = MprisLoopState.Track
                                    break
                                default:
                                    activePlayer.loopState = MprisLoopState.None
                            }
                        }

                        highlightOverride: {
                            switch (activePlayer.loopState) {
                                case MprisLoopState.None: return false
                                default: return true
                            }
                        }

                        IconImage {
                            source: switch (activePlayer.loopState) {
                                case MprisLoopState.Track:
                                    return Utils.resolvedUrl("icons/mediaButtons/repeat-1.png")
                                default:
                                    return Utils.resolvedUrl("icons/mediaButtons/repeat.png")
                            }
                            implicitSize: 32
                        }
                    }
                }
            }
        }
    }

    PopupWindow {
        id: trackPositionPreview
        
        color: "black"

        anchor {
            item: songProgress
            gravity: Edges.Top | Edges.Right
            rect {
                x: songProgress.mouseX - width / 2
            }
        }

        implicitWidth: 50
        implicitHeight: 30

        Text {
            id: previewText
            anchors.centerIn: parent

            text: {
                let ratio = songProgress.mouseX / songProgress.width
                let pos = ratio * activePlayer.length
                let seconds = Math.floor(pos % 60)

                return `${Math.floor(pos / 60)}:${String(seconds).padStart(2, "0")}`
            }

            color: "white"
            font {
                pointSize: 12
                family: "Fredoka"
            }
        }
    }
}