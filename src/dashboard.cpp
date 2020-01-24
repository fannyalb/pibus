#include "dashboard.h"
#include <QPushButton>
#include <QList>

Dashboard::Dashboard(QWidget *parent) :
	QWidget(parent)
{
	// Set size of window
	setFixedSize(800, 480);

	// Create and position button
	QList<QPushButton*> buttonList;
	m_musicButton = new QPushButton("Music", this);
	m_radioButton = new QPushButton("Radio", this);
	m_navigationButton = new QPushButton("Navigation", this);
	buttonList << m_musicButton;
	buttonList.append(m_radioButton);
	buttonList.append(m_navigationButton);

	for(int i = 0; i < buttonList.size(); i++){
		int yValue = 20 + i * 50;
		buttonList.at(i)->setGeometry(50, yValue, 100, 40);
	}
}

