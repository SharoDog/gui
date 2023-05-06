#ifndef VIDEO_H
#define VIDEO_H
#include <QUdpSocket>
#include <QtQuick/QQuickImageProvider>
#include <iostream>
#include <opencv2/dnn.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/objdetect.hpp>

const int lineThickness = 2;

class ImageProvider : public QQuickImageProvider {
  Q_OBJECT
private:
  QUdpSocket _socket;
  std::shared_ptr<QImage> _image;
  cv::Ptr<cv::FaceDetectorYN> _faceDetector;

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
