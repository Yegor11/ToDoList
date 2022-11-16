#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickView>
#include <QtQml>

#include <unistd.h>
#include "model.h"
#include "proxy_model.h"

int main(int argc, char *argv[])
{

    srand((unsigned)time(NULL) * getpid());
    QGuiApplication app(argc, argv);

    Model model;
    MyProxyModel filter;
    filter.setSourceModel( &model );

    qmlRegisterType<MyProxyModel>("ProxyRoles", 1, 0, "FilterTypes");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("Model",&model);
    engine.rootContext()->setContextProperty("Model_Done",&filter);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
