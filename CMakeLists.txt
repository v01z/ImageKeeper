cmake_minimum_required(VERSION 3.16)

project(ImageKeeper VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTORCC ON)

set(APP_NAME appImageKeeper)

set(QML_SRCS
    qml/Main.qml
    qml/ImgChooser.qml
    qml/NewItemSpace.qml
)

set(HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/include/datamanager.h)

set(CPP_FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/cpp/main.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/cpp/datamanager.cpp
)

set(RESOURCES ${CMAKE_CURRENT_SOURCE_DIR}/res/res.qrc)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)


qt_standard_project_setup()

qt_add_executable(${APP_NAME}
    ${RESOURCES}
    ${CPP_FILES}
    ${HEADERS}
)

qt_add_qml_module(${APP_NAME}
    URI ImageKeeper
    VERSION 1.0
    QML_FILES ${QML_SRCS}
)

target_include_directories( ${APP_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR/include})

set_target_properties(${APP_NAME} PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(${APP_NAME}
    PRIVATE Qt6::Quick
)

install(TARGETS ${APP_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
