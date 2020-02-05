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
    MusicPlayer musicPlayer;
//    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
//	dashboard.setUIWindow(qobject_cast<QQuickWindow*>(engine.rootObjects().first()));


    QQmlEngine engine;
    engine.rootContext()->setContextProperty("musicplayer", &musicPlayer);
    QQmlComponent component(&engine, QUrl::fromLocalFile("src/main.qml"));

//    engine()->rootContext()->setContextProperty("musicplayer", &musicPlayer);
    QObject *object = component.create();
    QQuickWindow *window = qobject_cast<QQuickWindow*>(object);
    dashboard.setUIWindow(window);
	return app.exec();
}
