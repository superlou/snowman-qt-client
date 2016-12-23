import QtQuick 2.5
import QtQuick.Layouts 1.2
import Snowman 1.0
import "."

DSKs {
  id: container
  property var activeDsks: []

  Row {
    spacing: 10

    Repeater {
      model: 4
      DskButton {
        dskId: index
        text: 'DSK ' + (index + 1).toString()
        width: 60
        onClicked: {container.toggleDsk(index)}
        isActive: container.activeDsks.indexOf(index) > -1
      }
    }
  }
}
