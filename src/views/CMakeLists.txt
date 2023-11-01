file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/blocks
	DESTINATION ${CMAKE_BINARY_DIR}/build/src/views/blocks)

add_custom_target (blocks ALL 
	WORKING_DIRECTORY blocks
	COMMAND npm run build 
	VERBATIM
)

file(GLOB QML_FILES
	RELATIVE
		${CMAKE_CURRENT_SOURCE_DIR}
	*.qml
)

qt_add_library(views STATIC)
add_dependencies(views blocks)
qt_add_qml_module(views 
	URI views 
	VERSION 1.0 
	RESOURCE_PREFIX /sharo/imports
	QML_FILES 
		${QML_FILES}
	RESOURCES
		ethnocentric.otf
		blocks/dist/index.html
		blocks/dist/bundle.js
)
