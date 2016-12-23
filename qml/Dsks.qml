import QtQuick 2.5
import QtQuick.Layouts 1.2
import Snowman 1.0
import "."

Row {
  id: container
  property DsksModel model

  spacing: 10

  Repeater {
    model: 4
    DskButton {
      dskId: index
      text: 'DSK ' + (index + 1).toString()
      width: 60
      onClicked: {container.model.toggleDsk(index)}
      isActive: {container.model.activeDsks.indexOf(index) > -1}
    }
  }
}
