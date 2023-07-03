#include "datamanager.h"
#include <QDir>
#include <QFileInfo>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>

using namespace JSONIC;

DataManager::DataManager() {}

bool DataManager::fileExists(QString path) {
  QFileInfo check_file(path);
  // check if file exists and if yes, Is it really a file!
  if (check_file.exists() && check_file.isFile()) {
    return true;
  } else {
    return false;
  }
}

QVariantList DataManager::data() const { return m_data; }

void DataManager::setData(const QVariantList &data) {
  if (m_data == data)
    return;
  m_data = data;
  emit dataChanged(m_data);
}

int DataManager::length() const { return m_length; }

void DataManager::setLength(int length) {
  if (m_length == length)
    return;
  m_length = length;
  emit lengthChanged(m_length);
}

bool DataManager::result() const { return m_result; }

void DataManager::setResult(bool result) {
  if (m_result == result)
    return;

  m_result = result;
  emit resultChanged(m_result);
}

void DataManager::parse(QString path) {

  QString rawData;
  QVariantMap modelData;
  QVariantList finalJson;

  QFile file;
  QDir dir(".");

  if (fileExists(path)) {
    {
      file.setFileName(path);
      file.open(QIODevice::ReadOnly | QIODevice::Text);

      // Load data from json file:
      rawData = file.readAll();

      file.close();

      // Create json document.
      // Parses json as a UTF-8 encoded JSON document, and creates a
      // QJsonDocument from it.

      QJsonDocument document = {QJsonDocument::fromJson(rawData.toUtf8())};

      // Create data as Json object
      QJsonObject jsonObject = document.object();

      // Sets number of items in the list as integer.
      setLength(jsonObject["model"].toArray().count());

      foreach (const QJsonValue &value, jsonObject["model"].toArray()) {

        // Sets value from model as Json object
        QJsonObject modelObject = value.toObject();

        modelData.insert("id", modelObject["id"].toInt());
        modelData.insert("imgSrc", modelObject["imgSrc"].toString());
        modelData.insert("descr", modelObject["descr"].toString());

        // Set model data
        finalJson.append(modelData);
      }

      // Sets data
      setData(finalJson);

      // Sets result by status object of model.
      setResult(jsonObject["result"].toBool());
    }

  } else {
    qWarning() << "There is no any file in this path!";
  }
}
