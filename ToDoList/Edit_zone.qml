import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

import ProxyRoles 1.0

Rectangle{

    property string name_txt
    property string date_txt
    property string description_txt

    property string element_id

    property bool pop_visability : false

    color: main_bg_color

    Popup{

        id:popup

        visible: pop_visability
        leftMargin: 0
        topMargin: 0
        closePolicy: Popup.NoAutoClose
        x: 0
        y: 0
        height: parent.height
        width: parent.width
        padding: 0
        contentItem: Rectangle {

                        id:edit_side

                        color: main_bg_color

                        Rectangle{
                        id: rght_header
                        height:  50
                        width: edit_side.width
                        color: edit_side.color
                        Text {
                            id: right_side_header_name
                            height:  parent.height
                            width: parent.width
                            text: "Edit Task"
                            color: highlightning_color
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: 20
                             }
                             }

                        Column {
                    anchors.top: rght_header.bottom
                    id: edit_fields
                    width: parent.width
                    spacing: 10

                    TextField{
                         id: name_field_edit
                         text: name_txt
                         verticalAlignment: Qt.AlignVCenter
                         horizontalAlignment: Qt.AlignLeft
                         anchors.horizontalCenter: parent.horizontalCenter
                         height:  50
                         width: parent.width - 20
                         color: input_text_color
                         font.pointSize: input_text_size
                         background: Rectangle {
                                         radius: 100
                                         color: text_fields_bg
                                                }
                    }
                    TextField {
                        id: data_field_edit
                        validator: IntValidator {}
                        text: date_txt
                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: Qt.AlignLeft
                        anchors.horizontalCenter: parent.horizontalCenter
                        height:  50
                        width:  parent.width - 20
                        color: input_text_color
                        font.pointSize: input_text_size
                        background: Rectangle {
                                          radius: 100
                                          color: text_fields_bg
                                              }
                    }
                    TextField{
                        id: description_field_edit
                        text: description_txt
                        verticalAlignment: Qt.AlignVCenter
                        horizontalAlignment: Qt.AlignLeft
                        anchors.horizontalCenter: parent.horizontalCenter
                        height:  50
                        width:  parent.width - 20
                        color: input_text_color
                        font.pointSize: input_text_size
                        background: Rectangle {
                                            radius: 100
                                            color: text_fields_bg
                                              }
                   }
                }
                        Rectangle{
                    id: button_space
                    color: edit_side.color
                    height: 80
                    width:parent.width
                    anchors.bottom: parent.bottom
                    Button{
                        id: save_button
                        height: 50
                        width:parent.width / 2.5
                        anchors.centerIn: parent
                        text: qsTr("Save changes")
                        contentItem: Text {
                                        text: save_button.text
                                        color: highlightning_color
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                        }
                        background: Rectangle {
                                        radius: 100
                                        color: main_bg_color
                                        border.color: highlightning_color
                                              }
                        onClicked: {

                            if( name_field_edit.text.trim().length !== 0 &&
                                data_field_edit.text.trim().length !== 0 &&
                                description_field_edit.text.trim().length !== 0)
                            {
                                console.log("clicked save button");
                                Model.edit_data(element_id,name_field_edit.text,data_field_edit.text,description_field_edit.text) ;
                                pop_visability = false;
                            }

                          name_txt = name_txt;
                          date_txt = date_txt;
                          description_txt = description_txt;

                        }
                   }
                }


       }
    }
}
