#include <QDir>
#include <QFileInfo>
#include <QGuiApplication> //
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QStandardPaths>
#include <include/datamanager.h>

using namespace JSONIC;

DataManager::DataManager() {

  m_jsonPath =
      QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);

  if (!QFile::exists(m_jsonPath)) {
    if (!QDir().mkdir(m_jsonPath)) {
      qInfo() << "Cannot create folder: " << m_jsonPath;
      return;
    }
  }

  m_jsonPath += "/data.json";
  qDebug() << "^^^^^^^^^^^^^^^ json path: " << m_jsonPath
           << "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n";
}

bool DataManager::fileExists(const QString &path) {
  QFileInfo check_file(path);
  // check if file exists and if yes, Is it really a file!
  if (check_file.exists() && check_file.isFile()) {
    return true;
  } else {
    return false;
  }
}

const QVariantList &DataManager::data() const { return m_data; }

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

void DataManager::parse() {

  QString rawData;
  QVariantMap modelData;
  QVariantList finalJson;

  QFile file;

  if (fileExists(m_jsonPath)) {
    {
      file.setFileName(m_jsonPath);
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
        modelData.insert("img_src", modelObject["img_src"].toString());
        modelData.insert("short_descr", modelObject["short_descr"].toString());
        modelData.insert("full_descr", modelObject["full_descr"].toString());
        modelData.insert("first_extra_img_src",
                         modelObject["first_extra_img_src"].toString());
        modelData.insert("second_extra_img_src",
                         modelObject["second_extra_img_src"].toString());
        modelData.insert("third_extra_img_src",
                         modelObject["third_extra_img_src"].toString());
        modelData.insert("fourth_extra_img_src",
                         modelObject["fourth_extra_img_src"].toString());

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

void DataManager::addItem(const QString &mainImgSrc, const QString &shortDescr,
                          const QString &fullDescr,
                          const QString &firstExtraImgSrc,
                          const QString &secondExtraImgSrc,
                          const QString &thirdExtraImgSrc,
                          const QString &fourthExtraImgSrc) {}
