#include "gpsmodel.h"
using namespace std;

GpsModel::GpsModel(QObject *parent) :
  QObject(parent)
{

}

void GpsModel::updateGpsData(){
    qDebug() << "Updating Gps Data...";
    string text;
    string filename = "/home/fanny/gpsdata.txt";
    ifstream file;

    file.open(filename);
    if(!file){
        cerr << "Unable to open File " << filename;
        return;
    }

    while(getline(file, text)){
        qDebug() << text.data() << text.c_str();
        char *token;
        char c_text[text.size() + 1];
        strcpy(c_text, text.c_str());
        char delimiter[] = ",";

        token = strtok(c_text, delimiter);
        int i = 0;
        while(token != nullptr){
            if(i == 1){
                qDebug() << token;
                setLatitude(stod(token));
            }
            if(i == 3){
                qDebug() << token;
                setLongitude(stod(token));
            }
            token = strtok(NULL, ",");
            i++;
        }
    }
    file.close();
}

double GpsModel::longitude() const
{
  return m_longitude;
}

void GpsModel::setLongitude(double longitude)
{
  m_longitude = longitude;
  emit latitudeChanged();
}

double GpsModel::latitude() const
{
  return m_latitude;
}

void GpsModel::setLatitude(double latitude)
{
    qDebug() << m_latitude << " vs " << latitude;
    m_latitude = latitude;
    emit longitudeChanged();
}
