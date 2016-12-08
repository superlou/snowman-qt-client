# Work-around for https://bugs.launchpad.net/ubuntu/+source/python-qt4/+bug/941826
import ctypes
from ctypes import util
ctypes.CDLL(util.find_library('GL'), ctypes.RTLD_GLOBAL)
