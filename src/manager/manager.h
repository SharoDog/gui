#ifndef MANAGER_H
#define MANAGER_H
#include <QObject>
#include <communication.h>

class Manager : public QObject {
  Q_OBJECT
  Q_PROPERTY(bool loading READ loading WRITE setLoading NOTIFY loadingChanged)
  Q_PROPERTY(
      bool connected READ connected WRITE connected NOTIFY connectedChanged)
  Q_PROPERTY(
      QString command READ command WRITE setCommand NOTIFY commandChanged)
  Q_PROPERTY(
      bool gpsSignal READ gpsSignal WRITE gpsSignal NOTIFY gpsSignalChanged)
  Q_PROPERTY(
      double steering READ steering WRITE steering NOTIFY steeringChanged)
  Q_PROPERTY(double speed READ speed WRITE speed NOTIFY speedChanged)
  Q_PROPERTY(double heading READ heading WRITE heading NOTIFY headingChanged)
  Q_PROPERTY(double pitch READ pitch WRITE pitch NOTIFY pitchChanged)
  Q_PROPERTY(double roll READ roll WRITE roll NOTIFY rollChanged)
  Q_PROPERTY(double lat READ lat WRITE lat NOTIFY latChanged)
  Q_PROPERTY(double lon READ lon WRITE lon NOTIFY lonChanged)
  Q_PROPERTY(double alt READ alt WRITE alt NOTIFY altChanged)
private:
  Communication _communication;
  bool _loading;
  bool _connected;
  std::string _command;
  bool _gpsSignal;
  double _steering;
  double _speed;
  double _heading;
  double _pitch;
  double _roll;
  double _lat;
  double _lon;
  double _alt;

public:
  explicit Manager(QObject *parent = nullptr);
  ~Manager();
  bool loading() const;
  void setLoading(bool);
  bool connected() const;
  void connected(bool);
  QString command() const;
  void setCommand(const QString &);
  bool gpsSignal() const;
  void gpsSignal(bool);
  double steering() const;
  void steering(double);
  double speed() const;
  void speed(double);
  double heading() const;
  void heading(double);
  double pitch() const;
  void pitch(double);
  double roll() const;
  void roll(double);
  double lat() const;
  void lat(double);
  double lon() const;
  void lon(double);
  double alt() const;
  void alt(double);
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
