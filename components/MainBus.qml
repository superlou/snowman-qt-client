import QtQuick 2.5
import QtQuick.Layouts 1.2
import Snowman 1.0
import "."

MainBus {
  id: container
  property int count
  property int programChannel
  property int previewChannel

  RowLayout{
    anchors.fill: parent

    Repeater {
      model: container.count
      MainBusButton {
        channel: index
        label: index + 1
      }
    }
  }
}
