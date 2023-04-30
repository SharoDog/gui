#ifndef MANAGER_H
#define MANAGER_H
#include <QObject>
#include <communication.h>

class Manager : public QObject {
  Q_OBJECT
  Q_PROPERTY(bool loading READ loading WRITE setLoading NOTIFY loadingChanged)
  Q_PROPERTY(
      bool connected READ connected WRITE setConnected NOTIFY connectedChanged)
  Q_PROPERTY(
      QString command READ command WRITE setCommand NOTIFY commandChanged)
  Q_PROPERTY(
      bool gpsSignal READ gpsSignal WRITE setGpsSignal NOTIFY gpsSignalChanged)
  Q_PROPERTY(bool attData READ attData WRITE setAttData NOTIFY attDataChanged)
  Q_PROPERTY(
      double steering READ steering WRITE setSteering NOTIFY steeringChanged)
  Q_PROPERTY(double speed READ speed WRITE setSpeed NOTIFY speedChanged)
  Q_PROPERTY(double heading READ heading WRITE setHeading NOTIFY headingChanged)
  Q_PROPERTY(double pitch READ pitch WRITE setPitch NOTIFY pitchChanged)
  Q_PROPERTY(double roll READ roll WRITE setRoll NOTIFY rollChanged)
  Q_PROPERTY(double lat READ lat WRITE setLat NOTIFY latChanged)
  Q_PROPERTY(double lon READ lon WRITE setLon NOTIFY lonChanged)
  Q_PROPERTY(double alt READ alt WRITE setAlt NOTIFY altChanged)
private:
  Communication _communication;
  bool _loading;
  bool _connected;
  std::string _command;
  bool _gpsSignal;
  bool _attData;
  double _steering;
  double _speed;
  double _heading;
  double _pitch;
  double _roll;
  double _lat;
  double _lon;
  double _alt;
  std::vector<double> parseSensorData(std::string);

public:
  explicit Manager(QObject *parent = nullptr);
  ~Manager();
  void setDefault();
  bool loading() const;
  void setLoading(bool);
  bool connected() const;
  void setConnected(bool);
  QString command() const;
  void setCommand(const QString &);
  bool gpsSignal() const;
  void setGpsSignal(bool);
  bool attData() const;
  void setAttData(bool);
  double steering() const;
  void setSteering(double);
  double speed() const;
  void setSpeed(double);
  double heading() const;
  void setHeading(double);
  double pitch() const;
  void setPitch(double);
  double roll() const;
  void setRoll(double);
  double lat() const;
  void setLat(double);
  double lon() const;
  void setLon(double);
  double alt() const;
  void setAlt(double);
public slots:
  void establishConnection(const QString &);
  void toggleSensors(bool);
  void sendCommand(const QString &);
  void updateSteering(double);
  void updateSpeed(double);
  void commsSlot(std::string);
signals:
  void loadingChanged(bool);
  void connectedChanged(bool);
  void commandChanged(QString);
  void gpsSignalChanged(bool);
  void attDataChanged(bool);
  void steeringChanged(double);
  void speedChanged(double);
  void headingChanged(double);
  void pitchChanged(double);
  void rollChanged(double);
  void latChanged(double);
  void lonChanged(double);
  void altChanged(double);
  void commsSignal(std::string);
};
#endif
