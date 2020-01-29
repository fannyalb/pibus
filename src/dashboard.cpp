#include "dashboard.h"

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
}

void Dashboard::musicButtonPressed(){
	qDebug() << "music pressed";
}

void Dashboard::radioButtonPressed(){
	qDebug() << "radio pressed";
}

void Dashboard::cameraButtonPressed(){
	qDebug() << "camera pressed";
}

