#include "gpsdclient.h"

#include <QtNetwork>

GpsdClient::GpsdClient(QObject *parent) : QObject(parent)
{
    m_port = 12345;
    m_hostname = "192.168.8.165";
    m_tcpSocket = new QTcpSocket(this);
    gpsdConnect();
}

void GpsdClient::gpsdConnect(){
    connect(m_tcpSocket, SIGNAL(readyRead()), this, SLOT(onReadyRead()));
    connect(m_tcpSocket, SIGNAL(connected()), this, SLOT(onConnected()));
    connect(m_tcpSocket, SIGNAL(disconnected()), this, SLOT(onDisconnected()));
    connect(m_tcpSocket, SIGNAL(bytesWritten(qint64)), this, SLOT(onBytesWritten(qint64)));
    m_readyToRead = false;

    m_tcpSocket->connectToHost(m_hostname, m_port);
    if(!m_tcpSocket->waitForConnected(5000)){
        qWarning() << "Error: " << m_tcpSocket->errorString();
    }

}

void GpsdClient::gpsdStart(){
    qDebug() << "Starting gpsd";
    if(!m_tcpSocket->isOpen())
        qWarning() << "Socket not open!!";
    if(!m_gpsdStarted){
        qInfo() << "Starting gpsd";
        const char *cmd = "?WATCH={\"enable\":true,\"json\":true}";
        m_tcpSocket->write(cmd);
        m_gpsdStarted = true;
    }
}

void GpsdClient::onConnected(){
    qDebug() << "connected ...";
    gpsdStart();
}

void GpsdClient::readFromSocket(){
    qDebug() << "reading from socket...";
    bool gotNewData = false;
    QByteArray buffer;

    while(m_tcpSocket->canReadLine()){
        qDebug() << "socket readable...";
        m_device->seek(0); 		// Go to Position 0 of Buffer
        gotNewData = true;
        buffer = m_tcpSocket->readLine();
        m_device->write(buffer);
        m_device->seek(0); 		// Go to Position 0 of Buffer
    }

}

void GpsdClient::onReadyRead() {
    qDebug() << "readyToRead ...";
    emit readyRead();
    readFromSocket();
    m_readyToRead = true;
}

void GpsdClient::onDisconnected() {
    qDebug() << "disconnected ...";
}

void GpsdClient::onBytesWritten(qint64 bytes) {
    qDebug() << bytes << " bytes written ..";
}

bool GpsdClient::isReadyToRead() const
{
    return m_readyToRead;
}

QIODevice* GpsdClient::createDevice(){
    QBuffer* device = new QBuffer();
    device->open(QIODevice::ReadWrite);
    qInfo() << "Created device";
    m_device = device;
    return device;
}
