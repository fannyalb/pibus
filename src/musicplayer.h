#ifndef MUSICPLAYER_H
#define MUSICPLAYER_H

#include <QObject>
#include <QString>
#include <QMediaPlayer>
#include <QQuickWindow>

class MusicPlayer : public QObject
{
	Q_OBJECT
	Q_PROPERTY(QString songName READ songName WRITE setSongName NOTIFY songNameChanged)

public:
    explicit MusicPlayer(QObject *parent = nullptr);
    void start();
    QString songName();
    void setSongName(QString &songName);

public slots:
    void pausePlayer();
    void startPlayer();
    void stopPlayer();
    void volumeUp();
    void volumeDown();
    void volumeMute();

signals:
	void songNameChanged();


private:
    QString m_songName;
    QMediaPlayer* m_player;
    bool m_isActive;
    bool m_isStartup;
    int m_lastVolume = 50;
    bool m_isMuted = false;
};

#endif // MUSICPLAYER_H
