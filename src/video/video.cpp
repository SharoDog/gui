#include "video.h"
#include <opencv2/imgcodecs.hpp>

ImageProvider::ImageProvider()
    : QQuickImageProvider(QQuickImageProvider::Image), _socket() {
  _socket.bind(QHostAddress::Any, 9999);
  connect(&_socket, &QUdpSocket::readyRead, this,
          &ImageProvider::processDatagrams);
}

ImageProvider::~ImageProvider() {
  std::cout << "Quiting video stream..." << std::endl;
  _socket.close();
}

void ImageProvider::processDatagrams() {
  // get only last datagram
  std::vector<char> datagram;
  while (_socket.hasPendingDatagrams()) {
    datagram.resize(_socket.pendingDatagramSize());
    _socket.readDatagram(datagram.data(), datagram.size());
  }
  auto frame = cv::imdecode(datagram, cv::IMREAD_COLOR);
  updateImage(std::make_shared<QImage>(
      QImage(frame.data, frame.cols, frame.rows, QImage::Format_RGB888)));
}

void ImageProvider::updateImage(std::shared_ptr<QImage> img) {
  emit imageChanged(img);
  _image = img;
}

QImage ImageProvider::requestImage(const QString &id, QSize *size,
                                   const QSize &requestedSize) {
  if (_image) {
    return *_image;
  } else {
    auto img =
        std::make_unique<QImage>(QImage(320, 240, QImage::Format_RGBA8888));
    img->fill(Qt::black);
    return *img;
  }
}
