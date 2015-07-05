#
# Classified Ads is Copyright (c) Antti Järvinen 2013.
#
# This file is part of Classified Ads.
#
# Classified Ads is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# Classified Ads is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with Classified Ads; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
#
QT     += core network sql
greaterThan(QT_MAJOR_VERSION, 4) {
    QT += widgets printsupport
} 
#CONFIG += debug
#CONFIG -= release
CONFIG(release) {
message("hardening flags for release build")
unix:QMAKE_CPPFLAGS *= $$(CA_QMAKE_CPPFLAGS)
unix:QMAKE_CFLAGS   *= $$(CA_QMAKE_CFLAGS)
unix:QMAKE_CXXFLAGS *= $$(CA_QMAKE_CXXFLAGS)
unix:QMAKE_LFLAGS   *= $$(CA_QMAKE_LDFLAGS)
} else {
message("debug build, no hardening")
# enabled -DDEBUG to have console log via qDebug()
QMAKE_CXXFLAGS += -DDEBUG
win32.CONFIG += console
}
CODECFORTR = UTF-8
CODECFORSRC = UTF-8
HEADERS = mcontroller.h controller.h FrontWidget.h net/node.h util/hash.h \
	net/connection.h datamodel/model.h \
	net/networklistener.h net/protocol_message_formatter.h \
	net/protocol_message_parser.h net/networkconnectorengine.h \
	datamodel/nodemodel.h datamodel/netrequestexecutor.h \
	datamodel/contentencryptionmodel.h ui/passwd_dialog.h \
	datamodel/profilemodel.h datamodel/profile.h \
	net/publishingengine.h datamodel/mmodelprotocolinterface.h \
        datamodel/mnodemodelprotocolinterface.h ui/profilereadersdialog.h \
	datamodel/profilesearchmodel.h datamodel/profilereaderslistingmodel.h \
	datamodel/binaryfilemodel.h datamodel/binaryfile.h \
	datamodel/binaryfilelistingmodel.h datamodel/camodel.h \
	ui/newclassifiedaddialog.h datamodel/ca.h \
	datamodel/calistingmodel.h net/retrievalengine.h datamodel/privmsg.h \
	datamodel/privmsgmodel.h ui/newprivmsgdialog.h \
	datamodel/privmsgsearchmodel.h 	datamodel/contact.h \
	datamodel/contactlistingmodel.h ui/editcontact.h \
	datamodel/datamodelbase.h datamodel/profilecomment.h \
	datamodel/profilecommentmodel.h ui/newprofilecommentdialog.h \
	datamodel/profilecommentlistingmodel.h ui/profilecommentdisplay.h \
	ui/profilecommentitemdelegate.h ui/dialogbase.h \
        ui/attachmentlistdialog.h ui/settings.h ui/status.h \
	datamodel/connectionlistingmodel.h ui/manualconnection.h \
	ui/aboutdialog.h textedit/textedit.h datamodel/searchmodel.h \
	ui/searchdisplay.h ui/insertlinkdialog.h ui/newtextdocument.h \
	datamodel/trusttreemodel.h ui/metadataQuery.h util/jsonwrapper.h
SOURCES = main.cpp controller.cpp FrontWidget.cpp net/node.cpp util/hash.cpp \
	net/connection.cpp datamodel/model.cpp \
        net/networklistener.cpp net/protocol_message_formatter.cpp \
	net/protocol_message_parser.cpp net/networkconnectorengine.cpp \
	datamodel/nodemodel.cpp datamodel/netrequestexecutor.cpp \
	datamodel/contentencryptionmodel.cpp ui/passwd_dialog.cpp \
	datamodel/profilemodel.cpp datamodel/profile.cpp \
	net/publishingengine.cpp ui/profilereadersdialog.cpp \
	datamodel/profilesearchmodel.cpp \
	datamodel/profilereaderslistingmodel.cpp \
	datamodel/binaryfilemodel.cpp datamodel/binaryfile.cpp \
	datamodel/binaryfilelistingmodel.cpp datamodel/camodel.cpp \
	ui/newclassifiedaddialog.cpp datamodel/ca.cpp \
	datamodel/calistingmodel.cpp net/retrievalengine.cpp \
	datamodel/privmsg.cpp datamodel/privmsgmodel.cpp \
        ui/newprivmsgdialog.cpp datamodel/privmsgsearchmodel.cpp \
	datamodel/contact.cpp datamodel/contactlistingmodel.cpp \
	ui/editcontact.cpp 	datamodel/datamodelbase.cpp \
	datamodel/profilecomment.cpp datamodel/profilecommentmodel.cpp \
        ui/newprofilecommentdialog.cpp 	\
	datamodel/profilecommentlistingmodel.cpp ui/profilecommentdisplay.cpp \
	ui/profilecommentitemdelegate.cpp ui/dialogbase.cpp \
        ui/attachmentlistdialog.cpp ui/settings.cpp ui/status.cpp \
	datamodel/connectionlistingmodel.cpp ui/manualconnection.cpp \
        ui/aboutdialog.cpp textedit/textedit.cpp datamodel/searchmodel.cpp \
	ui/searchdisplay.cpp ui/insertlinkdialog.cpp ui/newtextdocument.cpp \
	datamodel/trusttreemodel.cpp ui/metadataQuery.cpp util/jsonwrapper.cpp
FORMS = frontWidget.ui ui/profileReadersDialog.ui ui/passwordDialog.ui \
	ui/newClassifiedAd.ui 	ui/newPrivMsg.ui ui/editContact.ui \
        ui/newProfileComment.ui ui/profileCommentDisplay.ui \
        ui/attachmentListDialog.ui ui/settingsDialog.ui \
	ui/statusDialog.ui ui/manualConnectionDialog.ui \
	ui/aboutDialog.ui ui/searchDisplay.ui ui/insertLink.ui \
        ui/newTextDocument.ui ui/metadataQuery.ui
RESOURCES     = ui_resources.qrc
TRANSLATIONS  = classified_ads_fi.ts \
                classified_ads_sv.ts
unix:LIBS = -lssl -lcrypto -lnatpmp -lqjson -lminiupnpc -lmagic
lessThan(QT_MAJOR_VERSION, 5) {
     unix:LIBS +=  -lqjson
} 

# following line is needed for fedora linux, natpnp needs miniupnpc
unix:INCLUDEPATH += /usr/include/miniupnpc
win32:LIBS += "c:\msys\1.0\local\lib\libssl.a" 
win32:LIBS += "c:\msys\1.0\local\lib\libcrypto.a" 
win32:LIBS += "..\miniupnpc\miniupnpc-1.9\miniupnpc.lib" 
lessThan(QT_MAJOR_VERSION, 5) {
    win32:LIBS += "-L" 
    win32:LIBS += "..\qjson-master\build\src"
    win32:LIBS += "-lqjson"
}
win32:LIBS += "-lWs2_32" "-lGdi32" "-lIphlpapi"
win32:INCLUDEPATH += "C:\msys\1.0\local\include"
win32:INCLUDEPATH += "..\miniupnpc\miniupnpc-1.9"
lessThan(QT_MAJOR_VERSION, 5) {
    win32:INCLUDEPATH += "..\qjson-master\include"
}
target.path = /usr/bin
desktopfiles.path = /usr/share/applications
desktopfiles.files = ui/classified-ads.desktop
desktopicons.path = /usr/share/app-install/icons/
appdata.files = ui/classified-ads.appdata.xml
appdata.path = /usr/share/appdata/
desktopicons.files = ui/turt-transparent-128x128.png
manpages.path = /usr/share/man/man1
manpages.files = classified-ads.1
translations.path = /usr/share/classified-ads
translations.files = classified_ads_fi.qm \
                     classified_ads_sv.qm
INSTALLS += target desktopfiles desktopicons translations
unix:INSTALLS += manpages
unix:INSTALLS += appdata
RC_FILE=classified-ads.rc
