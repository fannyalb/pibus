#ifndef LOGFILEPOSITIONSOURCE_H
#define LOGFILEPOSITIONSOURCE_H
#include <QtCore/QObject>
#include <QDebug>
#include <QQuickWindow>
#include <QGeoPositionInfoSource>
#include <QGeoRoute>
#include <QTimer>

class LogFilePositionSource : public QGeoPositionInfoSource
{
    Q_OBJECT
public:
    LogFilePositionSource(QObject *parent = nullptr);

    QGeoPositionInfo lastKnownPosition(bool fromSatellitePositioningMethodsOnly = false) const;

    PositioningMethods supportedPositioningMethods() const;
    int minimumUpdateInterval() const;
    Error error() const;

public slots:
    virtual void startUpdates();
    virtual void stopUpdates();

    virtual void requestUpdate(int timeout = 5000);

private slots:
    void readNextPosition();

private:
    QFile *logFile;
    QTimer *timer;
    QGeoPositionInfo lastPosition;
};

#endif // LOGFILEPOSITIONSOURCE_H
