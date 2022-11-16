import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3

import ProxyRoles 1.0

Window {
    id: window
    minimumHeight: 600
    minimumWidth: 700
    visible: true
    title: qsTr("ToDo List")

    property string main_bg_color : "#2a2a2a"
    property string highlightning_color : "#66cdaa"
    property string text_fields_bg : "#3b3b3b"
    property string input_text_color : "white"
    property int input_text_size : 11


    Rectangle {
        id: model_side
        width: parent.width / 100 * 49.5
        height:  parent.height
        color: main_bg_color
        Rectangle{
            id: header_and_combo
            height:  100
            width: parent.width
            color: parent.color
            Text {
                id: left_side_header_name
                height:  parent.height / 2
                width: parent.width
                text: "To Do"
                color: highlightning_color
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 20
            }

            ComboBox {
                id:combo_box
                anchors.top: left_side_header_name.bottom
                 height:  parent.height / 2
                 width: parent.width

                model: ["All", "In progress", "Done"]

                delegate: ItemDelegate {
                                id: delelgate
                                width: parent.width
                                contentItem: Text {
                                                id: main_txt
                                                text: modelData
                                                color: highlightning_color
                                                font.pointSize: 12
                                                   }

                                background: Rectangle { color: highlighted ? text_fields_bg : main_bg_color ; radius:20 }
                                highlighted: combo_box.highlightedIndex === index
            }
                onActivated: {

                   if(combo_box.displayText === "All" )
                   {
                      console.log("All filter")
                      Model_Done.filter = FilterTypes.All;
                   }
                   if(combo_box.displayText === "Done" )
                   {
                      console.log("Done filter");
                      Model_Done.filter = FilterTypes.Finished;
                   }
                   if(combo_box.displayText  === "In progress" )
                   {
                      console.log("Progress filter")
                      Model_Done.filter = FilterTypes.InProgress;
                   }

                }
                contentItem: Rectangle {
                anchors.fill:parent
                anchors.leftMargin: 10
                anchors.topMargin: 12
                color: "transparent"

                Text {
                    anchors.top: parent.top
                    text: combo_box.displayText
                    font.pointSize: 14
                    color: highlightning_color
                }
                }
                background: Rectangle {
                color: main_bg_color
                implicitWidth: 120
                implicitHeight: 40
                border.color: highlightning_color
                radius: 17
                }
                popup: Popup {
                            y: combo_box.height -1
                            width: combo_box.width
                            implicitHeight: contentItem.implicitHeight
                            padding: 1
                            contentItem: ListView {
                                            clip: true
                                            implicitHeight: contentHeight
                                            model: combo_box.popup.visible ? combo_box.delegateModel :  null
                                            currentIndex: combo_box.highlightedIndex
                                            ScrollIndicator.vertical: ScrollIndicator {}
                            }

                background: Rectangle {
                color:  "transparent"
                border.color: highlightning_color
                radius: 2
                }
                }
            }

        }
        Rectangle{

            id:list_space

            anchors.top: header_and_combo.bottom
            anchors.bottom: add_zone.top

            height: 300
            color: parent.color
            width: parent.width

            ListView {

                  id: listView
                  clip: true
                  spacing: 6
                  anchors.verticalCenter: parent.verticalCenter
                  anchors.horizontalCenter: parent.horizontalCenter
                  boundsBehavior: Flickable.DragAndOvershootBounds
                  snapMode: ListView.SnapToItem
                  width: parent.width - 20
                  height: parent.height - 20
                  model: Model_Done
                  delegate:  Component {
                  Rectangle {

                      id: login_frame

                      width: listView.width
                      height: 50

                      color:  main_bg_color
                      radius: 8
                      border.color: highlightning_color
                      border.width: 0
                      Column {

                          id: data_column
                          width:  parent.width / 10 * 8 - 10
                          anchors {
                              left: parent.left
                              leftMargin: 10
                          }

                          Text { text:"Name: " + model.name; color: input_text_color }
                          Text { text:"Date: " + model.data  ; color: input_text_color}
                          Text { text:"Description: " + model.description  ; color:input_text_color}

                      }

                      CheckBox {
                            id:control
                            checked: model.states
                            anchors.left: data_column.right
                            onClicked: {
                                 model.states = control.checked
                                 console.log(model.states,index)
                             }
                            height: parent.height
                            width: parent.width / 10 * 2
                            indicator: Rectangle {
                                            id: indicatorControl
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.horizontalCenter: parent.horizontalCenter

                                            width: 30
                                            height: 30

                                            radius: 50
                                            border.color: control.checked ? highlightning_color : text_fields_bg
                                            border.width: 3
                                            color: main_bg_color


                                            Text {
                                                anchors.centerIn: parent
                                                text: "✔"
                                                font.pointSize: 13
                                                color: highlightning_color
                                                visible: control.checked

                                             }
                                       }
                            }

                      MouseArea {

                                anchors.fill: data_column
                                onClicked: {

                                    listView.currentItem.border.width = 0;
                                    login_frame.border.width = 1;
                                    listView.currentIndex = index;

                                    edit_loader.item.element_id = model.idishnik;
                                    edit_loader.item.pop_visability = true;

                                    edit_loader.item.name_txt = model.name;
                                    edit_loader.item.date_txt = model.data;
                                    edit_loader.item.description_txt = model.description;

                                }
                            }
                   }



                 }
            }
        }

        Rectangle {
            id: add_zone
            anchors.bottom : add_zone_button.top
            width:parent.width
            height: 180
            color: main_bg_color
            Column {
                anchors.bottom: parent.bottom
                id: add_fields
                width: parent.width
                spacing: 10
                TextField{
                    id: name_field_add

                    placeholderText: qsTr("Name")
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
                    id: data_field_add
                    validator: IntValidator {}
                    placeholderText: qsTr("Data")
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
                    id:description_field_add
                    placeholderText: qsTr("Description")

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
            }
        }

        Rectangle{
            id: add_zone_button
            anchors.bottom : parent.bottom
            width:parent.width
            height: 80
            color: main_bg_color
            Button{
                id: add_button
                height: 50
                width:parent.width / 2.5
                anchors.centerIn: parent
                text: qsTr("Add")

                contentItem: Text {
                                        text: add_button.text
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

                    if( name_field_add.text.trim().length !== 0 &&
                        data_field_add.text.trim().length !== 0 &&
                        description_field_add.text.trim().length !== 0)
                    {
                        console.log("clicked add");
                        Model.add(name_field_add.text,data_field_add.text,description_field_add.text) ;
                    }
                    name_field_add.text = "";
                    data_field_add.text = "";
                    description_field_add.text = "";

                }
            }
        }


               }

    Rectangle {
        id: central_border
        anchors.left: model_side.right
        width: parent.width / 100
        height: parent.height
        color: "#242424"
    }

    Rectangle {
        id:edit_side
        anchors.left: central_border.right
        anchors.right: parent.right
        width: parent.width / 100 * 49.5
        height: parent.height
        color: main_bg_color

        Loader {
             id: edit_loader
             anchors.fill: parent
             source: "Edit_zone.qml"
         }
    }

}
