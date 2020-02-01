#ifndef DASHBOARD_H
#define DASHBOARD_H

#include <QtCore/QObject>
#include <QDebug>
#include <QQuickWindow>
#include <QString>
#include <QGeoRoute>
#include "musicplayer.h"


class QPushButton;
class QQuickWindow;
class Dashboard : public QObject
{
	Q_OBJECT

public:
    explicit Dashboard(QObject *parent = nullptr);

public slots: 
	void setUIWindow(QQuickWindow* window);

private slots:
	void musicButtonPressed();
	void radioButtonPressed();
	void cameraButtonPressed();
  
signals:


private:
	QQuickWindow *m_window;
    MusicPlayer *m_musicPlayer;
};

#endif // DASHBOARD_H
