#include "dashboard.h"
#include "musicplayer.h"

Dashboard::Dashboard(QObject *parent) :
	QObject(parent)
{
}

void Dashboard::setUIWindow(QQuickWindow* window){
	m_window = window;
    qDebug() << "setup ui window";
	QObject::connect(m_window, SIGNAL(musicPressed()), this, SLOT(musicButtonPressed()));
	QObject::connect(m_window, SIGNAL(cameraPressed()), this, SLOT(cameraButtonPressed()));
	QObject::connect(m_window, SIGNAL(radioPressed()), this, SLOT(radioButtonPressed()));
    m_musicPlayer = nullptr;
}

void Dashboard::musicButtonPressed(){
	qDebug() << "music pressed";
    if(m_musicPlayer == nullptr){
        m_musicPlayer = new MusicPlayer(nullptr, m_window);
    }
    m_musicPlayer->start();
}

void Dashboard::radioButtonPressed(){
	qDebug() << "radio pressed";
}

void Dashboard::cameraButtonPressed(){
	qDebug() << "camera pressed";
}

