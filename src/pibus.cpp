#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQuickItem>
#include <QQmlContext>
#include <QQmlComponent>

#include "dashboard.h"

int main(int argc, char **argv){
	QGuiApplication app(argc, argv);


//	QQmlApplicationEngine engine;
    Dashboard dashboard;
//    MusicPlayer musicPlayer;
//    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
//	dashboard.setUIWindow(qobject_cast<QQuickWindow*>(engine.rootObjects().first()));

//    QMediaPlayer mediaPlayer;


    QQuickView view;
//    view.rootContext()->setContextProperty("musicplayer", &mediaPlayer);
    view.rootContext()->setContextProperty("dashboard", &dashboard);
    view.setSource(QUrl::fromLocalFile("src/main.qml"));
    view.show();

//    QObject *object = component.create();
//    QQuickWindow *window = qobject_cast<QQuickWindow*>(object);
//    dashboard.setUIWindow(window);
	return app.exec();
}
