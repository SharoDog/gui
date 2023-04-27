#ifndef COMMUNICATION_H
#define COMMUNICATION_H
#include <QThread>
#include <asio.hpp>
#include <sys/socket.h>

class Communication : public QThread {
  Q_OBJECT
private:
  bool _quitFlag = false;
  std::unique_ptr<asio::ip::tcp::socket> _socket;
  asio::io_context _io_context;
  asio::ip::tcp::endpoint _addr;
  std::string _read(std::unique_ptr<asio::ip::tcp::socket> &_socket);

public:
  explicit Communication();
  virtual void run();
  void setQuitFlag(bool);
public slots:
  void managerSlot(std::string);
signals:
  void managerSignal(std::string);
};
#endif
