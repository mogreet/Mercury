#!/usr/bin/python
'''
    Copyright 2011 Julien Salvi for Mogreet Inc.
    Created: Tues Nov 22 2011
'''

import sys
from PyQt4.QtCore import *
from PyQt4.QtGui import *
from introMercuryUI import Ui_Frame

class launcherIntro(QFrame):
    def __init__(self, parent=None):
        super (launcherIntro, self).__init__(parent)
        self.createFrame()
        
    def createFrame(self):
        self.ui = Ui_Frame()
        self.ui.setupUi(self)


#############################
## Launch the application ###
#############################
app = QApplication(sys.argv)
myapp = launcherIntro()
myapp.show()
sys.exit(app.exec_())
