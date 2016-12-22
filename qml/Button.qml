import QtQuick 2.5
import QtQuick.Layouts 1.2
import Snowman 1.0
import "."

Rectangle {
  id: container
  width: 100
  height: 60
  color: 'transparent'
  border.color: 'white'

  signal clicked
  property alias text: label.text

  Text {
    id: label
    color: 'white'
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
  }

  MouseArea {
    anchors.fill: parent
    onClicked: container.clicked()
  }
}
