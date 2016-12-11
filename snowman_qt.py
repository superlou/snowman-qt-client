#!/usr/bin/python3
import os
from sys import argv, exit
import setup_gl_fix
from PyQt5.QtCore import QObject, QUrl, pyqtProperty, pyqtSignal, pyqtSlot
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine, qmlRegisterType, QQmlComponent, QQmlListProperty
from PyQt5.QtQuick import QQuickItem, QQuickView
from manager_connection import ManagerConnection


class MainBusButton(QQuickItem):
    def __init__(self, parent=None):
        super().__init__(parent)


class MainBus(QQuickItem):
    def __init__(self, parent=None):
        super().__init__(parent)
        self._manager = None

    @pyqtProperty(ManagerConnection)
    def manager(self):
        return self._manager

    @manager.setter
    def manager(self, newManager):
        self._manager = newManager

    @pyqtSlot(int)
    def setPreview(self, channel):
        self.manager.send({'action': 'set_preview', 'feed': channel})

    @pyqtSlot(int)
    def setProgram(self, channel):
        self.manager.send({'action': 'set_program', 'feed': channel})


def on_manager_update(self, type, value):
    if type == 'preview':
        self.preview_feed = value
    elif type == 'program':
        self.program_feed = value
    elif type == 'active_dsks':
        self.active_dsks = value

def main():
    # os.environ["QML_IMPORT_TRACE"] = "1"
    manager = ManagerConnection(5555, 5556, on_manager_update)
    app = QGuiApplication(argv)

    qmlRegisterType(MainBus, 'Snowman', 1, 0, 'MainBus')
    qmlRegisterType(MainBusButton, 'Snowman', 1, 0, 'MainBusButton')

    view = QQuickView()
    view.setResizeMode(QQuickView.SizeRootObjectToView)
    sourceFile = os.path.join(os.path.dirname(__file__),'app.qml')
    view.setSource(QUrl.fromLocalFile(sourceFile))

    mainBus = view.rootObject().findChild(QQuickItem, 'mainBus')
    mainBus.setProperty('manager', manager)
    mainBus.setProperty('programChannel', 0)
    mainBus.setProperty('previewChannel', 1)

    view.show()

    exit(app.exec_())

if __name__ == '__main__':
    main()
