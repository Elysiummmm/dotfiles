import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import qs
import qs.Components

// stole half of this from quickshell examples thanks goat
ColumnLayout {
	required property PwNode node;

	// bind the node so we can read its properties
	PwObjectTracker { objects: [ node ] }    

	RowLayout {
		Button {
            onClicked: { node.audio.muted = !node.audio.muted }

            IconImage {
                visible: source != ""
                source: Utils.volumeToIcon(node)

                implicitSize: 32
		    }
        }

		Label {
			text: {
				// application.name -> description -> name
				const app = node.properties["application.name"] ?? (node.description != "" ? node.description : node.name);
				const media = node.properties["media.name"];
				const text = media != undefined ? `${app} - ${media}` : app;

                return Utils.cutOffString(text, 50)
			}

            color: "#ffffff"

            font {
                family: "Fredoka"
                pointSize: 15
            }
		}
	}

	RowLayout {
		Label {
			Layout.preferredWidth: 50
			text: `${Math.floor(node.audio.volume * 100)}%`
            color: "#ffffff"

            horizontalAlignment: Text.AlignHCenter

            font {
                family: "Montserrat"
                pointSize: 13
            }
		}

		Slider {
            id: volumeSlider

            background: Rectangle {
                radius: 25
                color: "#20ffffff"
                id: sliderBg

                implicitHeight: 16

                Rectangle {
                    width: volumeSlider.visualPosition * (parent.width - 8)
                    height: parent.height - 8

                    color: "#ffffff"

                    radius: 256
                    x: 4; y: 4
                }
            }

            handle: Rectangle {
                x: volumeSlider.visualPosition * (sliderBg.width - 8) - 4
                y: 4
                implicitWidth: sliderBg.height - 8
                implicitHeight: sliderBg.height - 8
                radius: 256
            }

			Layout.fillWidth: true
			value: node.audio.volume
			onValueChanged: node.audio.volume = value
		}
	}
}
