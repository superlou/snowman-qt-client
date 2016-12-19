#!/usr/bin/python3
import os
from sys import argv, exit
import setup_gl_fix
from PyQt5.QtCore import QObject, QUrl, pyqtProperty, pyqtSignal, pyqtSlot
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine, qmlRegisterType, QQmlComponent, QQmlListProperty
from PyQt5.QtQuick import QQuickItem, QQuickView
from manager_connection import ManagerConnection


class MainBusTransitions(QQuickItem):
    pass


class MainBusButton(QQuickItem):
    pass


class MainBus(QQuickItem):
    def __init__(self, parent=None):
        super().__init__(parent)
        self._manager = None
        self._previewChannel = None
        self._programChannel = None

    @pyqtProperty(ManagerConnection)
    def manager(self):
        return self._manager

    @manager.setter
    def manager(self, newManager):
        self._manager = newManager
        self._manager.subscribe(self.onManagerUpdate)
        self.manager.send({'action': 'sync'})

    @pyqtProperty(int)
    def previewChannel(self):
        return self._previewChannel

    @previewChannel.setter
    def previewChannel(self, channel):
        if self._previewChannel != channel:
            self._previewChannel = channel

    @pyqtSlot(int)
    def setPreview(self, channel):
        self.manager.send({'action': 'set_preview', 'feed': channel + 1})

    @pyqtSlot(int)
    def setProgram(self, channel):
        self.manager.send({'action': 'set_program', 'feed': channel + 1})

    @pyqtSlot()
    def take(self):
        self.manager.send({'action': 'take'})

    @pyqtSlot()
    def transition(self):
        self.manager.send({'action': 'transition'})

    def onManagerUpdate(self, parameter, value):
        if value is None:
            return
            
        if parameter == 'preview':
            self.setProperty('previewChannel', value - 1)
        elif parameter == 'program':
            self.setProperty('programChannel', value - 1)
        # elif parameter == 'active_dsks':
        #     self.active_dsks = value


def main():
    # os.environ["QML_IMPORT_TRACE"] = "1"
    manager = ManagerConnection(5555, 5556)
    app = QGuiApplication(argv)

    qmlRegisterType(MainBus, 'Snowman', 1, 0, 'MainBus')
    qmlRegisterType(MainBusButton, 'Snowman', 1, 0, 'MainBusButton')
    qmlRegisterType(MainBusTransitions, 'Snowman', 1, 0, 'MainBusTransitions')

    view = QQuickView()
    view.setResizeMode(QQuickView.SizeRootObjectToView)
    sourceFile = os.path.join(os.path.dirname(__file__),'app.qml')
    view.setSource(QUrl.fromLocalFile(sourceFile))

    mainBus = view.rootObject().findChild(QQuickItem, 'mainBus')
    mainBus.setProperty('manager', manager)

    view.show()

    exit(app.exec_())

if __name__ == '__main__':
    main()
