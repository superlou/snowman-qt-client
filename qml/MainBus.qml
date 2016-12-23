import QtQuick 2.5
import QtQuick.Layouts 1.2
import Snowman 1.0
import "."

Row {
  id: container
  property int count
  property MainBusModel model

  spacing: 10

  MainBusTransitions {
    onTransition: container.model.transition()
    onTake: container.model.take()
  }

  Repeater {
    model: container.count
    MainBusButton {
      channel: index
      label: index + 1
      onClicked: {container.model.setPreview(channel)}
      onShiftClicked: {container.model.setProgram(channel)}
      isPreview: {index == container.model.previewChannel}
      isProgram: {index == container.model.programChannel}
      isDisabled: {index > 5}
    }
  }
}
