import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: mainItem
    property string img_path_text: imgTextField.text
    property bool is_filled: {
        if (imgTextField.text === "")
            return false
        else
            return true
    }

    Row {
        spacing: 10
        TextField {
            id: imgTextField
            text: ""
            placeholderText: "Путь к файлу или URL"
            //width: 240
        }
        Button {
            id: imgPathBtn
            text: "..."
            onClicked: {

                //open file choose dialog
                //console.log(shortDescriptionTextField.top)
                //console.log(mainImgChooser.top)
            }
        }
    }
}
