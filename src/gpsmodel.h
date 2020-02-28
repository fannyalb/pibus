#ifndef GPSMODEL_H
#define GPSMODEL_H
#include <QtCore/QObject>
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>
#include <iostream>
#include <fstream>
#include <sstream>
#include <QGeoCoordinate>
#include <string.h>
#include "gpsdclient.h"


class GpsModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double longitude READ longitude NOTIFY longitudeChanged())
    Q_PROPERTY(double latitude READ latitude NOTIFY latitudeChanged())
    Q_PROPERTY(QGeoCoordinate coordinate READ coordinate NOTIFY coordinateChanged())
public:
    explicit GpsModel(QObject *parent = nullptr);
    double longitude() const;
    double latitude() const;

    QGeoCoordinate coordinate() const;
    void setCoordinate(double lon, double lat);

public slots:
    void readGpsData();
signals:
    void positionChanged(QGeoCoordinate);
    void longitudeChanged();
    void latitudeChanged();
    void coordinateChanged();

private slots:
    void connectDevice();
    void jsonToCoordinate(const QJsonObject &json);

private:
    QGeoCoordinate m_coordinate;
    GpsdClient *m_gpsdClient;
    void setLatitude(double latitude);
    void setLongitude(double longitude);
    double m_longitude = 0.0;
    double m_latitude = 0.0;
    bool m_gpsdRunning;
    QIODevice *m_gpsDevice;
    void init();
};

#endif // GPSMODEL_H
