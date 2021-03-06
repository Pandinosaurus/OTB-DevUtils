
# add the remotes modules from input_dir to the output_list
macro(get_remote_modules input_dir output_list)
  file(GLOB _remote_files "${input_dir}/*.remote.cmake")
  foreach(_remote_f ${_remote_files})
    file(STRINGS ${_remote_f} _mod_line REGEX "otb_fetch_module")
    string(REGEX REPLACE "otb_fetch_module\\( *([a-zA-Z0-9]+)" "\\1" _mod_name ${_mod_line})
    list(APPEND ${output_list} ${_mod_name})
  endforeach()
endmacro()

macro(get_module_enable_cache module_list output_cache)
  foreach(mod ${${module_list}})
    set(${output_cache} "${${output_cache}}
Module_${mod}:BOOL=ON")
  endforeach()
endmacro()

macro(get_module_disable_cache module_list output_cache)
  foreach(mod ${${module_list}})
    set(${output_cache} "${${output_cache}}
Module_${mod}:BOOL=OFF")
  endforeach()
endmacro()

macro(enable_official_remote_modules otb_src_dir output_cache)
  set(${output_cache})
  get_remote_modules(${otb_src_dir}/Modules/Remote _output_list)
  get_module_enable_cache(_output_list output_cache)
endmacro()

# set the git update command to checkout the given branch (using CTEST_GIT_COMMAND)
# the macro looks for the git_updater scrip, and modifies CTEST_GIT_UPDATE_CUSTOM
macro(set_git_update_command _branch)
  if((NOT _git_updater_script) OR (NOT EXISTS "${_git_updater_script}"))
    if(EXISTS ${CTEST_SCRIPT_DIRECTORY}/git_updater.cmake)
      set(_git_updater_script ${CTEST_SCRIPT_DIRECTORY}/git_updater.cmake)
    elseif(EXISTS ${CTEST_SCRIPT_DIRECTORY}/../git_updater.cmake)
      set(_git_updater_script ${CTEST_SCRIPT_DIRECTORY}/../git_updater.cmake)
    elseif(EXISTS ${CTEST_SCRIPT_DIRECTORY}/../../git_updater.cmake)
      set(_git_updater_script ${CTEST_SCRIPT_DIRECTORY}/../../git_updater.cmake)
    endif()
  endif()
  set(CTEST_GIT_UPDATE_CUSTOM ${CMAKE_COMMAND} -D GIT_COMMAND:PATH=${CTEST_GIT_COMMAND} -D TESTED_BRANCH:STRING=${_branch} -P ${_git_updater_script})
endmacro()

macro(set_git_update_and_sync_command _branch _sync_branch)
  set_git_update_command(${_branch})
  list(INSERT CTEST_GIT_UPDATE_CUSTOM -2 -D SYNC_BRANCH:STRING=${_sync_branch})
endmacro()

macro(clean_directories)
  foreach(dir ${ARGV})
    if(IS_DIRECTORY ${dir})
      file(REMOVE_RECURSE ${dir})
      file(MAKE_DIRECTORY ${dir})
    endif()
  endforeach()
endmacro()

# Custom function to remove a folder (divide & conquer ...)
function(remove_folder_recurse dir)
file(GLOB content "${dir}/*")
foreach(item ${content})
  if(IS_DIRECTORY ${item})
    execute_process(COMMAND ${CMAKE_COMMAND} -E remove_directory ${item}
      RESULT_VARIABLE ret)
    if(ret)
      remove_folder_recurse(${item})
    endif()
  else()
    execute_process(COMMAND ${CMAKE_COMMAND} -E remove -f ${item})
  endif()
endforeach()
execute_process(COMMAND ${CMAKE_COMMAND} -E remove_directory ${dir})
endfunction(remove_folder_recurse)

# Analyse a file containing branches
#   INPUT: text file path
#   OUTPUT: variables "_branch_list", "specific_data_branch_for_<branch>"
macro(parse_branch_list _input_file)
  unset(_branch_list)
  set(_branch_list_regex "^ *(([a-zA-Z0-9]|-|_|\\.|/)+) *(([a-zA-Z0-9]|-|_|\\.|/)*) *\$")
  file(STRINGS ${_input_file} _feature_list_content
       REGEX ${_branch_list_regex})
  foreach(_line ${_feature_list_content})
    string(REGEX REPLACE ${_branch_list_regex} "\\1" _branch ${_line})
    string(REGEX REPLACE ${_branch_list_regex} "\\3" _databranch ${_line})
    list(APPEND _branch_list ${_branch})
    if(specific_data_branch_for_${_branch})
      unset(specific_data_branch_for_${_branch})
    endif()
    if(_databranch)
      set(specific_data_branch_for_${_branch} ${_databranch})
      message("Found specific data branch for ${_branch} : ${_databranch}")
    endif()
  endforeach()
endmacro()

# Convert a branch name with format "[user/]branch"  into "branch[@user]"
# suitable for a filename.
macro(convert_branch_to_filename _branch _path)
  get_filename_component(_branch_alone ${_branch} NAME)
  get_filename_component(_remote ${_branch} DIRECTORY)
  if(_remote)
    if(_remote MATCHES "^[a-zA-Z0-9_-]+\$")
      set(${_path} "${_branch_alone}@${_remote}")
    else()
      message("Wrong remote name found : ${_remote}")
      set(${_path} ${_branch})
    endif()
  else()
    set(${_path} ${_branch})
  endif()
endmacro()

macro(copy_file_to_nas)
  foreach(_file ${ARGV})
      get_filename_component(_file_name ${_file} NAME)
      execute_process(
        COMMAND ${CMAKE_COMMAND}
        -E copy
        "${_file}"
        "${OTBNAS_PACKAGES_DIR}/${_file_name}"
        RESULT_VARIABLE copy_rv)
      if(NOT copy_rv EQUAL 0)
        message("Cannot copy '${_file}' to '${OTBNAS_PACKAGES_DIR}'")
      else()
        message("Copied '${_file}' to '${OTBNAS_PACKAGES_DIR}'")
      endif()
    endforeach()
endmacro()

macro(copy_cookbook_to_nas)
  if(EXISTS "${OTBNAS_PACKAGES_DIR}")
    file(GLOB _html_tar_cb "${CTEST_BINARY_DIRECTORY}/CookBook-*-html.tar.gz")
    file(GLOB _pdf_cb "${CTEST_BINARY_DIRECTORY}/Documentation/Cookbook/latex/CookBook-*.pdf")
    copy_file_to_nas(${_html_tar_cb} ${_pdf_cb})
    if(EXISTS "${CTEST_BINARY_DIRECTORY}/Documentation/Cookbook/html")
      if(EXISTS "${_html_tar_cb}")
        string(REGEX REPLACE ".*/(CookBook-[0-9\\.]*)-html\\.tar\\.gz" "\\1" _output_cb_html "${_html_tar_cb}")
        execute_process(
          COMMAND ${CMAKE_COMMAND}
          -E copy_directory
          "${CTEST_BINARY_DIRECTORY}/Documentation/Cookbook/html"
          "${OTBNAS_PACKAGES_DIR}/${_output_cb_html}"
          RESULT_VARIABLE copy_rv)
        if(NOT copy_rv EQUAL 0)
          message("Cannot copy '${CTEST_BINARY_DIRECTORY}/Documentation/Cookbook/html' to '${OTBNAS_PACKAGES_DIR}/${_output_cb_html}'")
        else()
          message("Copied '${CTEST_BINARY_DIRECTORY}/Documentation/Cookbook/html' to '${OTBNAS_PACKAGES_DIR}/${_output_cb_html}'")
        endif()
      endif()
    endif()
  endif()
endmacro()

macro(copy_doxygen_to_nas)
  if(EXISTS "${OTBNAS_PACKAGES_DIR}")
    file(GLOB _html_tar_dox "${CTEST_BINARY_DIRECTORY}/Documentation/Doxygen/OTB-Doxygen-*.tar.bz2")
    copy_file_to_nas(${_html_tar_dox})
  endif()
endmacro()
