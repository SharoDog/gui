#ifndef VIDEO_H
#define VIDEO_H
#include <QDir>
#include <QStandardPaths>
#include <QUdpSocket>
#include <QtQuick/QQuickImageProvider>
#include <iostream>
#include <opencv2/imgcodecs.hpp>

class ImageProvider : public QQuickImageProvider {
  Q_OBJECT
private:
  QUdpSocket _socket;
  QStringList _picturesPaths;
  QStringList _videosPaths;
  std::unique_ptr<QImage> _image;

public:
  explicit ImageProvider();
  ~ImageProvider();
  QImage requestImage(const QString &, QSize *, const QSize &);
public slots:
  void processDatagrams();
  void takePicture();
signals:
  void imageChanged(const QImage &);
};
#endif
