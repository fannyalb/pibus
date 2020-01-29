#ifndef MUSICPLAYER_H
#define MUSICPLAYER_H

#include <QObject>
#include <QString>
#include <QMediaPlayer>

class MusicPlayer : public QObject
{
	Q_OBJECT
	Q_PROPERTY(QString songName READ songName WRITE setSongName NOTIFY songNameChanged)

public:
    explicit MusicPlayer(QObject *parent = nullptr);

	QString songName();
	void setSongName(const QString &songName);
	void start();
	void stop();
  
signals:
	void songNameChanged();


private:
	QString m_songName;
	QMediaPlayer *player;

};

#endif // MUSICPLAYER_H
