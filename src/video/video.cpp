#include "video.h"

ImageProvider::ImageProvider()
    : QQuickImageProvider(QQuickImageProvider::Image), _socket(),
      _faceDetector(
          cv::FaceDetectorYN::create("yunet.onnx", "", cv::Size(640, 480))) {
  _socket.bind(QHostAddress::Any, 9999);
  connect(&_socket, &QUdpSocket::readyRead, this,
          &ImageProvider::processDatagrams);
}

ImageProvider::~ImageProvider() {
  std::cout << "Quiting video stream..." << std::endl;
  _socket.close();
}

void ImageProvider::processDatagrams() {
  // delete previous image
  _image.reset();
  // get only last datagram
  std::vector<char> datagram;
  while (_socket.hasPendingDatagrams()) {
    datagram.resize(_socket.pendingDatagramSize());
    _socket.readDatagram(datagram.data(), datagram.size());
  }
  auto frame = cv::imdecode(datagram, cv::IMREAD_COLOR);
  _image = std::make_unique<QImage>(
      QImage(frame.data, frame.cols, frame.rows, QImage::Format_RGB888));
  emit imageChanged(*_image);
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
