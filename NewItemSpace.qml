import QtQuick 2.15
import QtQuick.Controls 2.15

Item {

    Column {
        anchors.centerIn: parent
        spacing: 10

        TextField {
            id: shortDescriptionTextField
            placeholderText: qsTr("Краткое описание")
            width: 170
        }
        ImgChooser {
            id: mainImgChooser

            visible: shortDescriptionTextField.text === "" ? false : true
        }
        TextField {
            id: fullDescriptionTextEdit
            text: ""
            placeholderText: qsTr("Расширенное описание")
            width: 180
            wrapMode: TextInput.Wrap
            maximumLength: 170 // 7-8 lines


            visible: {
                if (shortDescriptionTextField.text === ""
                        || mainImgChooser.is_filled === false)
                    return false
                else
                    return true
            }
        }
        ImgChooser {
            id: firstExtraImgChooser

            visible: {
                if (shortDescriptionTextField.text === ""
                        || mainImgChooser.is_filled === false)
                    return false
                else
                    return true
            }
        }
        ImgChooser {
            id: secondExtraImgChooser
            visible: firstExtraImgChooser.is_filled
        }
        ImgChooser {
            id: thirdExtraImgChooser
            visible: secondExtraImgChooser.is_filled
        }
        ImgChooser {
            id: fourthExtraImgChooser
            visible: thirdExtraImgChooser.is_filled
        }
        Row {
            spacing: 10
            Button {
                id: okBtn
                text: qsTr("OK")
                enabled: {
                    if (shortDescriptionTextField.text === "")
                        return false
                    if (mainImgChooser.is_filled === false)
                        return false

                    //debug
                    console.log("OK btn is enabled")

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
                text: qsTr("Отмена")
                onClicked: {
                    newItemSpace.visible = false
                    gridView.visible = true

                    //debug
                    console.log(fullDescriptionTextEdit.text.length)
                }
            }
        }
    }
}
