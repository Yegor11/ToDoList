#include "model.h"

Model::Model(QObject *parent) : QAbstractListModel(parent)
{

    info.reserve(100);
    occupied_id.reserve(100);

    std::string unique_id = id_maker();
    std::pair< std::array<std::string,data_amount>,bool> product({"Yegor","11.11.2002","Software Engeneer",unique_id},false);
    info.emplace_back(product);

   unique_id = id_maker();
   std::pair< std::array<std::string,data_amount>,bool> product1({"Kolya","12.32.1031","Designer",unique_id},true);
   info.emplace_back(product1);

   unique_id= id_maker();
   std::pair< std::array<std::string,data_amount>,bool> product2({"Marta","07.04.2220","QA",unique_id},false);
   info.emplace_back(product2);

   unique_id = id_maker();
   std::pair< std::array<std::string,data_amount>,bool> product3({"Jone","24.08.1991","Developer",unique_id},true);
   info.emplace_back(product3);

}

void Model::add(QString name, QString data, QString description)
{
   beginInsertRows( QModelIndex(), info.size(),info.size());
   std::string unique_id = id_maker();
   std::pair< std::array<std::string,data_amount>,bool> product({name.toUtf8().constData(),data.toUtf8().constData(),
                                                                 description.toUtf8().constData(),unique_id},false);
   info.emplace_back(product);
   endInsertRows();
}

void Model::edit_data(QString id, QString name, QString data,QString description )
{
    int index{0};
    for (int var = 0; var < info.size(); ++var) {
        if(id.toUtf8().constData() == info[var].first[3])
        {
            index = var;
        }
    }

     layoutAboutToBeChanged();

     info[index].first[0] = name.toUtf8().constData();
     info[index].first[1] = data.toUtf8().constData();
     info[index].first[2] = description.toUtf8().constData();

     layoutChanged();
}

bool Model::setData(const QModelIndex &index, const QVariant &value, int role)
{

        if (role == NameRole)
        {
           info[index.row()].first[0] = value.toString().toUtf8().constData();
        }
        if (role == DataRole)
        {
           info[index.row()].first[1] = value.toString().toUtf8().constData();
        }
        if (role == DescriptionRole)
        {
           info[index.row()].first[2] = value.toString().toUtf8().constData();
        }
        if (role == Progress)
        {
           info[index.row()].second = value.toBool();
        }

        emit dataChanged(index, index, { role } );

        return true;


        return false;
}

std::string Model::id_maker()
{
    const int len{5};
    static const char alphanum[] =
                                    "0123456789"
                                    "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                    "abcdefghijklmnopqrstuvwxyz";
    std::string tmp_s;
    tmp_s.reserve(len);


    bool status = false;
    bool isunique = true;

    while( status != true)
    {
        for (int i = 0; i < len; ++i) {
            tmp_s += alphanum[rand() % (sizeof(alphanum) - 1)];
        }
        for (int var = 0; var < occupied_id.size(); ++var) {
            if(tmp_s == occupied_id[var])
            {
             isunique = false;
            }
        }

        if(isunique)
        {
            status  = true;
        }
        else{
            tmp_s.clear();
        }
    }

    occupied_id.emplace_back(tmp_s);

    return tmp_s;
}

int Model::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid() )
        return 0;
    return info.size();
}

QVariant Model::data(const QModelIndex &index, int role) const
{

    if (!index.isValid() )
        return QVariant();
    switch (role) {
    case NameRole:
        return QVariant(QString::fromStdString(info[index.row()].first[0]));
    case DataRole:
        return QVariant(QString::fromStdString(info[index.row()].first[1]));
    case DescriptionRole:
        return QVariant(QString::fromStdString(info[index.row()].first[2]));
    case Custom_id:
        return QVariant(QString::fromStdString(info[index.row()].first[3]));
    case Progress:
        return QVariant(info[index.row()].second);
    }

    return QVariant();
}

QHash<int, QByteArray> Model::roleNames() const
{
    QHash<int, QByteArray> names;
    names[DescriptionRole] = "description";
    names[NameRole] = "name";
    names[DataRole] = "data";
    names[Progress] = "states";
    names[Custom_id] = "idishnik";

    return names;
}
