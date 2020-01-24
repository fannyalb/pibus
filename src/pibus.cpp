#include <QApplication>
#include <QPushButton>
#include "dashboard.h"

int main(int argc, char **argv){
	QApplication app(argc, argv);

	Dashboard window;
	window.setFixedSize(800, 480);

	QPushButton *button = new QPushButton("Hello world!", &window);
	button->setGeometry(100, 100, 80, 30);

	window.show();
	return app.exec();
}
