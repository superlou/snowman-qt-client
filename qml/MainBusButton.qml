import QtQuick 2.5
import Snowman 1.0
import "."

Item {
  id: container
  width: 60
  height: 60
  property alias label: label.text
  property int channel
  property bool isProgram
  property bool isPreview
  property bool isDisabled
  signal clicked
  signal shiftClicked

  Rectangle {
    id: outline
    color: 'transparent'
    border.color: 'white'
    anchors.fill: parent

    Rectangle {
      id: programSymbol
      color: 'transparent'
      height: 5
      width: parent.width
    }

    Rectangle {
      id: previewSymbol
      color: 'transparent'
      height: 5 - 1
      width: parent.width - 2
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.bottomMargin: 1
    }
  }

  Text {
    id: label
    color: 'white'
    font.pointSize: 16
    anchors.horizontalCenter: container.horizontalCenter
    anchors.verticalCenter: container.verticalCenter
  }

  states: [
    State {
      name: 'DEFAULT'
    },
    State {
      name: 'DISABLED'
      PropertyChanges {target: outline; border.color: 'gray'}
      PropertyChanges {target: label; color: 'gray'}
      when: isDisabled
    },
    State {
      name: 'PROGRAM_PREVIEW'
      PropertyChanges {target: outline; border.color: '#ff7a7a'}
      PropertyChanges {target: label; color: '#ff7a7a'}
      PropertyChanges {target: programSymbol; color: '#ff7a7a'}
      PropertyChanges {target: previewSymbol; color: '#afff77'}
      when: isProgram && isPreview
    },
    State {
      name: 'PROGRAM'
      PropertyChanges {target: outline; border.color: '#ff7a7a'}
      PropertyChanges {target: label; color: '#ff7a7a'}
      PropertyChanges {target: programSymbol; color: '#ff7a7a'}
      when: isProgram
    },
    State {
      name: 'PREVIEW'
      PropertyChanges {target: outline; border.color: '#afff77'}
      PropertyChanges {target: label; color: '#afff77'}
      PropertyChanges {target: previewSymbol; color: '#afff77'}
      when: isPreview
    }
  ]

  MouseArea {
    anchors.fill: parent
    onClicked: {
      if (container.isDisabled) {
        return;
      }

      if (mouse.modifiers & Qt.ShiftModifier) {
        container.shiftClicked()
      } else {
        container.clicked()
      }
    }
  }
}
