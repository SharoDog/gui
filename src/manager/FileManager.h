
#ifndef FILE_MANAGER_H
#define FILE_MANAGER_H

#include <QFile>
#include <QObject>
#include <QTextStream>

class FileManager {
public:
  FileManager();
  void saveFile(const QString &, const QString &);
  QString openFile(const QString &);
};
#endif
