#include "datamanager.h"
#include <QDir> //
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QStandardPaths> //

int main(int argc, char *argv[]) {
  QGuiApplication app(argc, argv);

  QQmlApplicationEngine engine;

  qmlRegisterType<JSONIC::DataManager>("ru.barsestate", 1, 0, "JsonData");

  // debug
  qWarning() << "\n************** Start Debug info: *******************\n";

  QString path =
      QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
  QDir directory(path);
  qWarning() << "List files in " << directory.path() << ":";
  QStringList files =
      // directory.entryList(QStringList() << "*.json", QDir::Files);
      directory.entryList(QStringList() << "*", QDir::Files);
  for (const auto &filename : files) {
    qDebug() << filename;
  }
  //
  qWarning() << "\n************** End Debug info: *******************\n";

  engine.rootContext()->setContextProperty("applicationDataDirPath", path);
  // qml:
  // source: "file:///" + applicationDataDirPath + "image_folder" + "image1.png"

  // end debug

  const QUrl url(u"qrc:/ImageKeeper/Main.qml"_qs);
  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreationFailed, &app,
      []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);
  engine.load(url);

  return app.exec();
}
