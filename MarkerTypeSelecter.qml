import QtQuick 2.0
import QtQuick.Controls 1.4
Item {
    id: rootMarkerTypeSelecter
    width: 300
    height:  128
    property alias currentType : markerType.currentIndex
    property string currentTypeText:"路面"
    property color currentColor:borderData.getColorNames()[1]

    onCurrentTypeChanged: {

        markerType.currentItem.checked =  true
    }

    GridView{
        id:markerType
        anchors.bottom: parent.bottom
        cellHeight : 48
        cellWidth : 48
        width: parent.width; height: 96
        clip: true
        model: MarkerTypeModel{id: markerTypeModel}
        ExclusiveGroup { id: typeGroup }


        delegate: Rectangle{
            id: selectionType
            width: 38; height: 38

            border.color:checked?"green":"white"
            border.width: 2
            color:borderData.getColorNames()[index+1]
            property bool checked: false
            Component.onCompleted: {
                typeGroup.bindCheckable(selectionType)
            }           

            Text {
                anchors.fill: parent
                text: qsTr(name)
                font.pointSize: 6
                color: "white"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    parent.checked = true
                    currentType = index
                    currentTypeText = name
                    currentColor = parent.color
                }
            }
        }
    }
    Text {
        width: parent.width
        font.pointSize: 16
        horizontalAlignment: Text.AlignHCenter
        text: qsTr(currentTypeText)
    }
}
