from PyQt5.QtQuick import QQuickItem
from PyQt5.QtQml import qmlRegisterType
from glob import glob


# Need to hold references to dynamic components
dynamic_components = []


def dynamic_register(class_name):
    if isinstance(class_name, (list, tuple)):
        for individual in class_name:
            dynamic_register(individual)
    else:
        Component = type(class_name, (QQuickItem,), {})
        qmlRegisterType(Component , 'Snowman', 1, 0, class_name)
        dynamic_components.append(Component)
