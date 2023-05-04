#ifndef COMMUNICATION_H
#define COMMUNICATION_H
#include <QTcpSocket>
#include <iostream>
#include <sys/socket.h>

class Communication : public QObject {
  Q_OBJECT
private:
  QTcpSocket _socket;
  static const int _bufSize = 1024;
  // circular buffer
  char _buf[_bufSize];
  int _startBuf = 0;
  int _endBuf = 0;
  char _tempBuf[_bufSize];
  void _readToBuf();
  void _extractMsgs();

public:
  explicit Communication(QObject *);
public slots:
  void managerSlot(std::string);
  void readFromSocket();
signals:
  void managerSignal(std::string);
};
#endif
