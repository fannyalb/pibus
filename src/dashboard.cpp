#include "dashboard.h"
#include "musicplayer.h"

Dashboard::Dashboard(QObject *parent) :
	QObject(parent)
{
    m_musicPlayer = nullptr;
}


void Dashboard::musicButtonPressed(){
	qDebug() << "music pressed";
    if(m_musicPlayer == nullptr){
        m_musicPlayer = new MusicPlayer(nullptr);
    }
    m_musicPlayer->start();
}

void Dashboard::radioButtonPressed(){
	qDebug() << "radio pressed";
}

void Dashboard::cameraButtonPressed(){
	qDebug() << "camera pressed";
}

