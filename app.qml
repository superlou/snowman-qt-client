import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import Snowman 1.0
import "qml"

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

    MainBusView {
      id: 'mainBusView'
      model: MainBus {
        objectName: 'mainBus'
      }
      count: app.mainBusChannelCount
    }

    DsksView {
      id: 'dsksView'
      model: DSKs {
        objectName: 'dsks'
      }
    }
  }

  focus: true
  Keys.onPressed: {
    if (event.text == '\\') {
      mainBusView.model.transition();
      return;
    }

    var key = event.key;
    var shiftHeld = event.modifiers & Qt.ShiftModifier;

    if (key >= Qt.Key_F1 && key <= Qt.Key_F8) {
      var channel = key - Qt.Key_F1;

      if (shiftHeld) {
        mainBusView.model.setProgram(channel);
      } else {
        mainBusView.model.setPreview(channel);
      }
    }

    if (key >= Qt.Key_F9 && key <= Qt.Key_F12) {
      var channel = key - Qt.Key_F9;
      dsksView.model.toggleDsk(channel)
    }
  }

  Keys.onReturnPressed: {
    mainBusView.model.take()
  }
}
