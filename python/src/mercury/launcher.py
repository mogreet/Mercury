'''
    Copyright 2011 Julien Salvi for Mogreet Inc.
    Created: Mon Nov 21 2011
'''

import sys
from PyQt4.QtCore import *
from PyQt4.QtGui import *
from mercuryUI import Ui_TabWidget

class MercuryLauncher(QTabWidget):
    def __init__(self, parent=None):
        super (MercuryLauncher, self).__init__(parent)
        self.createWidgets()
        
    def createWidgets(self):
        self.ui = Ui_TabWidget()
        self.ui.setupUi(self)


#############################
## Launch the application ###
#############################
app = QApplication(sys.argv)
myapp = MercuryLauncher()
myapp.show()
sys.exit(app.exec_())
        
