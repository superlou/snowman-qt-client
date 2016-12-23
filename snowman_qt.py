#!/usr/bin/python3
import os
from sys import argv, exit
import setup_gl_fix
from PyQt5.QtCore import QUrl
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import qmlRegisterType
from PyQt5.QtQuick import QQuickItem, QQuickView
from manager_connection import ManagerConnection
from models.MainBusModel import MainBusModel
from models.DsksModel import DsksModel
from qml_tools import *


def main():
    # os.environ["QML_IMPORT_TRACE"] = "1"
    app = QGuiApplication(argv)

    qmlRegisterType(MainBusModel, 'Snowman', 1, 0, 'MainBusModel')
    qmlRegisterType(DsksModel, 'Snowman', 1, 0, 'DsksModel')

    view = QQuickView()
    view.setResizeMode(QQuickView.SizeRootObjectToView)
    sourceFile = os.path.join(os.path.dirname(__file__),'app.qml')
    view.setSource(QUrl.fromLocalFile(sourceFile))

    mainBus = view.rootObject().findChild(QQuickItem, 'mainBusModel')
    mainBus.setProperty('manager', ManagerConnection(5555, 5556))

    dsks = view.rootObject().findChild(QQuickItem, 'dsksModel')
    dsks.setProperty('manager', ManagerConnection(5555, 5556))

    view.show()

    exit(app.exec_())

if __name__ == '__main__':
    main()
