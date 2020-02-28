#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQuickItem>
#include <QQmlContext>
#include <QQmlComponent>

#include "dashboard.h"
#include "gpsmodel.h"
#include "logfilepositionsource.h"
#include "gpsdpositioninfosource.h"

int main(int argc, char **argv){
	QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<GpsModel>("gpsmodel",1,0,"GpsModel");
//    QQmlContext* context = engine.rootContext();
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    //LogFilePositionSource *logSource = new LogFilePositionSource(context);
    //GpsdPositionInfoSource *gpsdSource = new GpsdPositionInfoSource(context);

    //logSource->startUpdates();
    //gpsdSource->startUpdates();
    //qDebug() << gpsdSource->sourceName() << " error: " << gpsdSource->error();
    //qDebug() << gpsdSource->lastKnownPosition().coordinate();
//    QObject *object = engine.rootObjects().at(0)->findChild<QObject *>("gpsModelField");

    return app.exec();
}

