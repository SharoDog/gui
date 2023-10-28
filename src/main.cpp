#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlEngine>

#include <manager.h>
#ifndef __ANDROID__
#include <video.h>
#endif

int main(int argc, char **argv) {
  QGuiApplication app(argc, argv);
  QQmlApplicationEngine engine;
  Manager *manager = new Manager(&app);
  engine.rootContext()->setContextProperty("manager", manager);
#ifndef __ANDROID__
  ImageProvider *imageProvider = new ImageProvider();
  engine.rootContext()->setContextProperty("imageProvider", imageProvider);
  engine.addImageProvider("imageProvider", imageProvider);
  const QUrl url(u"qrc:qt/qml/views/desktop.qml"_qs);
#else
  const QUrl url(u"qrc:qt/qml/views/android.qml"_qs);
#endif
  engine.load(url);
  if (engine.rootObjects().isEmpty()) {
    return -1;
  }
  return app.exec();
}
