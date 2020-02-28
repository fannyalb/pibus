#ifndef GPSDCLIENT_H
#define GPSDCLIENT_H

#include <QDataStream>
#include <QTcpSocket>

QT_BEGIN_NAMESPACE
class QNetworkSession;
class QTcpSocket;
QT_END_NAMESPACE

class GpsdClient : public QObject
{
    Q_OBJECT
public:
    explicit GpsdClient(QObject* parent = nullptr);
    void readFromSocket();
    QIODevice *createDevice();
    bool isReadyToRead() const;
    void gpsdStart();
    void gpsdConnect();

signals:
    void readyRead();

private slots:
    void onReadyRead();
    void onConnected();
    void onDisconnected();
    void onBytesWritten(qint64 bytes);
private :
    QTcpSocket *m_tcpSocket = nullptr;
    QString gpsdata;
    QString m_hostname;
    int m_port;
    bool m_readyToRead;
    QIODevice *m_device;
    bool m_gpsdStarted;
};

#endif // GPSDCLIENT_H
