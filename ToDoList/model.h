#ifndef MODEL_H
#define MODEL_H

#include <map>
#include <vector>
#include <iostream>
#include <array>
#include <utility>
#include <unistd.h>
#include <cstdlib>
#include <QAbstractListModel>

class Model : public QAbstractListModel
{
    Q_OBJECT

public:

    explicit Model(QObject *parent = nullptr);

    enum Model_Roles{
          DescriptionRole = Qt::UserRole,
          NameRole,
          DataRole,
          Progress,
          Custom_id
      };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    Q_INVOKABLE void add(QString name, QString data, QString description );
    Q_INVOKABLE void edit_data( QString id, QString name, QString data,QString description);
    bool setData(const QModelIndex &index, const QVariant &value,int role = Qt::EditRole) override;
    std::string id_maker();


    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

private:

    static const int data_amount{4};
    std::vector<std::pair<std::array<std::string,data_amount>,bool>> info;
    std::vector<std::string> occupied_id;
};

#endif // MODEL_H
