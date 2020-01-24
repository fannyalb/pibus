#ifndef DASHBOARD_H
#define DASHBOARD_H

#include <QWidget>

class QPushButton;
class Dashboard : public QWidget
{
  public:
    explicit Dashboard(QWidget *parent = 0);
  private:
    QPushButton *m_musicButton;
    QPushButton *m_navigationButton;
    QPushButton *m_radioButton;
    QPushButton *m_cameraButton;
    QPushButton *m_settingsButton;
};

#endif // DASHBOARD_H
