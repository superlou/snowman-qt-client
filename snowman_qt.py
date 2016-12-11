#!/usr/bin/python3
import os
from sys import argv, exit
import setup_gl_fix
from PyQt5.QtCore import QObject, QUrl, pyqtProperty, pyqtSignal, pyqtSlot
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine, qmlRegisterType, QQmlComponent, QQmlListProperty
from PyQt5.QtQuick import QQuickItem, QQuickView


class MainBusButton(QQuickItem):
    def __init__(self, parent=None):
        super().__init__(parent)


class MainBus(QQuickItem):
    def __init__(self, parent=None):
        super().__init__(parent)

    @pyqtSlot(int)
    def setPreview(self, channel):
        print("preview:", channel)

    @pyqtSlot(int)
    def setProgram(self, channel):
        print("program:", channel)


def main():
    # os.environ["QML_IMPORT_TRACE"] = "1"
    app = QGuiApplication(argv)

    qmlRegisterType(MainBus, 'Snowman', 1, 0, 'MainBus')
    qmlRegisterType(MainBusButton, 'Snowman', 1, 0, 'MainBusButton')

    view = QQuickView()
    view.setResizeMode(QQuickView.SizeRootObjectToView)
    sourceFile = os.path.join(os.path.dirname(__file__),'app.qml')
    view.setSource(QUrl.fromLocalFile(sourceFile))

    mainBus = view.rootObject().findChild(QQuickItem, 'mainBus')
    mainBus.setProperty('programChannel', 0)
    mainBus.setProperty('previewChannel', 1)

    view.show()

    exit(app.exec_())

if __name__ == '__main__':
    main()
