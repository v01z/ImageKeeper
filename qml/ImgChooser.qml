import QtQuick 2.15
import QtQuick.Controls 2.15

Row {
    id: mainItem
    property string img_path_text: imgTextField.text
    property bool is_filled: {
        if (imgTextField.text === "")
            return false
        else {
            //console.log("is_filled == true")
            return true
        }
    }

    spacing: 10
    TextField {
        id: imgTextField
        placeholderText: qsTr("Путь к изображению")
        width: 170
    }
    Button {
        id: imgPathBtn
        text: qsTr("Выбрать")
        onClicked: {

            //open file choose dialog
            console.log(mainItem.img_path_text)
        }
    }
}
