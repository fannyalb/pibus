#include "musicplayer.h"
#include <QDebug>

MusicPlayer::MusicPlayer(QObject *parent, QQuickWindow* window) :
	QObject(parent)
{
    m_player = new QMediaPlayer;
    m_window = window;
    m_musicView = nullptr;
    qDebug() << "Player startup";
    setUIWindow();
}

void MusicPlayer::setUIWindow(){
    qDebug() << "set ui musicview ";
    m_isActive = true;
    m_isStartup = true;
    QObject::connect(m_window, SIGNAL(playPressed()), this, SLOT(startPlayer()));
    QObject::connect(m_window, SIGNAL(stopPressed()), this, SLOT(stopPlayer()));
    QObject::connect(m_window, SIGNAL(pausePressed()), this, SLOT(pausePlayer()));
    QString name = "toxicity.mp3";
    setSongName(name);
}

void MusicPlayer::start(){
    qDebug() << "Musicplayer starting ...";
    if(m_isStartup){
        qDebug() << "starting for the first time ...";
        m_player->setVolume(50);
        m_isStartup = false;
    }
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
