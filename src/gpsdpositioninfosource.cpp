#include "gpsdpositioninfosource.h"

GpsdPositionInfoSource::GpsdPositionInfoSource(QObject *parent)
    : QNmeaPositionInfoSource(QNmeaPositionInfoSource::RealTimeMode, parent),
      m_socket(new QTcpSocket(this)),
      m_hostname("192.168.8.165"),
      m_port(12345),
      m_gpsdStarted(false),
      m_timeout(1000),
      m_running(false)
{
    connect(m_socket, SIGNAL(readyRead()), this, SLOT(readFromSocketAndCopy()));
    QByteArray hostname = qgetenv("GPSD_HOST");
    if(!hostname.isEmpty())
        m_hostname = hostname;
    QByteArray port = qgetenv("GPSD_PORT");
    if(!port.isEmpty()){
        bool ok = false;
        uint tmp = port.toUInt(&ok);
        if(ok)
            m_port = (quint16) tmp;
    }
    m_device = createDevice();
    this->setDevice(m_device);
}

QIODevice* GpsdPositionInfoSource::createDevice(){
    QBuffer* device = new QBuffer(this);
    device->open(QIODevice::ReadWrite);
    qInfo() << "Created device";
    return device;
}

void GpsdPositionInfoSource::readFromSocketAndCopy(){
    bool gotNewData = false;
    QByteArray buffer;

    while(m_socket->canReadLine()){
        gotNewData = true;
        buffer = m_socket->readLine();
        m_device->write(buffer);
    }
}

bool GpsdPositionInfoSource::gpsdConnect(){
    if(m_socket->isOpen()){
        qInfo() << "Already Connected to gpsd";
        return true;
    }

    m_socket->connectToHost(m_hostname, m_port);
    if(!m_socket->waitForConnected(m_timeout)){
        m_socket->close();
        qCritical() << "Could not open connection to gpsd";
        return false;
    }

    qInfo() << "Connected to gpsd";

}

void GpsdPositionInfoSource::gpsdDisconnect(){
   if(!m_socket->isOpen())
       return;
        qInfo() << "Disconnecting from gpsd";
    m_socket->close();
}

bool GpsdPositionInfoSource::gpsdStart(){
    if(!m_socket->isOpen())
        return false;
    if(!m_gpsdStarted){
        qInfo() << "Starting gpsd";
        m_socket->write("?WATCH={\"enable\":true,\"nmea\":true}");
        m_gpsdStarted = true;
    }
    return m_gpsdStarted;
}

bool GpsdPositionInfoSource::gpsdStop(){
    if(!m_socket->isOpen()){
        return false;
    }

    if(m_gpsdStarted){
        qInfo() << "Stopping gpsd";
        m_socket->write("?WATCH={\"enable\":false}");
        m_gpsdStarted = false;
    }
}

void GpsdPositionInfoSource::startUpdates()
{
    if(!m_running){
        gpsdStart();
        QNmeaPositionInfoSource::startUpdates();
        m_running = true;
    }
}


void GpsdPositionInfoSource::stopUpdates()
{
    if(m_running){
        QNmeaPositionInfoSource::stopUpdates();
        gpsdStop();
        m_running = false;
    }
}
