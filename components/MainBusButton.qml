import QtQuick 2.5
import Snowman 1.0
import "."

MainBusButton {
  id: container
  width: 60
  height: 60
  property alias label: label.text
  property int channel
  property int programChannel
  property int previewChannel
  signal clicked
  signal shiftClicked

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

  states: [
    State {
      name: 'DEFAULT'
      PropertyChanges {target: rectangle; color: 'gray'}
    },
    State {
      name: 'PROGRAM'
      PropertyChanges {target: rectangle; color: 'red'}
      when: (programChannel == container.channel)
    },
    State {
      name: 'PREVIEW'
      PropertyChanges {target: rectangle; color: 'green'}
      when: (previewChannel == container.channel)
    }
  ]

  MouseArea {
    anchors.fill: parent
    onClicked: {
      if (mouse.modifiers & Qt.ShiftModifier) {
        container.shiftClicked()
      } else {
        container.clicked()
      }
    }
  }
}
