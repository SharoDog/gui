add_executable(sharo_gui main.cpp)

target_link_libraries(sharo_gui PRIVATE manager communication video Qt6::Gui Qt6::Quick Qt6::Network)
qt_policy(
	SET QTP0001 NEW
)
file(GLOB QML_FILES
	RELATIVE 
		${CMAKE_CURRENT_SOURCE_DIR}
	*.qml
)
qt_add_qml_module(sharo_gui 
	URI 
	views 
	VERSION 1.0 
	QML_FILES 
		${QML_FILES}
	RESOURCES
		ethnocentric.otf
)
