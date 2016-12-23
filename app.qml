import QtQuick 2.5
import QtQuick.Controls 1.4
import Snowman 1.0
import "qml"

Item {
  id: app
  width: 800
  height: 400

  property int mainBusChannelCount: 8

  Rectangle {
    width: parent.width
    height: parent.height
    color: '#222'
  }

  MainBus {
    id: 'mainBus'
    objectName: 'mainBus'
    count: app.mainBusChannelCount
  }
  DSKs {
    id: 'dsks'
    objectName: 'dsks'
    y: 100
  }


  focus: true
  Keys.onPressed: {
    if (event.text == '\\') {
      mainBus.transition();
      return;
    }

    var key = event.key;
    var shiftHeld = event.modifiers & Qt.ShiftModifier;

    if (key >= Qt.Key_F1 && key <= Qt.Key_F8) {
      var channel = key - Qt.Key_F1;

      if (shiftHeld) {
        mainBus.setProgram(channel);
      } else {
        mainBus.setPreview(channel);
      }
    }

    if (key >= Qt.Key_F9 && key <= Qt.Key_F12) {
      var channel = key - Qt.Key_F9;
      dsks.toggleDsk(channel)
    }
  }

  Keys.onReturnPressed: {
    mainBus.take()
  }
}
