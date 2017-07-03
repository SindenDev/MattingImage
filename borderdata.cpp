#include "borderdata.h"
#include <QFile>
#include <QDebug>
BorderData::BorderData(QObject *parent) : QObject(parent)
{

}

BorderData::~BorderData()
{

}

void BorderData::writeData(const QString &name, const QVariant &data)
{
    QString file_path = name;

    if(file_path.startsWith("file://"))
    {
        file_path = name.mid(7);
    }else if (file_path.startsWith("qrc:/"))
    {
        file_path = "." + name.mid(7);
    }

    QFile file(file_path);

    if(!file.open(QIODevice::WriteOnly))
    {
        qDebug() << "File error " << file_path ;
        return ;
    }

    file.write(data.toByteArray());
    file.close();
}

QString BorderData::readData(const QString &name) const
{
    QString file_path = name;

    if(file_path.startsWith("file://"))
    {
        file_path = name.mid(7);
    }
    else if (file_path.startsWith("qrc:/"))
    {
        file_path = "." + name.mid(7);
    }


    QFile file(file_path);

    if(!file.open(QIODevice::ReadOnly))
    {
        return QString("[{\"type\":0,\"color\": \"antiquewhite\", \"points\":[]}]");
    }
    QByteArray data = file.readAll();
    file.close();

    return QString(data);
}
