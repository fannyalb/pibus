#ifndef QPOSITIONINFOSOURCEGPSD_H
#define QPOSITIONINFOSOURCEGPSD_H
#include <QObject>
#include <QtPositioning>
#include <QGeoCoordinate>
#include <QTcpSocket>


class GpsdPositionInfoSource: public QNmeaPositionInfoSource
{
    Q_OBJECT

public:
    GpsdPositionInfoSource(QObject *parent = nullptr);
    bool gpsdConnect();
    void gpsdDisconnect();
    bool gpsdStart();
    bool gpsdStop();
    QIODevice *createDevice();
public slots:
    void startUpdates();
    void stopUpdates();
    void readFromSocketAndCopy();
private:
    QTcpSocket* m_socket;
    QGeoPositionInfo lastPosition;
    QString m_hostname;
    quint16 m_port;
    bool m_gpsdStarted;
    int m_timeout;
    QIODevice* m_device;
    bool m_running;


};

#endif // QPOSITIONINFOSOURCEGPSD_H
