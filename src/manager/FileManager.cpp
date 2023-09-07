#include "FileManager.h"
#include <iostream>

FileManager::FileManager() {}

void FileManager::saveFile(const QString &filename, const QString &content) {
  QFile f(filename);
  if (!f.open(QFile::WriteOnly | QFile::Text)) {
    return;
  }
  QTextStream fs(&f);
  fs << content;
}

QString FileManager::openFile(const QString &filename) {
  QFile f(filename);
  if (!f.open(QFile::ReadOnly | QFile::Text)) {
    return "";
  }
  QTextStream in(&f);
  return in.readAll();
}
