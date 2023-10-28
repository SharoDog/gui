file(GLOB QML_FILES
	RELATIVE
		${CMAKE_CURRENT_SOURCE_DIR}
	*.qml
)

qt_add_library(views STATIC)
qt_add_qml_module(views 
	URI views 
	VERSION 1.0 
	QML_FILES 
		${QML_FILES}
	RESOURCES
		ethnocentric.otf
)
