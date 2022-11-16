#ifndef PROXY_DONE_H
#define PROXY_DONE_H

#include <QSortFilterProxyModel>

#include<model.h>

class Model;

class MyProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT
    Q_ENUMS( MyProxyModel_Filters )
    Q_PROPERTY( int filter READ getFilter WRITE setFilter NOTIFY filterChanged)

public:

    enum MyProxyModel_Filters
    {
        Finished = 0,
        InProgress,
        All
    };

    explicit MyProxyModel();

    int getFilter();

public slots:

     void setFilter( int filter );

signals:

    void filterChanged();

protected:

    bool filterAcceptsRow( int source_row, const QModelIndex& source_parent ) const;

private:

     MyProxyModel_Filters m_currentFilter;

};

#endif // PROXY_DONE_H
