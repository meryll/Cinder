# Recursively finds directories that end in "proj/cmake", which contain a CMakeLists.txt (ex. samples and tests)
macro( findCMakeDirs RESULT_PATHS BASE_PATH SKIP_PATHS )
	file( GLOB results "${BASE_PATH}/*" )
	foreach( f ${results} )
		if( IS_DIRECTORY "${f}" )
			set( shouldSkip FALSE )
			foreach( skip ${SKIP_PATHS} )
				if( f MATCHES ".*${skip}" )
					ci_log_v( "---- [findCMakeDirs] skipping path: ${f}" )
					set( shouldSkip TRUE )
					break()
				endif()
			endforeach()
			if( shouldSkip )
				continue()
			endif()

			if( f MATCHES ".*/proj/cmake$" )
				set( ${RESULT_PATHS} ${${RESULT_PATHS}} ${f} )
			else()
				findCMakeDirs( ${RESULT_PATHS} ${f} "${SKIP_PATHS}" )
			endif()
		endif()
	endforeach()
endmacro( findCMakeDirs RESULT_PATHS BASE_PATH )
