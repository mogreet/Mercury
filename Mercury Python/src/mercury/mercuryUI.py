# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'MercuryUI.ui'
#
# Created: Mon Nov 21 19:57:14 2011
#      by: PyQt4 UI code generator 4.8.3
#  Author: Julien SALVI
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui
import mercury

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    _fromUtf8 = lambda s: s

class Ui_TabWidget(object):
    
    def setupUi(self, TabWidget):
        TabWidget.setObjectName(_fromUtf8("TabWidget"))
        TabWidget.resize(509, 557)
        
        self.pingTab = QtGui.QWidget()
        self.pingTab.setObjectName(_fromUtf8("pingTab"))
        self.label = QtGui.QLabel(self.pingTab)
        self.label.setGeometry(QtCore.QRect(140, 10, 211, 31))
        font = QtGui.QFont()
        font.setWeight(75)
        font.setUnderline(True)
        font.setBold(True)
        self.label.setFont(font)
        self.label.setObjectName(_fromUtf8("label"))
        self.label_2 = QtGui.QLabel(self.pingTab)
        self.label_2.setGeometry(QtCore.QRect(130, 50, 241, 20))
        self.label_2.setObjectName(_fromUtf8("label_2"))
        self.clientIDField = QtGui.QTextEdit(self.pingTab)
        self.clientIDField.setGeometry(QtCore.QRect(60, 140, 111, 31))
        self.clientIDField.setObjectName(_fromUtf8("clientIDField"))
        self.label_3 = QtGui.QLabel(self.pingTab)
        self.label_3.setGeometry(QtCore.QRect(60, 120, 67, 17))
        self.label_3.setObjectName(_fromUtf8("label_3"))
        self.label_4 = QtGui.QLabel(self.pingTab)
        self.label_4.setGeometry(QtCore.QRect(210, 120, 67, 17))
        self.label_4.setObjectName(_fromUtf8("label_4"))
        self.tokenField = QtGui.QTextEdit(self.pingTab)
        self.tokenField.setGeometry(QtCore.QRect(210, 140, 271, 31))
        self.tokenField.setObjectName(_fromUtf8("tokenField"))
        self.pingButton = QtGui.QPushButton(self.pingTab)
        self.pingButton.setGeometry(QtCore.QRect(190, 200, 111, 31))
        self.pingButton.setObjectName(_fromUtf8("pingButton"))
        
        #Implementation of the button listener for the Ping call
        self.pingButton.clicked.connect(self.clickPingButton)
        
        self.label_5 = QtGui.QLabel(self.pingTab)
        self.label_5.setGeometry(QtCore.QRect(40, 280, 171, 31))
        font = QtGui.QFont()
        font.setWeight(75)
        font.setUnderline(True)
        font.setBold(True)
        self.label_5.setFont(font)
        self.label_5.setObjectName(_fromUtf8("label_5"))
        self.pingRepCode = QtGui.QLabel(self.pingTab)
        self.pingRepCode.setGeometry(QtCore.QRect(40, 320, 211, 17))
        self.pingRepCode.setObjectName(_fromUtf8("pingRepCode"))
        self.pingRepStatus = QtGui.QLabel(self.pingTab)
        self.pingRepStatus.setGeometry(QtCore.QRect(40, 340, 211, 17))
        self.pingRepStatus.setObjectName(_fromUtf8("pingRepStatus"))
        self.pingMess = QtGui.QLabel(self.pingTab)
        self.pingMess.setGeometry(QtCore.QRect(40, 360, 281, 17))
        self.pingMess.setObjectName(_fromUtf8("pingMess"))
        TabWidget.addTab(self.pingTab, _fromUtf8(""))
        
        
        self.lookupTab = QtGui.QWidget()
        self.lookupTab.setObjectName(_fromUtf8("lookupTab"))
        self.label_6 = QtGui.QLabel(self.lookupTab)
        self.label_6.setGeometry(QtCore.QRect(120, 40, 261, 20))
        font = QtGui.QFont()
        font.setWeight(75)
        font.setBold(True)
        self.label_6.setFont(font)
        self.label_6.setObjectName(_fromUtf8("label_6"))
        self.lookmessidField = QtGui.QTextEdit(self.lookupTab)
        self.lookmessidField.setGeometry(QtCore.QRect(70, 120, 151, 31))
        self.lookmessidField.setObjectName(_fromUtf8("lookmessidField"))
        self.label_7 = QtGui.QLabel(self.lookupTab)
        self.label_7.setGeometry(QtCore.QRect(70, 100, 91, 17))
        self.label_7.setObjectName(_fromUtf8("label_7"))
        self.lookHashField = QtGui.QTextEdit(self.lookupTab)
        self.lookHashField.setGeometry(QtCore.QRect(250, 120, 151, 31))
        self.lookHashField.setObjectName(_fromUtf8("lookHashField"))
        self.label_8 = QtGui.QLabel(self.lookupTab)
        self.label_8.setGeometry(QtCore.QRect(250, 100, 67, 17))
        self.label_8.setObjectName(_fromUtf8("label_8"))
        self.lookButton = QtGui.QPushButton(self.lookupTab)
        self.lookButton.setGeometry(QtCore.QRect(190, 180, 97, 27))
        self.lookButton.setObjectName(_fromUtf8("lookButton"))
        
        #Implementation of the button listener for the lookup call:
        self.lookButton.clicked.connect(self.clickLookupButton)
        
        self.label_9 = QtGui.QLabel(self.lookupTab)
        self.label_9.setGeometry(QtCore.QRect(20, 260, 181, 17))
        font = QtGui.QFont()
        font.setWeight(75)
        font.setUnderline(True)
        font.setBold(True)
        self.label_9.setFont(font)
        self.label_9.setObjectName(_fromUtf8("label_9"))
        self.lookRepCode = QtGui.QLabel(self.lookupTab)
        self.lookRepCode.setGeometry(QtCore.QRect(20, 300, 261, 17))
        self.lookRepCode.setObjectName(_fromUtf8("lookRepCode"))
        self.lookRepStatus = QtGui.QLabel(self.lookupTab)
        self.lookRepStatus.setGeometry(QtCore.QRect(20, 320, 301, 17))
        self.lookRepStatus.setObjectName(_fromUtf8("lookRepStatus"))
        self.lookMess = QtGui.QLabel(self.lookupTab)
        self.lookMess.setGeometry(QtCore.QRect(20, 340, 381, 17))
        self.lookMess.setObjectName(_fromUtf8("lookMess"))
        self.lookCampid = QtGui.QLabel(self.lookupTab)
        self.lookCampid.setGeometry(QtCore.QRect(20, 360, 181, 17))
        self.lookCampid.setObjectName(_fromUtf8("lookCampid"))
        self.lookFromNum = QtGui.QLabel(self.lookupTab)
        self.lookFromNum.setGeometry(QtCore.QRect(20, 380, 241, 17))
        self.lookFromNum.setObjectName(_fromUtf8("lookFromNum"))
        self.lookFromName = QtGui.QLabel(self.lookupTab)
        self.lookFromName.setGeometry(QtCore.QRect(270, 380, 221, 17))
        self.lookFromName.setObjectName(_fromUtf8("lookFromName"))
        self.lookToNum = QtGui.QLabel(self.lookupTab)
        self.lookToNum.setGeometry(QtCore.QRect(20, 400, 221, 17))
        self.lookToNum.setObjectName(_fromUtf8("lookToNum"))
        self.lookToName = QtGui.QLabel(self.lookupTab)
        self.lookToName.setGeometry(QtCore.QRect(270, 400, 231, 17))
        self.lookToName.setObjectName(_fromUtf8("lookToName"))
        self.lookContentid = QtGui.QLabel(self.lookupTab)
        self.lookContentid.setGeometry(QtCore.QRect(20, 420, 211, 17))
        self.lookContentid.setObjectName(_fromUtf8("lookContentid"))
        self.lookStatus = QtGui.QLabel(self.lookupTab)
        self.lookStatus.setGeometry(QtCore.QRect(20, 440, 261, 17))
        self.lookStatus.setObjectName(_fromUtf8("lookStatus"))
        self.lookEvts = QtGui.QLabel(self.lookupTab)
        self.lookEvts.setGeometry(QtCore.QRect(20, 460, 461, 31))
        self.lookEvts.setObjectName(_fromUtf8("lookEvts"))
        TabWidget.addTab(self.lookupTab, _fromUtf8(""))
        
        
        self.sendTab = QtGui.QWidget()
        self.sendTab.setObjectName(_fromUtf8("sendTab"))
        self.label_11 = QtGui.QLabel(self.sendTab)
        self.label_11.setGeometry(QtCore.QRect(110, 40, 271, 20))
        font = QtGui.QFont()
        font.setWeight(75)
        font.setBold(True)
        self.label_11.setFont(font)
        self.label_11.setObjectName(_fromUtf8("label_11"))
        self.sendCampidField = QtGui.QTextEdit(self.sendTab)
        self.sendCampidField.setGeometry(QtCore.QRect(60, 100, 171, 31))
        self.sendCampidField.setObjectName(_fromUtf8("sendCampidField"))
        self.label_10 = QtGui.QLabel(self.sendTab)
        self.label_10.setGeometry(QtCore.QRect(60, 80, 101, 17))
        self.label_10.setObjectName(_fromUtf8("label_10"))
        self.label_12 = QtGui.QLabel(self.sendTab)
        self.label_12.setGeometry(QtCore.QRect(260, 80, 111, 17))
        self.label_12.setObjectName(_fromUtf8("label_12"))
        self.sendToNumField = QtGui.QTextEdit(self.sendTab)
        self.sendToNumField.setGeometry(QtCore.QRect(60, 170, 171, 31))
        self.sendToNumField.setObjectName(_fromUtf8("sendToNumField"))
        self.label_13 = QtGui.QLabel(self.sendTab)
        self.label_13.setGeometry(QtCore.QRect(60, 150, 111, 17))
        self.label_13.setObjectName(_fromUtf8("label_13"))
        self.sendMessField = QtGui.QTextEdit(self.sendTab)
        self.sendMessField.setGeometry(QtCore.QRect(260, 170, 171, 31))
        self.sendMessField.setObjectName(_fromUtf8("sendMessField"))
        self.label_14 = QtGui.QLabel(self.sendTab)
        self.label_14.setGeometry(QtCore.QRect(260, 150, 81, 17))
        self.label_14.setObjectName(_fromUtf8("label_14"))
        self.sendContentField = QtGui.QTextEdit(self.sendTab)
        self.sendContentField.setGeometry(QtCore.QRect(200, 240, 101, 31))
        self.sendContentField.setObjectName(_fromUtf8("sendContentField"))
        self.label_15 = QtGui.QLabel(self.sendTab)
        self.label_15.setGeometry(QtCore.QRect(200, 220, 101, 17))
        self.label_15.setObjectName(_fromUtf8("label_15"))
        self.sendFromNumField = QtGui.QTextEdit(self.sendTab)
        self.sendFromNumField.setGeometry(QtCore.QRect(260, 100, 171, 31))
        self.sendFromNumField.setObjectName(_fromUtf8("sendFromNumField"))
        self.sendButton = QtGui.QPushButton(self.sendTab)
        self.sendButton.setGeometry(QtCore.QRect(200, 290, 97, 27))
        self.sendButton.setObjectName(_fromUtf8("sendButton"))
        
        #Implementation of the button listener for the send call:
        self.sendButton.clicked.connect(self.clickSendButton)
        
        self.label_16 = QtGui.QLabel(self.sendTab)
        self.label_16.setGeometry(QtCore.QRect(10, 330, 191, 17))
        font = QtGui.QFont()
        font.setWeight(75)
        font.setUnderline(True)
        font.setBold(True)
        self.label_16.setFont(font)
        self.label_16.setObjectName(_fromUtf8("label_16"))
        self.sendRepCode = QtGui.QLabel(self.sendTab)
        self.sendRepCode.setGeometry(QtCore.QRect(10, 360, 221, 17))
        self.sendRepCode.setObjectName(_fromUtf8("sendRepCode"))
        self.sendRepStatus = QtGui.QLabel(self.sendTab)
        self.sendRepStatus.setGeometry(QtCore.QRect(10, 380, 241, 17))
        self.sendRepStatus.setObjectName(_fromUtf8("sendRepStatus"))
        self.sendMess = QtGui.QLabel(self.sendTab)
        self.sendMess.setGeometry(QtCore.QRect(10, 400, 211, 17))
        self.sendMess.setObjectName(_fromUtf8("sendMess"))
        self.sendMessid = QtGui.QLabel(self.sendTab)
        self.sendMessid.setGeometry(QtCore.QRect(10, 420, 231, 17))
        self.sendMessid.setObjectName(_fromUtf8("sendMessid"))
        self.sendHash = QtGui.QLabel(self.sendTab)
        self.sendHash.setGeometry(QtCore.QRect(10, 440, 191, 17))
        self.sendHash.setObjectName(_fromUtf8("sendHash"))
        TabWidget.addTab(self.sendTab, _fromUtf8(""))
        
        
        self.getoptTab = QtGui.QWidget()
        self.getoptTab.setObjectName(_fromUtf8("getoptTab"))
        self.label_17 = QtGui.QLabel(self.getoptTab)
        self.label_17.setGeometry(QtCore.QRect(110, 40, 291, 20))
        font = QtGui.QFont()
        font.setWeight(75)
        font.setBold(True)
        self.label_17.setFont(font)
        self.label_17.setObjectName(_fromUtf8("label_17"))
        self.getNumField = QtGui.QTextEdit(self.getoptTab)
        self.getNumField.setGeometry(QtCore.QRect(30, 110, 191, 31))
        self.getNumField.setObjectName(_fromUtf8("getNumField"))
        self.label_18 = QtGui.QLabel(self.getoptTab)
        self.label_18.setGeometry(QtCore.QRect(30, 90, 111, 17))
        self.label_18.setObjectName(_fromUtf8("label_18"))
        self.getCampidField = QtGui.QTextEdit(self.getoptTab)
        self.getCampidField.setGeometry(QtCore.QRect(270, 110, 201, 31))
        self.getCampidField.setObjectName(_fromUtf8("getCampidField"))
        self.label_19 = QtGui.QLabel(self.getoptTab)
        self.label_19.setGeometry(QtCore.QRect(270, 90, 141, 17))
        self.label_19.setObjectName(_fromUtf8("label_19"))
        self.getButton = QtGui.QPushButton(self.getoptTab)
        self.getButton.setGeometry(QtCore.QRect(190, 180, 97, 27))
        self.getButton.setObjectName(_fromUtf8("getButton"))
        
        #Implementation of the button listener for the getopt call:
        self.getButton.clicked.connect(self.clickGetoptButton)
        
        self.label_20 = QtGui.QLabel(self.getoptTab)
        self.label_20.setGeometry(QtCore.QRect(20, 260, 181, 17))
        font = QtGui.QFont()
        font.setWeight(75)
        font.setUnderline(True)
        font.setBold(True)
        self.label_20.setFont(font)
        self.label_20.setObjectName(_fromUtf8("label_20"))
        self.getRepCode = QtGui.QLabel(self.getoptTab)
        self.getRepCode.setGeometry(QtCore.QRect(20, 290, 191, 17))
        self.getRepCode.setObjectName(_fromUtf8("getRepCode"))
        self.getRepStatus = QtGui.QLabel(self.getoptTab)
        self.getRepStatus.setGeometry(QtCore.QRect(20, 310, 231, 17))
        self.getRepStatus.setObjectName(_fromUtf8("getRepStatus"))
        self.getMess = QtGui.QLabel(self.getoptTab)
        self.getMess.setGeometry(QtCore.QRect(20, 330, 250, 17))
        self.getMess.setObjectName(_fromUtf8("getMess"))
        self.getCampStatusCode = QtGui.QLabel(self.getoptTab)
        self.getCampStatusCode.setGeometry(QtCore.QRect(20, 350, 301, 17))
        self.getCampStatusCode.setObjectName(_fromUtf8("getCampStatusCode"))
        self.getCampStat = QtGui.QLabel(self.getoptTab)
        self.getCampStat.setGeometry(QtCore.QRect(20, 370, 281, 17))
        self.getCampStat.setObjectName(_fromUtf8("getCampStat"))
        TabWidget.addTab(self.getoptTab, _fromUtf8(""))
        
        
        self.infoTab = QtGui.QWidget()
        self.infoTab.setObjectName(_fromUtf8("infoTab"))
        self.label_21 = QtGui.QLabel(self.infoTab)
        self.label_21.setGeometry(QtCore.QRect(120, 40, 271, 20))
        font = QtGui.QFont()
        font.setWeight(75)
        font.setBold(True)
        self.label_21.setFont(font)
        self.label_21.setObjectName(_fromUtf8("label_21"))
        self.infoNumField = QtGui.QTextEdit(self.infoTab)
        self.infoNumField.setGeometry(QtCore.QRect(10, 120, 181, 31))
        self.infoNumField.setObjectName(_fromUtf8("infoNumField"))
        self.label_22 = QtGui.QLabel(self.infoTab)
        self.label_22.setGeometry(QtCore.QRect(10, 100, 151, 17))
        self.label_22.setObjectName(_fromUtf8("label_22"))
        self.infoButton = QtGui.QPushButton(self.infoTab)
        self.infoButton.setGeometry(QtCore.QRect(190, 200, 97, 27))
        self.infoButton.setObjectName(_fromUtf8("infoButton"))
        
        #Implementation of the button listener for the info call:
        self.infoButton.clicked.connect(self.clickInfoButton)
        
        self.label_23 = QtGui.QLabel(self.infoTab)
        self.label_23.setGeometry(QtCore.QRect(10, 270, 191, 17))
        font = QtGui.QFont()
        font.setWeight(75)
        font.setUnderline(True)
        font.setBold(True)
        self.label_23.setFont(font)
        self.label_23.setObjectName(_fromUtf8("label_23"))
        self.infoRepCode = QtGui.QLabel(self.infoTab)
        self.infoRepCode.setGeometry(QtCore.QRect(10, 300, 171, 17))
        self.infoRepCode.setObjectName(_fromUtf8("infoRepCode"))
        self.infoRepStatus = QtGui.QLabel(self.infoTab)
        self.infoRepStatus.setGeometry(QtCore.QRect(10, 320, 211, 17))
        self.infoRepStatus.setObjectName(_fromUtf8("infoRepStatus"))
        self.infoMess = QtGui.QLabel(self.infoTab)
        self.infoMess.setGeometry(QtCore.QRect(10, 340, 261, 17))
        self.infoMess.setObjectName(_fromUtf8("infoMess"))
        self.infoNum = QtGui.QLabel(self.infoTab)
        self.infoNum.setGeometry(QtCore.QRect(10, 360, 241, 17))
        self.infoNum.setObjectName(_fromUtf8("infoNum"))
        self.infoCarrier = QtGui.QLabel(self.infoTab)
        self.infoCarrier.setGeometry(QtCore.QRect(10, 380, 231, 17))
        self.infoCarrier.setObjectName(_fromUtf8("infoCarrier"))
        self.infoCarrid = QtGui.QLabel(self.infoTab)
        self.infoCarrid.setGeometry(QtCore.QRect(250, 380, 191, 17))
        self.infoCarrid.setObjectName(_fromUtf8("infoCarrid"))
        self.infoHand = QtGui.QLabel(self.infoTab)
        self.infoHand.setGeometry(QtCore.QRect(10, 400, 231, 17))
        self.infoHand.setObjectName(_fromUtf8("infoHand"))
        self.infoHandid = QtGui.QLabel(self.infoTab)
        self.infoHandid.setGeometry(QtCore.QRect(250, 400, 201, 17))
        self.infoHandid.setObjectName(_fromUtf8("infoHandid"))
        TabWidget.addTab(self.infoTab, _fromUtf8(""))
        
        
        self.setoptTab = QtGui.QWidget()
        self.setoptTab.setObjectName(_fromUtf8("setoptTab"))
        self.label_24 = QtGui.QLabel(self.setoptTab)
        self.label_24.setGeometry(QtCore.QRect(110, 40, 291, 20))
        font = QtGui.QFont()
        font.setWeight(75)
        font.setBold(True)
        self.label_24.setFont(font)
        self.label_24.setObjectName(_fromUtf8("label_24"))
        self.setNumField = QtGui.QTextEdit(self.setoptTab)
        self.setNumField.setGeometry(QtCore.QRect(160, 110, 151, 31))
        self.setNumField.setObjectName(_fromUtf8("setNumField"))
        self.label_25 = QtGui.QLabel(self.setoptTab)
        self.label_25.setGeometry(QtCore.QRect(160, 90, 121, 17))
        self.label_25.setObjectName(_fromUtf8("label_25"))
        self.setCampidField = QtGui.QTextEdit(self.setoptTab)
        self.setCampidField.setGeometry(QtCore.QRect(70, 170, 131, 31))
        self.setCampidField.setObjectName(_fromUtf8("setCampidField"))
        self.label_26 = QtGui.QLabel(self.setoptTab)
        self.label_26.setGeometry(QtCore.QRect(70, 150, 111, 17))
        self.label_26.setObjectName(_fromUtf8("label_26"))
        self.setCampSCField = QtGui.QTextEdit(self.setoptTab)
        self.setCampSCField.setGeometry(QtCore.QRect(240, 170, 191, 31))
        self.setCampSCField.setObjectName(_fromUtf8("setCampSCField"))
        self.label_27 = QtGui.QLabel(self.setoptTab)
        self.label_27.setGeometry(QtCore.QRect(240, 150, 191, 17))
        self.label_27.setObjectName(_fromUtf8("label_27"))
        self.label_28 = QtGui.QLabel(self.setoptTab)
        self.label_28.setGeometry(QtCore.QRect(10, 270, 201, 17))
        self.setButton = QtGui.QPushButton(self.setoptTab)
        self.setButton.setGeometry(QtCore.QRect(200, 230, 97, 27))
        self.setButton.setObjectName(_fromUtf8("setButton"))
        
        #Implementation of the button listener for the setopt call:
        self.setButton.clicked.connect(self.clickSetoptButton)
        
        font = QtGui.QFont()
        font.setWeight(75)
        font.setUnderline(True)
        font.setBold(True)
        self.label_28.setFont(font)
        self.label_28.setObjectName(_fromUtf8("label_28"))
        self.setRepCode = QtGui.QLabel(self.setoptTab)
        self.setRepCode.setGeometry(QtCore.QRect(10, 300, 211, 17))
        self.setRepCode.setObjectName(_fromUtf8("setRepCode"))
        self.setRepStatus = QtGui.QLabel(self.setoptTab)
        self.setRepStatus.setGeometry(QtCore.QRect(10, 320, 161, 17))
        self.setRepStatus.setObjectName(_fromUtf8("setRepStatus"))
        self.setMess = QtGui.QLabel(self.setoptTab)
        self.setMess.setGeometry(QtCore.QRect(10, 340, 241, 17))
        self.setMess.setObjectName(_fromUtf8("setMess"))
        TabWidget.addTab(self.setoptTab, _fromUtf8(""))
        
        
        self.transTab = QtGui.QWidget()
        self.transTab.setObjectName(_fromUtf8("transTab"))
        self.label_29 = QtGui.QLabel(self.transTab)
        self.label_29.setGeometry(QtCore.QRect(70, 40, 351, 20))
        font = QtGui.QFont()
        font.setWeight(75)
        font.setBold(True)
        self.label_29.setFont(font)
        self.label_29.setObjectName(_fromUtf8("label_29"))
        self.tranNumField = QtGui.QTextEdit(self.transTab)
        self.tranNumField.setGeometry(QtCore.QRect(160, 110, 181, 31))
        self.tranNumField.setObjectName(_fromUtf8("tranNumField"))
        self.label_30 = QtGui.QLabel(self.transTab)
        self.label_30.setGeometry(QtCore.QRect(160, 90, 161, 17))
        self.label_30.setObjectName(_fromUtf8("label_30"))
        self.tranButton = QtGui.QPushButton(self.transTab)
        self.tranButton.setGeometry(QtCore.QRect(200, 190, 97, 27))
        self.tranButton.setObjectName(_fromUtf8("tranButton"))
        
        #Implementation of the button listener for the transactions call:
        self.tranButton.clicked.connect(self.clickTransactionsButton)
        
        self.label_32 = QtGui.QLabel(self.transTab)
        self.label_32.setGeometry(QtCore.QRect(10, 280, 241, 17))
        font = QtGui.QFont()
        font.setWeight(75)
        font.setUnderline(True)
        font.setBold(True)
        self.label_32.setFont(font)
        self.label_32.setObjectName(_fromUtf8("label_32"))
        self.tranRepCode = QtGui.QLabel(self.transTab)
        self.tranRepCode.setGeometry(QtCore.QRect(10, 310, 211, 17))
        self.tranRepCode.setObjectName(_fromUtf8("tranRepCode"))
        self.tranRepStatus = QtGui.QLabel(self.transTab)
        self.tranRepStatus.setGeometry(QtCore.QRect(10, 330, 231, 17))
        self.tranRepStatus.setObjectName(_fromUtf8("tranRepStatus"))
        self.tranMess = QtGui.QLabel(self.transTab)
        self.tranMess.setGeometry(QtCore.QRect(10, 350, 231, 17))
        self.tranMess.setObjectName(_fromUtf8("tranMess"))
        self.tranCampid = QtGui.QLabel(self.transTab)
        self.tranCampid.setGeometry(QtCore.QRect(10, 370, 481, 17))
        self.tranCampid.setObjectName(_fromUtf8("tranCampid"))
        self.tranMessid = QtGui.QLabel(self.transTab)
        self.tranMessid.setGeometry(QtCore.QRect(10, 390, 491, 17))
        self.tranMessid.setObjectName(_fromUtf8("tranMessid"))
        TabWidget.addTab(self.transTab, _fromUtf8(""))
        
        
        self.uncacheTab = QtGui.QWidget()
        self.uncacheTab.setObjectName(_fromUtf8("uncacheTab"))
        self.label_33 = QtGui.QLabel(self.uncacheTab)
        self.label_33.setGeometry(QtCore.QRect(90, 40, 301, 20))
        font = QtGui.QFont()
        font.setWeight(75)
        font.setBold(True)
        self.label_33.setFont(font)
        self.label_33.setObjectName(_fromUtf8("label_33"))
        self.uncNumField = QtGui.QTextEdit(self.uncacheTab)
        self.uncNumField.setGeometry(QtCore.QRect(180, 110, 141, 31))
        self.uncNumField.setObjectName(_fromUtf8("uncNumField"))
        self.label_34 = QtGui.QLabel(self.uncacheTab)
        self.label_34.setGeometry(QtCore.QRect(180, 90, 131, 17))
        self.label_34.setObjectName(_fromUtf8("label_34"))
        self.uncButton = QtGui.QPushButton(self.uncacheTab)
        self.uncButton.setGeometry(QtCore.QRect(200, 180, 97, 27))
        self.uncButton.setObjectName(_fromUtf8("uncButton"))
        
        #Implementation of the button listener for the uncache call:
        self.uncButton.clicked.connect(self.clickUncacheButton)
        
        self.label_35 = QtGui.QLabel(self.uncacheTab)
        self.label_35.setGeometry(QtCore.QRect(10, 260, 211, 17))
        font = QtGui.QFont()
        font.setWeight(75)
        font.setUnderline(True)
        font.setBold(True)
        self.label_35.setFont(font)
        self.label_35.setObjectName(_fromUtf8("label_35"))
        self.uncRepCode = QtGui.QLabel(self.uncacheTab)
        self.uncRepCode.setGeometry(QtCore.QRect(10, 290, 211, 17))
        self.uncRepCode.setObjectName(_fromUtf8("uncRepCode"))
        self.uncRepStatus = QtGui.QLabel(self.uncacheTab)
        self.uncRepStatus.setGeometry(QtCore.QRect(10, 310, 261, 17))
        self.uncRepStatus.setObjectName(_fromUtf8("uncRepStatus"))
        self.uncMess = QtGui.QLabel(self.uncacheTab)
        self.uncMess.setGeometry(QtCore.QRect(10, 330, 231, 17))
        self.uncMess.setObjectName(_fromUtf8("uncMess"))
        self.uncNum = QtGui.QLabel(self.uncacheTab)
        self.uncNum.setGeometry(QtCore.QRect(10, 350, 251, 17))
        self.uncNum.setObjectName(_fromUtf8("uncNum"))
        TabWidget.addTab(self.uncacheTab, _fromUtf8(""))

        self.retranslateUi(TabWidget)
        TabWidget.setCurrentIndex(0)
        QtCore.QMetaObject.connectSlotsByName(TabWidget)
                
    def clickPingButton(self):
		'''
		Button listener for the Ping call
		'''
		client_id = str(self.clientIDField.toPlainText())
		token = str(self.tokenField.toPlainText())

		#Creation of the Ping call
		self.myMercury = mercury.Mercury(client_id, token)
		myPing = self.myMercury.ping()

		#Displaying the call's parameters
		self.pingRepCode.setText("Response Code: "+myPing.getResponseCode())
		self.pingRepStatus.setText("Response Status: "+myPing.getResponseStatus())
		self.pingMess.setText("Message: "+myPing.getMessage())
        
    def clickLookupButton(self):
        '''
        Button Listener for the Lookup call
        '''
        _hash = str(self.lookHashField.toPlainText())
        _messId = str(self.lookmessidField.toPlainText())
        
        #Creation of the lookup call with its parameters
        paramsLook = {"message_id":_messId, "hash":_hash}
        myLookup = self.myMercury.lookup(paramsLook)
        
        #Displaying the call's parameters
        self.lookRepCode.setText("Response Code: "+myLookup.getResponseCode())
        self.lookRepStatus.setText("Response Status: "+myLookup.getResponseStatus())
        self.lookMess.setText("Message: "+myLookup.getMessage())
        self.lookCampid.setText("Campaign ID: "+myLookup.getCampaignID())
        self.lookFromNum.setText("From Number: "+myLookup.getFromNumber())
        self.lookFromName.setText("From Name: "+myLookup.getFromName())
        self.lookToNum.setText("To Number: "+myLookup.getToNumber())
        self.lookToName.setText("To Name: "+myLookup.getToName())
        self.lookContentid.setText("Content ID: "+myLookup.getContentID())
        self.lookStatus.setText("Status: "+myLookup.getStatus())
        self.lookEvts.setText("History - events: "+myLookup.getEventsList()[0])
        
    def clickSendButton(self):
        '''
        Button listener for the Send call
        '''
        _campid = str(self.sendCampidField.toPlainText())
        _fromNum = str(self.sendFromNumField.toPlainText())
        _toNum = str(self.sendToNumField.toPlainText())
        _message = str(self.sendMessField.toPlainText())
        _contid = str(self.sendContentField.toPlainText())
        
        #Creation of the send call with its parameters
        paramsSend = {"campaign_id":_campid, "from":_fromNum, "to":_toNum, "message":_message, "content_id":_contid }
        mySend = self.myMercury.send(paramsSend)
        
        #Displaying the call's parameters
        self.sendRepCode.setText("Response Code: "+mySend.getResponseCode())
        self.sendRepStatus.setText("Response Status: "+mySend.getResponseStatus())
        self.sendMess.setText("Message: "+mySend.getMessage())
        self.sendMessid.setText("Message ID: "+mySend.getMessageID())
        self.sendHash.setText("Hash: "+mySend.getHash())
        
    def clickGetoptButton(self):
        '''
        Button listener for the Getopt call
        '''
        _num = str(self.getNumField.toPlainText())
        _campid = str(self.getCampidField.toPlainText())
        
        #Creation of the getopt call with its parameters
        paramsGetopt = {"number":_num, "campaign_id":_campid}
        myGetopt = self.myMercury.getopt(paramsGetopt)
        
        #Displaying the call's parameters
        self.getRepCode.setText("Response Code: "+myGetopt.getResponseCode())
        self.getRepStatus.setText("Response Status: "+myGetopt.getResponseStatus())
        self.getMess.setText("Message: "+myGetopt.getMessage())
        self.getCampStatusCode.setText("Campaign Status Code: "+myGetopt.getCampaignStatusCode(_campid))
        self.getCampStat.setText("Campaign Status: "+myGetopt.getCampaignStatus(_campid))
        
    def clickInfoButton(self):
        '''
        Button listener for the Info call
        '''
        _num = str(self.infoNumField.toPlainText())
        
        #Creation of the info call with its parameter
        paramsInfo = {"number":_num}
        myInfo = self.myMercury.info(paramsInfo)
        
        #Displaying the call's parameters
        self.infoRepCode.setText("Response Code: "+myInfo.getResponseCode())
        self.infoRepStatus.setText("Response Status: "+myInfo.getResponseStatus())
        self.infoMess.setText("Message: "+myInfo.getMessage())
        self.infoNum.setText("Number: "+myInfo.getNumber())
        self.infoCarrier.setText("Carrier: "+myInfo.getCarrier())
        self.infoCarrid.setText("Carrier ID: "+myInfo.getCarrierID())
        self.infoHand.setText("Handset: "+myInfo.getHandset())
        self.infoHandid.setText("Handset ID: "+myInfo.getHandsetID())
        
    def clickSetoptButton(self):
        '''
        Button listener for the setopt call
        '''
        _num = str(self.setNumField.toPlainText())
        _campid = str(self.setCampidField.toPlainText())
        _campSC = str(self.setCampSCField.toPlainText())
        
        #Creation of the setopt call with its parameters
        paramsSetopt = {"number":_num, "campaign_id":_campid, "status_code":_campSC}
        mySetopt = self.myMercury.setopt(paramsSetopt)
        
        #Displaying the call's parameters
        self.setRepCode.setText("Response Code: "+mySetopt.getCampaignStatusCode())
        self.setRepStatus.setText("Response Status: "+mySetopt.getResponseStatus())
        self.setMess.setText("Message: "+mySetopt.getMessage())
        
    def clickTransactionsButton(self):
        '''
        Button listener for the transactions call
        '''
        _num = str(self.tranNumField.toPlainText())
        
        #Creation of the transactions call with its parameter
        paramsTrans = {"number":_num}
        myTrans = self.myMercury.transactions(paramsTrans)
        
        #Displaying the call's parameters
        self.tranRepCode.setText("Response Code: "+myTrans.getResponseCode())
        self.tranRepStatus.setText("Response Status: "+myTrans.getResponseStatus())
        self.tranMess.setText("Message: "+myTrans.getMessage())
        self.tranCampid.setText("Campaign ID: "+myTrans.getAllCampaignIDs()[0])
        self.tranMessid.setText("Message ID: "+myTrans.getAllMessageIDs()[0])
        
    def clickUncacheButton(self):
        '''
        Button listener for the uncache call
        '''
        _num = str(self.uncNumField.toPlainText())
        
        #Creation of the uncache call with its parameter
        paramsUncache = {"number":_num}
        myUncache = self.myMercury.uncache(paramsUncache)
        
        #Displaying the call's parameters
        self.uncRepCode.setText("Response Code: "+myUncache.getResponseCode())
        self.uncRepStatus.setText("Response Status: "+myUncache.getResponseStatus())
        self.uncMess.setText("Message: "+myUncache.getMessage())
        self.uncNum.setText("Number: "+myUncache.getNumber())
        
    def retranslateUi(self, TabWidget):
        TabWidget.setWindowTitle(QtGui.QApplication.translate("TabWidget", "TabWidget", None, QtGui.QApplication.UnicodeUTF8))
        self.label.setText(QtGui.QApplication.translate("TabWidget", "Create a new Mercury Server", None, QtGui.QApplication.UnicodeUTF8))
        self.label_2.setText(QtGui.QApplication.translate("TabWidget", "Send a Ping call to the Mogreet API", None, QtGui.QApplication.UnicodeUTF8))
        self.label_3.setText(QtGui.QApplication.translate("TabWidget", "Client ID:", None, QtGui.QApplication.UnicodeUTF8))
        self.label_4.setText(QtGui.QApplication.translate("TabWidget", "Token: ", None, QtGui.QApplication.UnicodeUTF8))
        self.pingButton.setText(QtGui.QApplication.translate("TabWidget", "Ping", None, QtGui.QApplication.UnicodeUTF8))
        self.label_5.setText(QtGui.QApplication.translate("TabWidget", "Response to Ping call:", None, QtGui.QApplication.UnicodeUTF8))
        self.pingRepCode.setText(QtGui.QApplication.translate("TabWidget", "Response Code: ", None, QtGui.QApplication.UnicodeUTF8))
        self.pingRepStatus.setText(QtGui.QApplication.translate("TabWidget", "Response Status: ", None, QtGui.QApplication.UnicodeUTF8))
        self.pingMess.setText(QtGui.QApplication.translate("TabWidget", "Message: ", None, QtGui.QApplication.UnicodeUTF8))
        TabWidget.setTabText(TabWidget.indexOf(self.pingTab), QtGui.QApplication.translate("TabWidget", "Ping", None, QtGui.QApplication.UnicodeUTF8))
        self.label_6.setText(QtGui.QApplication.translate("TabWidget", "Send a Ping call to the Mogreet API", None, QtGui.QApplication.UnicodeUTF8))
        self.lookmessidField.setHtml(QtGui.QApplication.translate("TabWidget", "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n"
"<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n"
"p, li { white-space: pre-wrap; }\n"
"</style></head><body style=\" font-family:\'Ubuntu\'; font-size:11pt; font-weight:400; font-style:normal;\">\n"
"<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"></p></body></html>", None, QtGui.QApplication.UnicodeUTF8))
        self.label_7.setText(QtGui.QApplication.translate("TabWidget", "Message ID:", None, QtGui.QApplication.UnicodeUTF8))
        self.label_8.setText(QtGui.QApplication.translate("TabWidget", "Hash: ", None, QtGui.QApplication.UnicodeUTF8))
        self.lookButton.setText(QtGui.QApplication.translate("TabWidget", "Lookup", None, QtGui.QApplication.UnicodeUTF8))
        self.label_9.setText(QtGui.QApplication.translate("TabWidget", "Response to Lookup call: ", None, QtGui.QApplication.UnicodeUTF8))
        self.lookRepCode.setText(QtGui.QApplication.translate("TabWidget", "Response Code: ", None, QtGui.QApplication.UnicodeUTF8))
        self.lookRepStatus.setText(QtGui.QApplication.translate("TabWidget", "Response Status: ", None, QtGui.QApplication.UnicodeUTF8))
        self.lookMess.setText(QtGui.QApplication.translate("TabWidget", "Message: ", None, QtGui.QApplication.UnicodeUTF8))
        self.lookCampid.setText(QtGui.QApplication.translate("TabWidget", "Campaign ID: ", None, QtGui.QApplication.UnicodeUTF8))
        self.lookFromNum.setText(QtGui.QApplication.translate("TabWidget", "From Number:", None, QtGui.QApplication.UnicodeUTF8))
        self.lookFromName.setText(QtGui.QApplication.translate("TabWidget", "From Name: ", None, QtGui.QApplication.UnicodeUTF8))
        self.lookToNum.setText(QtGui.QApplication.translate("TabWidget", "To Number: ", None, QtGui.QApplication.UnicodeUTF8))
        self.lookToName.setText(QtGui.QApplication.translate("TabWidget", "To Name: ", None, QtGui.QApplication.UnicodeUTF8))
        self.lookContentid.setText(QtGui.QApplication.translate("TabWidget", "Content ID: ", None, QtGui.QApplication.UnicodeUTF8))
        self.lookStatus.setText(QtGui.QApplication.translate("TabWidget", "Status: ", None, QtGui.QApplication.UnicodeUTF8))
        self.lookEvts.setText(QtGui.QApplication.translate("TabWidget", "History - Events: ", None, QtGui.QApplication.UnicodeUTF8))
        TabWidget.setTabText(TabWidget.indexOf(self.lookupTab), QtGui.QApplication.translate("TabWidget", "Lookup", None, QtGui.QApplication.UnicodeUTF8))
        self.label_11.setText(QtGui.QApplication.translate("TabWidget", "Send a Send call to the Mogreet API", None, QtGui.QApplication.UnicodeUTF8))
        self.label_10.setText(QtGui.QApplication.translate("TabWidget", "Campaign ID: ", None, QtGui.QApplication.UnicodeUTF8))
        self.label_12.setText(QtGui.QApplication.translate("TabWidget", "From Number: ", None, QtGui.QApplication.UnicodeUTF8))
        self.label_13.setText(QtGui.QApplication.translate("TabWidget", "To Number: ", None, QtGui.QApplication.UnicodeUTF8))
        self.label_14.setText(QtGui.QApplication.translate("TabWidget", "Message: ", None, QtGui.QApplication.UnicodeUTF8))
        self.label_15.setText(QtGui.QApplication.translate("TabWidget", "Content ID: ", None, QtGui.QApplication.UnicodeUTF8))
        self.sendButton.setText(QtGui.QApplication.translate("TabWidget", "Send", None, QtGui.QApplication.UnicodeUTF8))
        self.label_16.setText(QtGui.QApplication.translate("TabWidget", "Response to Send call: ", None, QtGui.QApplication.UnicodeUTF8))
        self.sendRepCode.setText(QtGui.QApplication.translate("TabWidget", "Response Code: ", None, QtGui.QApplication.UnicodeUTF8))
        self.sendRepStatus.setText(QtGui.QApplication.translate("TabWidget", "Response Status: ", None, QtGui.QApplication.UnicodeUTF8))
        self.sendMess.setText(QtGui.QApplication.translate("TabWidget", "Message: ", None, QtGui.QApplication.UnicodeUTF8))
        self.sendMessid.setText(QtGui.QApplication.translate("TabWidget", "Message ID: ", None, QtGui.QApplication.UnicodeUTF8))
        self.sendHash.setText(QtGui.QApplication.translate("TabWidget", "Hash: ", None, QtGui.QApplication.UnicodeUTF8))
        TabWidget.setTabText(TabWidget.indexOf(self.sendTab), QtGui.QApplication.translate("TabWidget", "Send", None, QtGui.QApplication.UnicodeUTF8))
        self.label_17.setText(QtGui.QApplication.translate("TabWidget", "Send a GETOPT call to the Mogreet API", None, QtGui.QApplication.UnicodeUTF8))
        self.label_18.setText(QtGui.QApplication.translate("TabWidget", "Your Number: ", None, QtGui.QApplication.UnicodeUTF8))
        self.label_19.setText(QtGui.QApplication.translate("TabWidget", "Campaign ID: ", None, QtGui.QApplication.UnicodeUTF8))
        self.getButton.setText(QtGui.QApplication.translate("TabWidget", "Getopt", None, QtGui.QApplication.UnicodeUTF8))
        self.label_20.setText(QtGui.QApplication.translate("TabWidget", "Response to Getopt call: ", None, QtGui.QApplication.UnicodeUTF8))
        self.getRepCode.setText(QtGui.QApplication.translate("TabWidget", "Response Code: ", None, QtGui.QApplication.UnicodeUTF8))
        self.getRepStatus.setText(QtGui.QApplication.translate("TabWidget", "Response Status: ", None, QtGui.QApplication.UnicodeUTF8))
        self.getMess.setText(QtGui.QApplication.translate("TabWidget", "Message: ", None, QtGui.QApplication.UnicodeUTF8))
        self.getCampStatusCode.setText(QtGui.QApplication.translate("TabWidget", "Campaign Status Code: ", None, QtGui.QApplication.UnicodeUTF8))
        self.getCampStat.setText(QtGui.QApplication.translate("TabWidget", "Campaign Status: ", None, QtGui.QApplication.UnicodeUTF8))
        TabWidget.setTabText(TabWidget.indexOf(self.getoptTab), QtGui.QApplication.translate("TabWidget", "Getopt", None, QtGui.QApplication.UnicodeUTF8))
        self.label_21.setText(QtGui.QApplication.translate("TabWidget", "Send a INFO call to the Mogreet API", None, QtGui.QApplication.UnicodeUTF8))
        self.label_22.setText(QtGui.QApplication.translate("TabWidget", "Your Number: ", None, QtGui.QApplication.UnicodeUTF8))
        self.infoButton.setText(QtGui.QApplication.translate("TabWidget", "Info", None, QtGui.QApplication.UnicodeUTF8))
        self.label_23.setText(QtGui.QApplication.translate("TabWidget", "Response to Info call: ", None, QtGui.QApplication.UnicodeUTF8))
        self.infoRepCode.setText(QtGui.QApplication.translate("TabWidget", "Response Code: ", None, QtGui.QApplication.UnicodeUTF8))
        self.infoRepStatus.setText(QtGui.QApplication.translate("TabWidget", "Response Status: ", None, QtGui.QApplication.UnicodeUTF8))
        self.infoMess.setText(QtGui.QApplication.translate("TabWidget", "Message: ", None, QtGui.QApplication.UnicodeUTF8))
        self.infoNum.setText(QtGui.QApplication.translate("TabWidget", "Number: ", None, QtGui.QApplication.UnicodeUTF8))
        self.infoCarrier.setText(QtGui.QApplication.translate("TabWidget", "Carrier: ", None, QtGui.QApplication.UnicodeUTF8))
        self.infoCarrid.setText(QtGui.QApplication.translate("TabWidget", "Carrier ID: ", None, QtGui.QApplication.UnicodeUTF8))
        self.infoHand.setText(QtGui.QApplication.translate("TabWidget", "Handset: ", None, QtGui.QApplication.UnicodeUTF8))
        self.infoHandid.setText(QtGui.QApplication.translate("TabWidget", "Handset ID: ", None, QtGui.QApplication.UnicodeUTF8))
        TabWidget.setTabText(TabWidget.indexOf(self.infoTab), QtGui.QApplication.translate("TabWidget", "Info", None, QtGui.QApplication.UnicodeUTF8))
        self.label_24.setText(QtGui.QApplication.translate("TabWidget", "Send a SETOPT call to the Mogreet API", None, QtGui.QApplication.UnicodeUTF8))
        self.label_25.setText(QtGui.QApplication.translate("TabWidget", "Your Number: ", None, QtGui.QApplication.UnicodeUTF8))
        self.label_26.setText(QtGui.QApplication.translate("TabWidget", "Campaign ID: ", None, QtGui.QApplication.UnicodeUTF8))
        self.label_27.setText(QtGui.QApplication.translate("TabWidget", "Campaign Status Code: ", None, QtGui.QApplication.UnicodeUTF8))
        self.label_28.setText(QtGui.QApplication.translate("TabWidget", "Response to Setopt call: ", None, QtGui.QApplication.UnicodeUTF8))
        self.setButton.setText(QtGui.QApplication.translate("TabWidget", "Setopt", None, QtGui.QApplication.UnicodeUTF8))
        self.setRepCode.setText(QtGui.QApplication.translate("TabWidget", "Response Code: ", None, QtGui.QApplication.UnicodeUTF8))
        self.setRepStatus.setText(QtGui.QApplication.translate("TabWidget", "Response Status: ", None, QtGui.QApplication.UnicodeUTF8))
        self.setMess.setText(QtGui.QApplication.translate("TabWidget", "Message: ", None, QtGui.QApplication.UnicodeUTF8))
        TabWidget.setTabText(TabWidget.indexOf(self.setoptTab), QtGui.QApplication.translate("TabWidget", "Setopt", None, QtGui.QApplication.UnicodeUTF8))
        self.label_29.setText(QtGui.QApplication.translate("TabWidget", "Send a TRANSACTIONS call to the Mogreet API", None, QtGui.QApplication.UnicodeUTF8))
        self.label_30.setText(QtGui.QApplication.translate("TabWidget", "Your number:", None, QtGui.QApplication.UnicodeUTF8))
        self.tranButton.setText(QtGui.QApplication.translate("TabWidget", "Transactions", None, QtGui.QApplication.UnicodeUTF8))
        self.label_32.setText(QtGui.QApplication.translate("TabWidget", "Response to Transactions call: ", None, QtGui.QApplication.UnicodeUTF8))
        self.tranRepCode.setText(QtGui.QApplication.translate("TabWidget", "Response Code: ", None, QtGui.QApplication.UnicodeUTF8))
        self.tranRepStatus.setText(QtGui.QApplication.translate("TabWidget", "Response Status: ", None, QtGui.QApplication.UnicodeUTF8))
        self.tranMess.setText(QtGui.QApplication.translate("TabWidget", "Message: ", None, QtGui.QApplication.UnicodeUTF8))
        self.tranCampid.setText(QtGui.QApplication.translate("TabWidget", "All Campaign IDs: ", None, QtGui.QApplication.UnicodeUTF8))
        self.tranMessid.setText(QtGui.QApplication.translate("TabWidget", "All Message IDs: ", None, QtGui.QApplication.UnicodeUTF8))
        TabWidget.setTabText(TabWidget.indexOf(self.transTab), QtGui.QApplication.translate("TabWidget", "Transactions", None, QtGui.QApplication.UnicodeUTF8))
        self.label_33.setText(QtGui.QApplication.translate("TabWidget", "Send a UNCACHE call to the Mogreet API", None, QtGui.QApplication.UnicodeUTF8))
        self.label_34.setText(QtGui.QApplication.translate("TabWidget", "Your Number: ", None, QtGui.QApplication.UnicodeUTF8))
        self.uncButton.setText(QtGui.QApplication.translate("TabWidget", "Uncache", None, QtGui.QApplication.UnicodeUTF8))
        self.label_35.setText(QtGui.QApplication.translate("TabWidget", "Response to Uncache call: ", None, QtGui.QApplication.UnicodeUTF8))
        self.uncRepCode.setText(QtGui.QApplication.translate("TabWidget", "Response Code: ", None, QtGui.QApplication.UnicodeUTF8))
        self.uncRepStatus.setText(QtGui.QApplication.translate("TabWidget", "Response Status: ", None, QtGui.QApplication.UnicodeUTF8))
        self.uncMess.setText(QtGui.QApplication.translate("TabWidget", "Message: ", None, QtGui.QApplication.UnicodeUTF8))
        self.uncNum.setText(QtGui.QApplication.translate("TabWidget", "Number: ", None, QtGui.QApplication.UnicodeUTF8))
        TabWidget.setTabText(TabWidget.indexOf(self.uncacheTab), QtGui.QApplication.translate("TabWidget", "Uncache", None, QtGui.QApplication.UnicodeUTF8))

