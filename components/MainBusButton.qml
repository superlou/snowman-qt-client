import QtQuick 2.5
import Snowman 1.0
import "."

MainBusButton {
  id: container
  width: 60
  height: 60
  property alias label: label.text
  property int channel

  Rectangle {
    id: rectangle
    color: 'gray'
    border.color: 'black'
    anchors.fill: parent
  }

  Text {
    id: label
    anchors.horizontalCenter: container.horizontalCenter
    anchors.verticalCenter: container.verticalCenter
  }

  MouseArea {
    anchors.fill: parent
    onClicked: parent.setProgram(parent.channel)
  }
}
