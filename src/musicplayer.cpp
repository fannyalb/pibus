#include "musicplayer.h"
#include <QDebug>

MusicPlayer::MusicPlayer(QObject *parent) :
	QObject(parent)
{
	player = new QMediaPlayer;
	this->setSongName("toxicity.mp3");

}

QString MusicPlayer::songName()
{
	return m_songName;
}

void MusicPlayer::setSongName(const QString &songName)
{
	if(songName == m_songName)
		return;

	m_songName = songName;

	//player->setMedia(QUrl::fromLocalFile("/home/fanny/Musik/"+ m_songName));
	player->setMedia(QUrl::fromLocalFile("/home/fanny/Musik/"+ m_songName));
	//emit songNameChanged();
}


void MusicPlayer::start(){
	qDebug()<<"pressed";
	
	player->play();
}

void MusicPlayer::stop(){
	player->pause();
}
