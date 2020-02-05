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
    explicit MusicPlayer(QObject *parent = nullptr, QQuickWindow* window = nullptr);
    void start();
    QString songName();
    void setSongName(QString &songName);

private slots:
    void pausePlayer();
    void startPlayer();
    void stopPlayer();

signals:
	void songNameChanged();


private:
    QString m_songName;
    QMediaPlayer* m_player;
    QQuickWindow* m_window;
    QObject* m_musicView;
    bool m_isActive;
    bool m_isStartup;

    void initPlayer();
    void setUIWindow();
};

#endif // MUSICPLAYER_H
