#!/usr/bin/python3
import os
from sys import argv, exit
import setup_gl_fix
from PyQt5.QtCore import QUrl
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import qmlRegisterType
from PyQt5.QtQuick import QQuickItem, QQuickView
from manager_connection import ManagerConnection
from components.MainBus import MainBus
from components.DSKs import DSKs
from qml_tools import *


def main():
    # os.environ["QML_IMPORT_TRACE"] = "1"
    app = QGuiApplication(argv)

    dynamic_register(['MainBusButton', 'MainBusTransitions'])
    qmlRegisterType(MainBus, 'Snowman', 1, 0, 'MainBus')
    qmlRegisterType(DSKs, 'Snowman', 1, 0, 'DSKs')

    view = QQuickView()
    view.setResizeMode(QQuickView.SizeRootObjectToView)
    sourceFile = os.path.join(os.path.dirname(__file__),'app.qml')
    view.setSource(QUrl.fromLocalFile(sourceFile))

    mainBus = view.rootObject().findChild(QQuickItem, 'mainBus')
    mainBus.setProperty('manager', ManagerConnection(5555, 5556))

    dsks = view.rootObject().findChild(QQuickItem, 'dsks')
    dsks.setProperty('manager', ManagerConnection(5555, 5556))

    view.show()

    exit(app.exec_())

if __name__ == '__main__':
    main()
