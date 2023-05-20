#ifndef VIDEO_H
#define VIDEO_H
#include <QDir>
#include <QStandardPaths>
#include <QUdpSocket>
#include <QtQuick/QQuickImageProvider>
#include <iostream>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/videoio.hpp>

class ImageProvider : public QQuickImageProvider {
  Q_OBJECT
private:
  QUdpSocket _socket;
  QStringList _picturesPaths;
  QStringList _videosPaths;
  std::unique_ptr<QImage> _image;
  const double FPS = 30;
  std::chrono::system_clock::time_point _videoStart;
  unsigned long _writtenFrames;
  std::unique_ptr<cv::VideoWriter> _videoWriter;

public:
  explicit ImageProvider();
  ~ImageProvider();
  QImage requestImage(const QString &, QSize *, const QSize &);
public slots:
  void processDatagrams();
  void takePicture();
  void toggleRecord(bool);
signals:
  void imageChanged(const QImage &);
};
#endif
