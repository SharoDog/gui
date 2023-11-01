#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlEngine>
#include <QtWebView/QtWebView>

#include <manager.h>
#ifndef __ANDROID__
#include <video.h>
#endif

int main(int argc, char **argv) {
  QtWebView::initialize();
  QGuiApplication app(argc, argv);
  QQmlApplicationEngine engine;
  Manager *manager = new Manager(&app);
  engine.rootContext()->setContextProperty("manager", manager);
#ifndef __ANDROID__
  ImageProvider *imageProvider = new ImageProvider();
  engine.rootContext()->setContextProperty("imageProvider", imageProvider);
  engine.addImageProvider("imageProvider", imageProvider);
#endif
  engine.addImportPath(":/sharo/imports");
  const QUrl url(u"qrc:/sharo/imports/views/main.qml"_qs);
  engine.load(url);
  if (engine.rootObjects().isEmpty()) {
    return -1;
  }
  return app.exec();
}
