import QtQuick 2.5
import QtQuick.Layouts 1.2
import Snowman 1.0
import "."


MainBusTransitions {
  id: container
  anchors.fill: parent
  signal take
  signal transition


  RowLayout {
    Rectangle {
      id: takeButton
      width: 60
      height: 60
      color: 'gray'
      border.color: 'black'

      Text {
        text: 'Take'
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
      }

      MouseArea {
        anchors.fill: parent
        onClicked: container.take()
      }
    }

    Rectangle {
      id: transitionButton
      width: 100
      height: 60
      color: 'gray'
      border.color: 'black'

      Text {
        text: 'Transition'
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
      }

      MouseArea {
        anchors.fill: parent
        onClicked: container.transition()
      }
    }
  }

}
