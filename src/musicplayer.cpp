#include "musicplayer.h"
#include <QDebug>

MusicPlayer::MusicPlayer(QObject *parent) :
    QObject(parent)
{
    m_player = new QMediaPlayer;
    m_isStartup = true;
    qDebug() << "Player startup";
}

void MusicPlayer::start(){
    qDebug() << "Musicplayer starting ...";
    if(m_isStartup){
        qDebug() << "starting for the first time ...";
        m_player->setVolume(50);
        m_isStartup = false;
        m_isActive = true;
    }
    QString name = "toxicity.mp3";
    setSongName(name);
    qDebug()<<"Music m_player: media = " + m_player->currentMedia().canonicalUrl().toString();
}

void MusicPlayer::startPlayer(){
    qDebug()<<"Music m_player: start pressed";
    qDebug()<<"Music m_player: m_songName = " + m_songName;
    m_isActive = true;
    qDebug()<<"Music m_player: media = " + m_player->currentMedia().canonicalUrl().toString();
    m_player->play();
}

void MusicPlayer::stopPlayer(){
    qDebug()<<"Music m_player: stop pressed";
    m_player->stop();
}

void MusicPlayer::volumeUp()
{
   int newVolume = m_player->volume() + 1;
   m_player->setVolume(newVolume);
}

void MusicPlayer::volumeDown()
{
   m_lastVolume = m_player->volume();
   int newVolume = m_lastVolume - 1;
   m_player->setVolume(newVolume);
}

void MusicPlayer::volumeMute()
{
   m_player->setMuted(m_isMuted);
   m_isMuted = !m_isMuted;
}

QString MusicPlayer::songName() {
    return m_songName;
}

void MusicPlayer::setSongName(QString &songName) {
    qDebug() << "Setting song name " + songName;
    if(m_songName == songName)
        return;
    m_songName = songName;
    qDebug() << "Songname set to" + m_songName;

    m_player->setMedia(QUrl::fromLocalFile("/home/fanny/Musik/" + m_songName));
    qDebug() << "After setMedia Songname set to" + m_songName;
    emit songNameChanged();
}

void MusicPlayer::pausePlayer(){
    qDebug()<<"Music m_player: pause pressed";
    m_player->pause();
}
