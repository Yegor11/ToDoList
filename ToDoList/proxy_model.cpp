#include "proxy_model.h"
#include "model.h"

#include <QDebug>

MyProxyModel::MyProxyModel( ): QSortFilterProxyModel(),  m_currentFilter( MyProxyModel::MyProxyModel_Filters::All ){}

bool MyProxyModel::filterAcceptsRow( int source_row, const QModelIndex& source_parent ) const
{

    const QModelIndex index = sourceModel()->index(source_row, 0, source_parent) ;

    if ( m_currentFilter == MyProxyModel::MyProxyModel_Filters::InProgress )
    {
        const bool done = index.data(Model::Model_Roles::Progress).toBool();
        return (done == false);
    }

    if ( m_currentFilter == MyProxyModel::MyProxyModel_Filters::Finished )
    {
        const bool done = index.data(Model::Model_Roles::Progress).toBool();
        return (done == true);
    }

    else if ( m_currentFilter == MyProxyModel::MyProxyModel_Filters::All )
    {
        return true;
    }

    return false;
}

int MyProxyModel::getFilter()
{
    return (int)m_currentFilter;
}

void MyProxyModel::setFilter( int filter )
{
    auto filterType = MyProxyModel::MyProxyModel_Filters( filter );
    m_currentFilter = filterType;
    emit filterChanged();
    this->invalidateFilter();
}

