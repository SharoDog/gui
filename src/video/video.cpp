#include "video.h"

ImageProvider::ImageProvider()
    : QQuickImageProvider(QQuickImageProvider::Image), _socket(),
      _picturesPaths(
          QStandardPaths::standardLocations(QStandardPaths::PicturesLocation) +
          QStandardPaths::standardLocations(QStandardPaths::DocumentsLocation) +
          QStandardPaths::standardLocations(QStandardPaths::HomeLocation)),
      _videosPaths(
          QStandardPaths::standardLocations(QStandardPaths::MoviesLocation) +
          QStandardPaths::standardLocations(QStandardPaths::DocumentsLocation) +
          QStandardPaths::standardLocations(QStandardPaths::HomeLocation)) {
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
  if (_videoWriter) {
    cv::Mat videoFrame;
    cv::cvtColor(frame, videoFrame, cv::COLOR_BGR2RGB);
    auto n = round(std::chrono::duration<double>(
                       std::chrono::high_resolution_clock::now() - _videoStart)
                       .count() *
                   FPS);
    for (; _writtenFrames < n; ++_writtenFrames) {
      _videoWriter->write(videoFrame);
    }
  }
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

void ImageProvider::takePicture() {
  if (_image) {
    for (QString path : _picturesPaths) {
      QDir directory(path);
      // create directory if not exists
      if (!directory.exists()) {
        directory.mkpath(".");
      }
      if (!directory.cd("Sharo")) {
        directory.mkdir("Sharo");
        if (!directory.cd("Sharo")) {
          continue;
        }
      }
      // number files
      int idx = 1;
      while (directory.exists(QString("photo%1.jpg").arg(idx))) {
        ++idx;
      }
      if (_image->save(directory.filePath(QString("photo%1.jpg").arg(idx)),
                       "JPG", 75)) {
        break;
      }
    }
  }
}

void ImageProvider::toggleRecord(bool curr) {
  if (!curr && !_videoWriter) {
    _videoWriter = std::make_unique<cv::VideoWriter>(cv::VideoWriter());
    for (QString path : _videosPaths) {
      QDir directory(path);
      // create directory if not exists
      if (!directory.exists()) {
        directory.mkpath(".");
      }
      if (!directory.cd("Sharo")) {
        directory.mkdir("Sharo");
        if (!directory.cd("Sharo")) {
          continue;
        }
      }
      // number files
      int idx = 1;
      while (directory.exists(QString("recording%1.mp4").arg(idx))) {
        ++idx;
      }
      if (_videoWriter->open(
              directory.filePath(QString("recording%1.mp4").arg(idx))
                  .toStdString(),
              cv::VideoWriter::fourcc('m', 'p', '4', 'v'), FPS,
              cv::Size(640, 480))) {
        break;
      }
    }
    if (!_videoWriter->isOpened()) {
      _videoWriter.release();
    } else {
      _videoStart = std::chrono::high_resolution_clock::now();
      _writtenFrames = 0;
    }
  }
  if (curr && _videoWriter) {
    _videoWriter->release();
    _videoWriter.release();
    _writtenFrames = 0;
  }
}
