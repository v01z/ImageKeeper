import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    //anchors.centerIn: parent
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10

        TextField {
            id: shortDescriptionTextField
            //anchors.topMargin: parent.top + 10
            text: ""
            placeholderText: "Краткое описание"
        }

        ImgChooser {
            id: mainImgChooser
            //anchors.top: shortDescriptionTextField.bottom
        }


        /*
        TextField{
            id: fullDescriptionTextEdit
            text: ""
            placeholderText: qsTr("Расширенное описание")
        }
        ImgChooser{
            id: firstExtraImgChooser
            visible: {
                if(shortDescriptionTextField.text === "" ||
                        mainImgChooser.is_filled === false)
                    return false
                else
                    return true
            }
        }
        ImgChooser{
            id: secondExtraImgChooser
            visible: firstExtraImgChooser.is_filled
        }
        ImgChooser{
            id: thirdExtraImgChooser
            visible: secondExtraImgChooser.is_filled
        }
        ImgChooser{
            id: fourthExtraImgChooser
            visible: thirdExtraImgChooser.is_filled
        }
        */
        Row {
            spacing: 10
            Button {
                id: okBtn
                text: "OK"
                //anchors.top: mainImgChooser.bottom
                enabled: {
                    if (shortDescriptionTextField.text === "")
                        return false
                    if (mainImgChooser.is_filled === false)
                        return false
                    return true
                }

                onClicked: {
                    // change json-file and:
                    newItemSpace.visible = false
                    gridView.visible = true
                }
            }
            Button {
                id: cancelBtn
                text: "Отмена"
                onClicked: {
                    newItemSpace.visible = false
                    gridView.visible = true
                }
            }
        }
    }
}
