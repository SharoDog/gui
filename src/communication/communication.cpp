#include "communication.h"

Communication::Communication(QObject *parent) : QObject(parent), _socket() {
  connect(&_socket, &QTcpSocket::readyRead, this,
          &Communication::readFromSocket);
}

void Communication::managerSlot(std::string msg) {
  std::string connStr = "connect: ";
  if (msg.starts_with(connStr)) {
    _socket.connectToHost(
        QHostAddress(QString::fromStdString(msg.erase(0, connStr.length()))),
        5000);
    if (_socket.waitForConnected(300)) {
      emit managerSignal("success");
    } else {
      emit managerSignal("fail");
    }
  } else if (msg.compare("disconnect") == 0) {
    _socket.abort();
    emit managerSignal("success");
  } else {
    if (_socket.isWritable()) {
      _socket.write(msg.c_str());
    }
  }
}

void Communication::readFromSocket() {
  _readToBuf();
  _extractMsgs();
}

void Communication::_readToBuf() {
  int bytesRead = _socket.read(_tempBuf, 1024);
  // error
  if (bytesRead == -1) {
    emit managerSignal("fail");
    return;
  }
  for (int i = 0; i < bytesRead; ++i) {
    _buf[(i + _endBuf) % _bufSize] = _tempBuf[i];
  }
  _endBuf = (_endBuf + bytesRead) % _bufSize;
}

void Communication::_extractMsgs() {
  std::string msg;
  for (int i = _startBuf; i != _endBuf; i = (i + 1) % _bufSize) {
    if (_buf[(i) % _bufSize] == '\r' && _buf[(i + 1) % _bufSize] == '\n') {
      emit managerSignal(msg);
      msg.clear();
      // move start of buffer to next byte
      _startBuf = (i + 2) % _bufSize;
    }
    if (_buf[i] != '\r' && _buf[i] != '\n') {
      msg += _buf[i];
    }
  }
}
