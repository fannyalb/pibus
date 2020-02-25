#ifndef GPSMODEL_H
#define GPSMODEL_H
#include <QtCore/QObject>
#include <QDebug>
#include <iostream>
#include <fstream>
#include <sstream>
#include <string.h>


class GpsModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double longitude READ longitude NOTIFY longitudeChanged())
    Q_PROPERTY(double latitude READ latitude NOTIFY latitudeChanged())
public:
    explicit GpsModel(QObject *parent = nullptr);
    double longitude() const;

    double latitude() const;

public slots:
    void updateGpsData();
signals:
    void longitudeChanged();
    void latitudeChanged();


private:
    void setLatitude(double latitude);
    void setLongitude(double longitude);
    double m_longitude = 0.0;
    double m_latitude = 0.0;
};

#endif // GPSMODEL_H
