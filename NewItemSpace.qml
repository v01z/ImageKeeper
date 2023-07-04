import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    Column{
        anchors.fill: parent
        padding: 10
        TextField{
            id: shortDescriptionTextField
            text: ""
            placeholderText: qsTr("Краткое описание")
        }
        ImgChooser{
            id: mainImgChooser
        }

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

        Row{
            Button{
                id: okBtn
                text: qStr("OK")
                enabled: {
                    if(shortDescriptionTextField.text === "")
                        return false
                    if (mainImgChooser.is_filled === false)
                        return false
                    return true
                }

                onClicked: {
                    //
                }
            }
            Button{
                id: cancelBtn
                text: qStr("Отмена")
                onClicked: {
                   //
                }
            }
        }
    }

}
