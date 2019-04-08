if( NOT TARGET Cinder-MIDI2 )
  get_filename_component( MIDI2_ROOT_PATH "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE )

  list( APPEND MIDI2_SOURCES
		${MIDI2_ROOT_PATH}/src/MidiHub.cpp
		${MIDI2_ROOT_PATH}/src/MidiIn.cpp
		${MIDI2_ROOT_PATH}/src/MidiMessage.cpp
		${MIDI2_ROOT_PATH}/src/MidiOut.cpp
		${MIDI2_ROOT_PATH}/lib/RtMidi.cpp
	)

  add_library( Cinder-MIDI2 ${MIDI2_SOURCES} )

  list( APPEND MIDI2_INCLUDE_DIRS
	${MIDI2_ROOT_PATH}/include
	${MIDI2_ROOT_PATH}/lib
	)
  
  target_include_directories( Cinder-MIDI2 PUBLIC "${MIDI2_INCLUDE_DIRS}" )

  if( NOT TARGET cinder )
	include( "${CINDER_PATH}/proj/cmake/configure.cmake" )
	find_package( cinder REQUIRED PATHS
	  "${CINDER_PATH}/${CINDER_LIB_DIRECTORY}"
	  "$ENV{CINDER_PATH}/${CINDER_LIB_DIRECTORY}" )
	endif()

	if ( DEFINED CINDER_LINUX )
		add_definitions(-D__UNIX_JACK__)

		find_library( JACK_LIB jack )
		target_link_libraries( Cinder-MIDI2 PRIVATE ${JACK_LIB})
	endif()

	if ( DEFINED CINDER_MAC )
	  add_definitions(-DCINDER_MAC )
	  target_link_libraries( Cinder-MIDI2 "-framework CoreMidi" )
	endif()
  
  target_link_libraries( Cinder-MIDI2 PRIVATE cinder )
  
endif()
