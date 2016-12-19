import QtQuick 2.5
import QtQuick.Controls 1.4
import Snowman 1.0
import "qml"

Item {
  id: app
  width: 600
  height: 400

  property int mainBusChannelCount: 8

  Rectangle {
    width: parent.width
    height: parent.height
    color: '#222'
  }

  MainBus {
    objectName: 'mainBus'
    count: app.mainBusChannelCount
    anchors.fill: parent
  }
}
