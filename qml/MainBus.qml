import QtQuick 2.5
import QtQuick.Layouts 1.2
import Snowman 1.0
import "."

MainBus {
  id: container
  property int count
  property int programChannel
  property int previewChannel

  Row {
    anchors.fill: parent
    anchors.verticalCenter: parent.verticalCenter
    spacing: 10

    Repeater {
      model: container.count
      MainBusButton {
        channel: index
        label: index + 1
        onClicked: {container.setPreview(channel)}
        onShiftClicked: {container.setProgram(channel)}
        isPreview: {index == container.previewChannel}
        isProgram: {index == container.programChannel}
        isDisabled: {index > 5}
      }
    }

    MainBusTransitions {
      onTransition: container.transition()
      onTake: container.take()
    }
  }

  focus: true
  Keys.onPressed: {
    if (event.text == '\\') {
      container.transition();
      return;
    }

    var key = event.key;
    var shiftHeld = event.modifiers & Qt.ShiftModifier;

    if (key >= Qt.Key_F1 && key <= Qt.Key_F12) {
      var channel = key - Qt.Key_F1;

      if (shiftHeld) {
        container.setProgram(channel);
      } else {
        container.setPreview(channel);
      }
    }
  }

  Keys.onReturnPressed: {
    container.take()
  }
}
