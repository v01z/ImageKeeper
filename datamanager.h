#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QVariantList>

namespace JSONIC {

class DataManager : public QObject {
  Q_OBJECT
  Q_PROPERTY(QVariantList data READ data WRITE setData NOTIFY dataChanged)
  Q_PROPERTY(bool result READ result WRITE setResult NOTIFY resultChanged)
  Q_PROPERTY(int length READ length WRITE setLength NOTIFY lengthChanged)

public:
  DataManager();

  // returns a list of items
  QVariantList data() const;

  // function returns final result by status value
  bool result() const;

  // function returns total item count
  int length() const;

  // checks file path.
  // path is string of current file path.
  bool fileExists(QString path);

  // function gets json file from user to convert.
  // path is string of current file path.
  Q_INVOKABLE void parse(QString path);

public slots:
  void setData(const QVariantList &data);
  void setResult(bool result);
  void setLength(int length);

signals:
  void dataChanged(const QVariantList &data);
  void resultChanged(bool result);
  void lengthChanged(int length);

private:
  QVariantList m_data;
  bool m_result = {false};
  int m_length = {0};
};
} // namespace JSONIC

#endif // DATAMANAGER_H
