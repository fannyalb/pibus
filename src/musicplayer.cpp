#include "musicplayer.h"
#include <QDebug>

MusicPlayer::MusicPlayer(QObject *parent) :
	QObject(parent)
{
	player = new QMediaPlayer;
//    connect(player, SIGNAL(positionChanged(qint64)), this, SLOT(positionChanged(qint64)));
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
    qDebug()<<"Music player: start pressed";
    player->setMedia(QUrl::fromLocalFile("/home/fanny/Musik/toxicity.mp3"));
    player->setVolume(50);
    player->play();
}

void MusicPlayer::stop(){
	player->pause();
}
