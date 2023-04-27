#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlEngine>

#include <manager.h>

int main(int argc, char **argv) {
  QGuiApplication app(argc, argv);
  QQmlApplicationEngine engine;
  Manager *manager = new Manager(&app);
  engine.rootContext()->setContextProperty("manager", manager);
  const QUrl url(u"qrc:/qt/qml/views/main.qml"_qs);
  engine.load(url);
  if (engine.rootObjects().isEmpty()) {
    return -1;
  }
  return app.exec();
}
