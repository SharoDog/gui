#include "communication.h"
#include <iostream>

Communication::Communication() : QThread(), _io_context() {}

void Communication::setQuitFlag(bool value) { _quitFlag = value; }

void Communication::managerSlot(std::string msg) {
  try {
    std::string connStr = "connect: ";
    if (msg.starts_with(connStr)) {
      _addr = asio::ip::tcp::endpoint(
          asio::ip::address::from_string(msg.erase(0, connStr.length())), 5000);
      if (!_socket) {
        _socket = std::unique_ptr<asio::ip::tcp::socket>(
            new asio::ip::tcp::socket(_io_context));
      }
      _socket->connect(_addr);
      emit managerSignal("success");
    } else if (msg.compare("disconnect") == 0) {
      _socket->close();
      _socket.reset();
      emit managerSignal("success");
    } else {
      if (_socket) {
        _socket->send(asio::buffer(msg));
      }
    }
  } catch (...) {
    emit managerSignal("fail");
  }
}

void Communication::run() {
  while (true) {
    if (_quitFlag) {
      if (_socket) {
        _socket->close();
        _socket.reset();
      }
      return;
    }
    try {
      if (_socket) {
        try {
          std::string msg = _read(_socket);
          emit managerSignal(msg);
        } catch (...) {
        }
      }
    } catch (...) {
      if (_socket) {
        _socket->close();
        _socket.reset();
      }
      emit managerSignal("fail");
    }
  }
}

std::string
Communication::_read(std::unique_ptr<asio::ip::tcp::socket> &socket) {
  auto n = asio::read_until(*socket, asio::dynamic_buffer(_buf), "\r\n");
  auto msg = _buf.substr(0, n - 2);
  _buf.erase(0, n);
  return msg;
}
