#ifndef VIDEO_H
#define VIDEO_H
#include <QUdpSocket>
#include <QtQuick/QQuickImageProvider>
#include <iostream>

class ImageProvider : public QQuickImageProvider {
  Q_OBJECT
private:
  QUdpSocket _socket;
  std::shared_ptr<QImage> _image;

public:
  explicit ImageProvider();
  ~ImageProvider();
  QImage requestImage(const QString &, QSize *, const QSize &);
public slots:
  void updateImage(std::shared_ptr<QImage>);
  void processDatagrams();
signals:
  void imageChanged(std::shared_ptr<QImage>);
};
#endif
