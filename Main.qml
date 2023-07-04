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
                        newItemSpace.stateVisible = true

                        jsonData.parse("./data.json")
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
        //anchors.centerIn: parent
        //anchors.horizontalCenter: parent.
        //anchors.fill: parent
        width: parent.width
        //height: parent.height
        //anchors.topMargin: parent.
        visible: false
        property bool stateVisible: false
        states: [
            State {
                when: newItemSpace.stateVisible
                PropertyChanges {
                    target: newItemSpace
                    opacity: 1.0
                }
            },
            State {
                when: !newItemSpace.stateVisible
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
