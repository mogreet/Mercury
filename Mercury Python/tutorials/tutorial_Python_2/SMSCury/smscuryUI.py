# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'smscuryUI.ui'
#
# Created: Wed Nov 23 18:51:02 2011
#      by: PyQt4 UI code generator 4.8.3
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui
import mercury

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    _fromUtf8 = lambda s: s

class Ui_Frame(object):
    def setupUi(self, Frame):
        Frame.setObjectName(_fromUtf8("Frame"))
        Frame.resize(377, 411)
        Frame.setFrameShape(QtGui.QFrame.StyledPanel)
        Frame.setFrameShadow(QtGui.QFrame.Raised)
        self.label = QtGui.QLabel(Frame)
        self.label.setGeometry(QtCore.QRect(100, 20, 161, 20))
        font = QtGui.QFont()
        font.setWeight(75)
        font.setUnderline(True)
        font.setBold(True)
        self.label.setFont(font)
        self.label.setObjectName(_fromUtf8("label"))
        self.toNum = QtGui.QTextEdit(Frame)
        self.toNum.setGeometry(QtCore.QRect(30, 90, 321, 31))
        self.toNum.setObjectName(_fromUtf8("toNum"))
        self.label_2 = QtGui.QLabel(Frame)
        self.label_2.setGeometry(QtCore.QRect(30, 70, 321, 17))
        self.label_2.setObjectName(_fromUtf8("label_2"))
        self.fromNum = QtGui.QTextEdit(Frame)
        self.fromNum.setGeometry(QtCore.QRect(30, 170, 321, 31))
        self.fromNum.setObjectName(_fromUtf8("fromNum"))
        self.label_3 = QtGui.QLabel(Frame)
        self.label_3.setGeometry(QtCore.QRect(30, 150, 321, 17))
        self.label_3.setObjectName(_fromUtf8("label_3"))
        self.mess = QtGui.QTextEdit(Frame)
        self.mess.setGeometry(QtCore.QRect(30, 250, 321, 31))
        self.mess.setObjectName(_fromUtf8("mess"))
        self.label_4 = QtGui.QLabel(Frame)
        self.label_4.setGeometry(QtCore.QRect(30, 230, 321, 17))
        self.label_4.setObjectName(_fromUtf8("label_4"))
        self.request = QtGui.QLabel(Frame)
        self.request.setGeometry(QtCore.QRect(100, 360, 171, 20))
        font = QtGui.QFont()
        font.setWeight(75)
        font.setBold(True)
        self.request.setFont(font)
        self.request.setObjectName(_fromUtf8("request"))
        self.send = QtGui.QPushButton(Frame)
        self.send.setGeometry(QtCore.QRect(130, 310, 97, 27))
        self.send.setObjectName(_fromUtf8("send"))

        self.send.clicked.connect(self.sendSMS)

        self.retranslateUi(Frame)
        QtCore.QMetaObject.connectSlotsByName(Frame)

    def sendSMS(self):
        
        myMercury = mercury.Mercury("536", "102ed2ad568f913a31aeace02eeae234")
        toNumber = str(self.toNum.toPlainText())
        fromNumber = str(self.fromNum.toPlainText())
        message = str(self.mess.toPlainText())

        paramsSend = {"campaign_id":"10651", "to":toNumber, "from":fromNumber, "message":message}
        mySend = myMercury.send(paramsSend)
        self.request.setText("..."+mySend.getMessage()+"...")

    def retranslateUi(self, Frame):
        Frame.setWindowTitle(QtGui.QApplication.translate("Frame", "Frame", None, QtGui.QApplication.UnicodeUTF8))
        self.label.setText(QtGui.QApplication.translate("Frame", "SMSCury: Send a SMS", None, QtGui.QApplication.UnicodeUTF8))
        self.label_2.setText(QtGui.QApplication.translate("Frame", "To Number: __________________________________", None, QtGui.QApplication.UnicodeUTF8))
        self.label_3.setText(QtGui.QApplication.translate("Frame", "From Number: _______________________________", None, QtGui.QApplication.UnicodeUTF8))
        self.label_4.setText(QtGui.QApplication.translate("Frame", "Message: ____________________________________", None, QtGui.QApplication.UnicodeUTF8))
        self.request.setText(QtGui.QApplication.translate("Frame", "...Message request...", None, QtGui.QApplication.UnicodeUTF8))
        self.send.setText(QtGui.QApplication.translate("Frame", "Send", None, QtGui.QApplication.UnicodeUTF8))

