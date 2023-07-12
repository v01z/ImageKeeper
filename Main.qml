import QtQuick 2.15
import ru.barsestate 1.0

//Rectangle {
Window {
    width: 640
    height: 480
    //color: "red"
    color: "grey"
    visible: true

    JsonData {
        id: jsonData
    }

    Component.onCompleted: {
        jsonData.parse()
        if (jsonData.result) {

            gridView.model = jsonData.data

            //debug prps
            for (var i = 0; i < jsonData.length; i++) {
                var obj = jsonData.data[i]
                console.log("ID : " + obj.id)
                console.log("Image source: " + obj.img_src)
                console.log("Description: " + obj.short_descr)
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
                    source: modelData.img_src
                    smooth: true
                }
                Text {
                    color: "white"
                    text: modelData.short_descr
                }
            }
            MouseArea {
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
                    color: "grey"
                }
                GradientStop {
                    position: 0.7
                    color: "black"
                }
            }
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                color: "grey"
                text: "ImageKeeper"
                font.bold: true
            }
            Image {
                id: addItemImage
                anchors.right: parent.right
                anchors.rightMargin: 10
                source: "qrc:/add.png"
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("clicked")

                        gridView.visible = false
                        newItemSpace.visible = true

                        //jsonData.parse("./data.json")
                        jsonData.parse()
                        gridView.model = jsonData.data
                    }
                }
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

    NewItemSpace {
        id: newItemSpace
        anchors.fill: parent
        visible: false
        states: [
            State {
                when: newItemSpace.visible === true
                PropertyChanges {
                    target: newItemSpace
                    opacity: 1.0
                }
            },
            State {
                when: newItemSpace.visible === false
                PropertyChanges {
                    target: newItemSpace
                    opacity: 0.0
                }
            }
        ]
        transitions: Transition {
            NumberAnimation {
                property: "opacity"
                duration: 500
            }
        }
    }
}
