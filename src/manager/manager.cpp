#include "manager.h"
#include <iostream>

Manager::Manager(QObject *parent) : QObject(parent), _communication(parent) {
  connect(&_communication, &Communication::managerSignal, this,
          &Manager::commsSlot);
  connect(this, &Manager::commsSignal, &_communication,
          &Communication::managerSlot);
  setDefault();
}
Manager::~Manager() { std::cout << "Quiting communications..." << std::endl; }
void Manager::setDefault() {
  _loading = false;
  _connected = false;
  _command = "lie";
  _gpsSignal = false;
  _attData = false;
  _steering = 0.0;
  _speed = 1.0;
  _heading = 0.0;
  _pitch = 0.0;
  _roll = 0.0;
  _lat = 1.0;
  _lon = 1.0;
  _alt = 1.0;
  emit loadingChanged(_loading);
  emit connectedChanged(_connected);
  emit commandChanged(QString::fromStdString(_command));
  emit gpsSignalChanged(_gpsSignal);
  emit attDataChanged(_attData);
  emit steeringChanged(_steering);
  emit speedChanged(_speed);
  emit headingChanged(_heading);
  emit pitchChanged(_pitch);
  emit rollChanged(_roll);
  emit latChanged(_lat);
  emit lonChanged(_lon);
  emit altChanged(_alt);
}
void Manager::commsSlot(std::string msg) {
  std::string commStr = "command: ";
  std::string steeringStr = "steering: ";
  std::string speedStr = "speed: ";
  std::string imuStr = "IMU: ";
  std::string gpsStr = "GPS: ";
  if (msg == "success") {
    setConnected(!_connected);
    if (!_connected) {
      // reset on disconnect
      setDefault();
    }
    setLoading(false);
  } else if (msg == "fail") {
    setLoading(false);
  } else if (msg.starts_with(commStr)) {
    setCommand(QString::fromStdString(msg.erase(0, commStr.length())));
  } else if (msg.starts_with(steeringStr)) {
    try {
      setSteering(std::stod(msg.erase(0, steeringStr.length())));
    } catch (...) {
    }
  } else if (msg.starts_with(speedStr)) {
    try {
      setSpeed(std::stod(msg.erase(0, speedStr.length())));
    } catch (...) {
    }
  } else if (msg.starts_with(imuStr)) {
    double oldPitch = _pitch, oldRoll = _roll, oldHeading = _heading;
    try {
      auto data = parseSensorData(msg.erase(0, imuStr.length()));
      setPitch(data[0]);
      setRoll(data[1]);
      setHeading(data[2]);
      setAttData(true);
    } catch (...) {
      setPitch(oldPitch);
      setRoll(oldRoll);
      setHeading(oldHeading);
      setAttData(false);
    }
  } else if (msg.starts_with(gpsStr)) {
    double oldLat = _lat, oldLon = _lon, oldAlt = _alt;
    try {
      auto data = parseSensorData(msg.erase(0, gpsStr.length()));
      setLat(data[0]);
      setLon(data[1]);
      setAlt(data[2]);
      setGpsSignal(true);
    } catch (...) {
      setLat(oldLat);
      setLon(oldLon);
      setAlt(oldAlt);
      setGpsSignal(false);
    }
  }
}

void Manager::establishConnection(const QString &ip) {
  if (_connected) {
    emit commsSignal("disconnect");
  } else {
    emit commsSignal("connect: " + ip.toStdString());
  }
}
void Manager::toggleSensors(bool on) {
  if (on) {
    commsSignal("sensors: True");
  } else {
    commsSignal("sensors: False");
  }
}
void Manager::sendCommand(const QString &command) {
  commsSignal(command.toStdString());
}
void Manager::updateSpeed(double value) {
  commsSignal("speed: " + std::to_string(value));
}
void Manager::updateSteering(double value) {
  commsSignal("steering: " + std::to_string(value));
}

QString Manager::openFile(const QUrl &filename) {
  return _fileManager.openFile(filename.path());
}

void Manager::saveFile(const QUrl &filename, const QString &content) {
  _fileManager.saveFile(filename.path(), content);
}

bool Manager::loading() const { return _loading; }
bool Manager::connected() const { return _connected; }
QString Manager::command() const { return QString::fromStdString(_command); }
bool Manager::gpsSignal() const { return _gpsSignal; }
bool Manager::attData() const { return _attData; }
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

void Manager::setConnected(bool value) {
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
void Manager::setGpsSignal(bool value) {
  if (_gpsSignal != value) {
    _gpsSignal = value;
    emit gpsSignalChanged(_gpsSignal);
  }
}
void Manager::setAttData(bool value) {
  if (_attData != value) {
    _attData = value;
    emit attDataChanged(_attData);
  }
}
void Manager::setSteering(double value) {
  if (_steering != value) {
    _steering = value;
    emit steeringChanged(_steering);
  }
}
void Manager::setSpeed(double value) {
  if (_speed != value) {
    _speed = value;
    emit speedChanged(_speed);
  }
}
void Manager::setHeading(double value) {
  if (_heading != value) {
    _heading = value;
    emit headingChanged(_heading);
  }
}
void Manager::setPitch(double value) {
  if (_pitch != value) {
    _pitch = value;
    emit pitchChanged(_pitch);
  }
}
void Manager::setRoll(double value) {
  if (_roll != value) {
    _roll = value;
    emit rollChanged(_roll);
  }
}
void Manager::setLat(double value) {
  if (_lat != value) {
    _lat = value;
    emit latChanged(_lat);
  }
}
void Manager::setLon(double value) {
  if (_lon != value) {
    _lon = value;
    emit lonChanged(_lon);
  }
}
void Manager::setAlt(double value) {
  if (_alt != value) {
    _alt = value;
    emit altChanged(_alt);
  }
}

std::vector<double> Manager::parseSensorData(std::string input) {
  std::vector<double> res;
  std::string curr;
  for (int i = 0; i <= input.length(); ++i) {
    if (input[i] != ';' && i != input.length()) {
      curr += input[i];
    } else {
      res.push_back(std::stod(curr));
      curr.clear();
    }
  }
  return res;
}
