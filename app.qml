import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import Snowman 1.0
import "qml"
import "qml/models"

Item {
  id: app
  width: 1200
  height: 400

  property int mainBusChannelCount: 8

  Rectangle {
    width: parent.width
    height: parent.height
    color: '#222'
  }

  Row {
    spacing: 10

    MainBus {
      id: 'mainBus'
      model: MainBusModel {
        objectName: 'mainBusModel'
      }
    }

    Dsks {
      id: 'dsks'
      model: DsksModel {
        objectName: 'dsksModel'
      }
    }
  }

  focus: true
  Keys.onPressed: {
    if (event.text == '\\') {
      mainBus.model.transition();
      return;
    }

    var key = event.key;
    var shiftHeld = event.modifiers & Qt.ShiftModifier;

    if (key >= Qt.Key_F1 && key <= Qt.Key_F8) {
      var channel = key - Qt.Key_F1;

      if (shiftHeld) {
        mainBus.model.setProgram(channel);
      } else {
        mainBus.model.setPreview(channel);
      }
    }

    if (key >= Qt.Key_F9 && key <= Qt.Key_F12) {
      var channel = key - Qt.Key_F9;
      dsks.model.toggleDsk(channel)
    }
  }

  Keys.onReturnPressed: {
    mainBus.model.take()
  }
}
