from PyQt5.QtQuick import QQuickItem
from PyQt5.QtCore import pyqtProperty, pyqtSignal, pyqtSlot
from PyQt5.QtQml import QQmlListProperty
from manager_connection import ManagerConnection


class DsksModel(QQuickItem):
    def __init__(self, parent=None):
        super().__init__(parent)
        self._manager = None
        self._activeDsks = []

    @pyqtProperty(ManagerConnection)
    def manager(self):
        return self._manager

    @manager.setter
    def manager(self, newManager):
        self._manager = newManager
        self._manager.subscribe(self.onManagerUpdate)
        self.manager.send({'action': 'sync'})

    @pyqtProperty(list)
    def activeDsks(self):
        return self._activeDsks

    @activeDsks.setter
    def setter(self, newActiveDsks):
        self._activeDsks = newActiveDsks
        print(self._activeDsks)

    @pyqtSlot(int)
    def toggleDsk(self, channel):
        self.manager.send({'action': 'toggle_dsk', 'dsk_id': channel})

    def onManagerUpdate(self, parameter, value):
        if value is None:
            return

        if parameter == 'active_dsks':
            self.setProperty('activeDsks', value)
