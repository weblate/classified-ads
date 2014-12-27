/*     -*-C++-*- -*-coding: utf-8-unix;-*-
    Classified Ads is Copyright (c) Antti Järvinen 2013.

    This file is part of Classified Ads.

    Classified Ads is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Classified Ads is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Classified Ads.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "controller.h"
#include <signal.h>
#include "log.h"
#include <QHostAddress> // for Q_IPV6ADDR
#include <QApplication>

QApplication* app ; /**< The qt application, we need to have 1 instance */
Controller* c ; /** Application controller, here as static for signal handlers */
/** ipv6 addr with all bits zero, to denote an invalid addr */
Q_IPV6ADDR KNullIpv6Addr ( QHostAddress("::0").toIPv6Address () ) ;
/** 
 * Hash with all bits zero, to denote an invalid or non-used hash.
 * Some lucky dudette will have this generated for her profile fingerprint  :)
 */
Hash KNullHash ;
#ifndef WIN32
/**
 * SIGINT handler is trapped into this function ;
 * this will try to semi-gracefully terminate the
 * application
 */
void sigINThandler(int) {
  LOG_STR("SIGINT trapped..") ;
  if ( app != NULL ) {
    QApplication::quit() ;
  }
}

/**
 * SIGUSR1 handler is trapped into this function ;
 * lets have that for hiding the UI
 */
void sigUSR1handler(int) {
  LOG_STR("SIGUSR1 trapped..") ;
  if ( c != NULL ) {
    c->hideUI() ;
  }
}

/**
 * SIGUSR2 handler is trapped into this function ;
 * lets have that for showing the hidden UI
 */
void sigUSR2handler(int) {
  LOG_STR("SIGUSR2 trapped..") ;
  if ( c != NULL ) {
    c->showUI() ;
  }
}
#endif

/**
 * FZ - in the night of the iron sausage
 */
int main(int argc, char *argv[]) {
  KNullHash = Hash() ; 
  app = new QApplication (argc, argv);
  // controller will actually start launching the application
  c = new Controller(*app) ;
#if QT_VERSION < 0x050000
  // without this qt4+qjson does not handle utf-8 well ; every
  // byte in multi-byte unicode-sequences appears as separate
  // character after the string is parsed back in windows environment.
  // linux does some magick tricks to not fail due to broken utf-8.
  QTextCodec *codec = QTextCodec::codecForName("UTF-8");
  QTextCodec::setCodecForCStrings(codec);
  QTextCodec::setCodecForTr(codec);
#endif
#ifndef WIN32
  signal(SIGINT,sigINThandler); // if user presses CTRL-C
  signal(SIGHUP,sigINThandler); // if user closed the terminal..
  signal(SIGUSR1,sigUSR1handler);
  signal(SIGUSR2,sigUSR2handler);
#endif
  int retval = app->exec() ;
  delete c ;
  delete app ;
  return retval ;
}


