#include "gpsmodel.h"
using namespace std;

GpsModel::GpsModel(QObject *parent) :
    QObject(parent)
{
    m_gpsdClient = new GpsdClient(this);
    connect(m_gpsdClient, SIGNAL(readyRead()), this, SLOT(connectDevice()));
}

void GpsModel::connectDevice(){
    qDebug() << "Connect Device...";
    m_gpsDevice = m_gpsdClient->createDevice();
    connect(m_gpsDevice, SIGNAL(readyRead()), this, SLOT(readGpsData()));
}

void GpsModel::readGpsData(){
    qDebug() << "Reading gpsData";
    if(m_gpsDevice->isReadable()){
        qDebug() << "Device readable";
        QByteArray line = m_gpsDevice->readLine();
        if(line.contains("lat")){
            qDebug() << "Lat!: " << line;
            QJsonDocument jsonDoc(QJsonDocument::fromJson(line));
            jsonToCoordinate(jsonDoc.object());
        }
    }

}

void GpsModel::jsonToCoordinate(const QJsonObject &json){
    double lon, lat;
    if(json.contains("lat") && json["lat"].isDouble())
        lon = json["lat"].toDouble();
    if(json.contains("lon") && json["lon"].isDouble())
        lat = json["lon"].toDouble();
    setCoordinate(lon, lat);

}

QGeoCoordinate GpsModel::coordinate() const
{
    return m_coordinate;
}

void GpsModel::setCoordinate(double lon, double lat)
{
    QGeoCoordinate coord(lon, lat);
    m_coordinate = coord;
    emit coordinateChanged();
    emit positionChanged(m_coordinate);
}

double GpsModel::longitude() const
{
    coordinate().longitude();
}

double GpsModel::latitude() const
{
    return coordinate().latitude();
}

