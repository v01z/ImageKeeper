import QtQuick 2.15
import ru.barsestate 1.0

//Rectangle {
Window {
    width: 640
    height: 480
    color: "red"
    visible: true

    JsonData {
        id: jsonData
    }

    Component.onCompleted: {
        jsonData.parse("./data.json")
        if (jsonData.result) {

            gridView.model = jsonData.data

            for (var i = 0; i < jsonData.length; i++) {
                var obj = jsonData.data[i]
                console.log("ID : " + obj.id)
                console.log("Image source: " + obj.imgSrc)
                console.log("Description: " + obj.descr)
            }
        } else {
            console.warn("Any data has not found by enable status!")
        }
    }

    Component {
        id: delegate
        Item {
            width: 120
            height: 120
            Column {
                anchors.centerIn: parent
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 64
                    height: 64
                    source: modelData.imgSrc
                    smooth: true
                }
                Text {
                    color: "white"
                    text: modelData.descr
                }
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    console.log(modelData.id)
                   gridView.currentIndex = index //highlight
                }
            }
        }
    }
    GridView {
        id: gridView
        cellHeight: 120
        cellWidth: 120
        focus: true

        header: Rectangle {
            width: parent.width
            height: 30
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "gray"
                }
                GradientStop {
                    position: 0.7
                    color: "black"
                }
            }
            Text {
                anchors.centerIn: parent
                color: "gray"
                text: "ImageKeeper"
                font.bold: true
            }
        }

        footer: Rectangle {
            width: parent.width
            height: 30
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "gray"
                }
                GradientStop {
                    position: 0.7
                    color: "black"
                }
            }
        }
        highlight: Rectangle {
            width: parent.width
            color: "darkblue"
        }
        anchors.fill: parent
        delegate: delegate
    }
}
