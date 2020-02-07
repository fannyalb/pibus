#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQuickItem>
#include <QQmlContext>
#include <QQmlComponent>

#include "dashboard.h"

int main(int argc, char **argv){
	QGuiApplication app(argc, argv);


    QQmlApplicationEngine engine;
    QQmlContext* context = engine.rootContext();
    Dashboard dashboard;
    context->setContextProperty("dashboard", &dashboard);
    engine.load(QUrl::fromLocalFile("src/main.qml"));
	return app.exec();
}
