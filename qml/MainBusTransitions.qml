import QtQuick 2.5
import QtQuick.Layouts 1.2
import Snowman 1.0
import "."


Row {
  id: container
  signal take
  signal transition

  spacing: 10

  Column {
    spacing: 4
    Button {
      text: 'Take'
      height: 28
      onClicked: container.take()
    }

    Button {
      text: 'Auto'
      height: 28
      onClicked: container.transition()
    }
  }
}
