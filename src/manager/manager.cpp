#include "manager.h"
#include <iostream>

Manager::Manager(QObject *parent) : QObject(parent), _communication() {
  connect(&_communication, &Communication::managerSignal, this,
          &Manager::commsSlot);
  connect(this, &Manager::commsSignal, &_communication,
          &Communication::managerSlot);
  _communication.start();
  _loading = false;
  _connected = false;
  _command = "lie";
  _gpsSignal = false;
  _steering = 0.0;
  _speed = 1.0;
  _heading = 0.0;
  _pitch = 0.0;
  _roll = 0.0;
  _lat = 1.0;
  _lon = 1.0;
  _alt = 1.0;
}
Manager::~Manager() {
  _communication.setQuitFlag(true);
  _communication.wait();
}

void Manager::commsSlot(std::string msg) {
  std::string commStr = "command: ";
  if (msg == "success") {
    connected(!connected());
    setLoading(false);
  } else if (msg == "fail") {
    setLoading(false);
  } else if (msg.starts_with(commStr)) {
    setCommand(QString::fromStdString(msg.erase(0, commStr.length())));
  }
}

void Manager::establishConnection(const QString &ip) {
  if (_connected) {
    emit commsSignal("disconnect");
  } else {
    emit commsSignal("connect: " + ip.toStdString());
  }
}
void Manager::toggleSensors(bool on) {}
void Manager::sendCommand(const QString &command) {
  commsSignal(command.toStdString());
}
void Manager::updateSpeed(double value) {
  commsSignal("speed: " + std::to_string(value));
}
void Manager::updateSteering(double value) {
  commsSignal("steering: " + std::to_string(value));
}

bool Manager::loading() const { return _loading; }
bool Manager::connected() const { return _connected; }
QString Manager::command() const { return QString::fromStdString(_command); }
bool Manager::gpsSignal() const { return _gpsSignal; }
double Manager::steering() const { return _steering; }
double Manager::speed() const { return _speed; }
double Manager::heading() const { return _heading; }
double Manager::pitch() const { return _pitch; }
double Manager::roll() const { return _roll; }
double Manager::lat() const { return _lat; }
double Manager::lon() const { return _lon; }
double Manager::alt() const { return _alt; }

void Manager::setLoading(bool value) {
  if (_loading != value) {
    _loading = value;
    emit loadingChanged(_loading);
  }
}

void Manager::connected(bool value) {
  if (_connected != value) {
    _connected = value;
    emit connectedChanged(_connected);
  }
}
void Manager::setCommand(const QString &value) {
  std::string value_str = value.toStdString();
  if (_command != value_str) {
    _command = value_str;
    emit commandChanged(value);
  }
}
void Manager::gpsSignal(bool value) {
  if (_gpsSignal != value) {
    _gpsSignal = value;
    emit gpsSignalChanged(_gpsSignal);
  }
}
void Manager::steering(double value) {
  if (_steering != value) {
    _steering = value;
    emit steeringChanged(_steering);
  }
}
void Manager::speed(double value) {
  if (_speed != value) {
    _speed = value;
    emit speedChanged(_speed);
  }
}
void Manager::heading(double value) {
  if (_heading != value) {
    _heading = value;
    emit headingChanged(_heading);
  }
}
void Manager::pitch(double value) {
  if (_pitch != value) {
    _pitch = value;
    emit pitchChanged(_pitch);
  }
}
void Manager::roll(double value) {
  if (_roll != value) {
    _roll = value;
    emit rollChanged(_roll);
  }
}
void Manager::lat(double value) {
  if (_lat != value) {
    _lat = value;
    emit latChanged(_lat);
  }
}
void Manager::lon(double value) {
  if (_lon != value) {
    _lon = value;
    emit lonChanged(_lon);
  }
}
void Manager::alt(double value) {
  if (_alt != value) {
    _alt = value;
    emit altChanged(_alt);
  }
}
