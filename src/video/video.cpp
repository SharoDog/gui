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
  if (_recording) {
    cv::Mat videoFrame;
    cv::cvtColor(frame, videoFrame, cv::COLOR_BGR2RGB);
    _recordedFrames.push_back(
        std::make_pair(videoFrame, std::chrono::high_resolution_clock::now()));
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
  if (!curr && !_recording) {
    _recording = true;
    _recordedFrames.clear();
  }
  if (curr && _recording) {
    _recording = false;
    auto videoWriter = cv::VideoWriter();
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
      while (directory.exists(QString("recording%1.avi").arg(idx))) {
        ++idx;
      }
      if (videoWriter.open(
              directory.filePath(QString("recording%1.avi").arg(idx))
                  .toStdString(),
              cv::VideoWriter::fourcc('M', 'J', 'P', 'G'), FPS,
              cv::Size(640, 480))) {
        break;
      }
    }
    auto start = _recordedFrames.front().second;
    auto end = _recordedFrames.back().second;
    auto length = std::chrono::duration<double>(end - start).count();
    // number of output frames
    auto n = length * FPS;
    // real frames index
    int idx = 0;
    // output frames index
    for (int i = 0; i < n; ++i) {
      auto elapsed = (i / n) * length;
      // choose next real frame
      while (
          idx < _recordedFrames.size() - 1 &&
          std::chrono::duration<double>(_recordedFrames[idx + 1].second - start)
                  .count() < elapsed) {
        ++idx;
      }
      videoWriter.write(_recordedFrames[idx].first);
    }
    videoWriter.release();
    _recordedFrames.clear();
  }
}
