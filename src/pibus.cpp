#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQuickItem>
#include <QQmlContext>
#include <QQmlComponent>

#include "dashboard.h"
#include "gpsmodel.h"

int main(int argc, char **argv){
	QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<GpsModel>("gpsmodel",1,0,"GpsModel");
    QQmlContext* context = engine.rootContext();
    Dashboard dashboard;
    context->setContextProperty("dashboard", &dashboard);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
	return app.exec();
}
