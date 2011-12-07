#!/usr/bin/python
# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'introMercuryUI.ui'
#
# Created: Wed Nov 23 00:30:13 2011
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
		Frame.resize(482, 315)
		Frame.setFrameShape(QtGui.QFrame.StyledPanel)
		Frame.setFrameShadow(QtGui.QFrame.Raised)
		self.label = QtGui.QLabel(Frame)
		self.label.setGeometry(QtCore.QRect(140, 20, 211, 17))
		font = QtGui.QFont()
		font.setWeight(75)
		font.setUnderline(True)
		font.setBold(True)
		self.label.setFont(font)
		self.label.setObjectName(_fromUtf8("label"))
		self.clientField = QtGui.QTextEdit(Frame)
		self.clientField.setGeometry(QtCore.QRect(30, 100, 104, 31))
		self.clientField.setObjectName(_fromUtf8("clientField"))
		self.label_2 = QtGui.QLabel(Frame)
		self.label_2.setGeometry(QtCore.QRect(30, 80, 71, 17))
		self.label_2.setObjectName(_fromUtf8("label_2"))
		self.tokenField = QtGui.QTextEdit(Frame)
		self.tokenField.setGeometry(QtCore.QRect(180, 100, 271, 31))
		self.tokenField.setObjectName(_fromUtf8("tokenField"))
		self.label_3 = QtGui.QLabel(Frame)
		self.label_3.setGeometry(QtCore.QRect(180, 80, 67, 17))
		self.label_3.setObjectName(_fromUtf8("label_3"))
		self.label_4 = QtGui.QLabel(Frame)
		self.label_4.setGeometry(QtCore.QRect(30, 210, 211, 17))
		font = QtGui.QFont()
		font.setWeight(75)
		font.setBold(True)
		self.label_4.setFont(font)
		self.label_4.setObjectName(_fromUtf8("label_4"))
		self.pingRepCode = QtGui.QLabel(Frame)
		self.pingRepCode.setGeometry(QtCore.QRect(30, 240, 271, 17))
		self.pingRepCode.setObjectName(_fromUtf8("pingRepCode"))
		self.pingRepStatus = QtGui.QLabel(Frame)
		self.pingRepStatus.setGeometry(QtCore.QRect(30, 260, 321, 17))
		self.pingRepStatus.setObjectName(_fromUtf8("pingRepStatus"))
		self.pingMess = QtGui.QLabel(Frame)
		self.pingMess.setGeometry(QtCore.QRect(30, 280, 361, 17))
		self.pingMess.setObjectName(_fromUtf8("pingMess"))
		self.validate = QtGui.QPushButton(Frame)
		self.validate.setGeometry(QtCore.QRect(170, 150, 97, 27))
		self.validate.setObjectName(_fromUtf8("validate"))
		self.validate.clicked.connect(self.validateCall)

		self.retranslateUi(Frame)
		QtCore.QMetaObject.connectSlotsByName(Frame)

	def validateCall(self):
		client_id = str(self.clientField.toPlainText())        
		token = str(self.tokenField.toPlainText())

		#Creation of the Ping call
		myMercury = mercury.Mercury(client_id, token)
		myPing = myMercury.ping()

		#Displaying the call's parameters
		self.pingRepCode.setText("Response Code: "+myPing.getResponseCode())
		self.pingRepStatus.setText("Response Status: "+myPing.getResponseStatus())
		self.pingMess.setText("Message: "+myPing.getMessage())

	def retranslateUi(self, Frame):
		Frame.setWindowTitle(QtGui.QApplication.translate("Frame", "Frame", None, QtGui.QApplication.UnicodeUTF8))
		self.label.setText(QtGui.QApplication.translate("Frame", "Ping call to the Mogreet API", None, QtGui.QApplication.UnicodeUTF8))
		self.label_2.setText(QtGui.QApplication.translate("Frame", "Client ID:", None, QtGui.QApplication.UnicodeUTF8))
		self.label_3.setText(QtGui.QApplication.translate("Frame", "Token: ", None, QtGui.QApplication.UnicodeUTF8))
		self.label_4.setText(QtGui.QApplication.translate("Frame", "Response to the Ping call: ", None, QtGui.QApplication.UnicodeUTF8))
		self.pingRepCode.setText(QtGui.QApplication.translate("Frame", "Response Code: ", None, QtGui.QApplication.UnicodeUTF8))
		self.pingRepStatus.setText(QtGui.QApplication.translate("Frame", "Response Status: ", None, QtGui.QApplication.UnicodeUTF8))
		self.pingMess.setText(QtGui.QApplication.translate("Frame", "Message: ", None, QtGui.QApplication.UnicodeUTF8))
		self.validate.setText(QtGui.QApplication.translate("Frame", "Validate", None, QtGui.QApplication.UnicodeUTF8))

