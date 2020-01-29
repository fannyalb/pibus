#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "dashboard.h"

int main(int argc, char **argv){
	QGuiApplication app(argc, argv);


	QQmlApplicationEngine engine;
	Dashboard dashboard;
	engine.load(QUrl(QStringLiteral("qrc:main.qml")));
	dashboard.setUIWindow(qobject_cast<QQuickWindow*>(engine.rootObjects().first()));
	return app.exec();
}
