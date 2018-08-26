# #%L
# OME Files C++ libraries (cmake build infrastructure)
# %%
# Copyright © 2015 Open Microscopy Environment:
#   - Massachusetts Institute of Technology
#   - National Institutes of Health
#   - University of Dundee
#   - Board of Regents of the University of Wisconsin-Madison
#   - Glencoe Software, Inc.
# %%
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# The views and conclusions contained in the software and documentation are
# those of the authors and should not be interpreted as representing official
# policies, either expressed or implied, of any organization.
# #L%

find_package(PythonInterp)

set(BUILD_SPHINX ${sphinx})

set(_ome_sphinx_list_dir "${CMAKE_CURRENT_LIST_DIR}")

function(sphinx_manpages srcdir confdir mandir manvar)
  execute_process(COMMAND "${PYTHON_EXECUTABLE}" -B ${_ome_sphinx_list_dir}/list-manpages.py
                          "${confdir}" "${srcdir}" "${mandir}"
                  RESULT_VARIABLE sphinx_man_fail
                  OUTPUT_VARIABLE MAN_PAGES)
  if (sphinx_man_fail)
    message(WARNING "Failed to get generated sphinx manual pages from ${confdir}")
  endif()
  string(REPLACE "\n" ";" MAN_PAGES "${MAN_PAGES}")
  set(${manvar} "${MAN_PAGES}" PARENT_SCOPE)
endfunction(sphinx_manpages)

function(sphinx_manpage_dependencies srcdir confdir depvar)
  execute_process(COMMAND "${PYTHON_EXECUTABLE}" -B ${_ome_sphinx_list_dir}/list-manpage-dependencies.py
                          "${confdir}"
                          "${srcdir}"
                  RESULT_VARIABLE sphinx_dep_fail
                  OUTPUT_VARIABLE SPHINX_MAN_DEPENDENCIES)
  if (sphinx_dep_fail)
    message(WARNING "Failed to get Sphinx dependencies from ${confdir}")
  endif()
  string(REPLACE "\n" ";" SPHINX_MAN_DEPENDENCIES "${SPHINX_MAN_DEPENDENCIES}")
  set(${depvar} "${SPHINX_MAN_DEPENDENCIES}" PARENT_SCOPE)
endfunction(sphinx_manpage_dependencies)

function(sphinx_dependencies srcdir depvar)
  file(GLOB_RECURSE CRUDE_SPHINX_DEPENDENCIES "${srcdir}/*.rst")
  foreach(file ${CRUDE_SPHINX_DEPENDENCIES})
    string(FIND "${file}" "_build" FILE_MATCH)
    if(FILE_MATCH EQUAL -1)
      list(APPEND SPHINX_DEPENDENCIES "${file}")
    endif()
  endforeach()
  set(${depvar} "${SPHINX_DEPENDENCIES}" PARENT_SCOPE)
endfunction(sphinx_dependencies)
