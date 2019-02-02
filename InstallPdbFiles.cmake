# Loosely inspired by https://github.com/Microsoft/vcpkg/blob/master/scripts/cmake/vcpkg_copy_pdbs.cmake

file(GLOB_RECURSE BINARY_FILES "${CMAKE_INSTALL_PREFIX}/bin/*.dll" "${CMAKE_INSTALL_PREFIX}/bin/*.exe")
foreach(BINARY_FILE ${BINARY_FILES})
    execute_process(
        COMMAND dumpbin /PDBPATH "${BINARY_FILE}"
        OUTPUT_VARIABLE DUMPBIN_OUTPUT
    )
    if (DUMPBIN_OUTPUT MATCHES "'([^']+\\.pdb)'")
        file(INSTALL "${CMAKE_MATCH_1}" DESTINATION "${CMAKE_INSTALL_PREFIX}/bin")
    endif()
endforeach()