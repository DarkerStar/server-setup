########################################################################
#                                                                      #
# This file is part of indi::server-setup.                             #
#                                                                      #
# indi::server-setup is free software: you can redistribute it and/or  #
# modify it under the terms of the GNU General Public License as       #
# published by the Free Software Foundation, either version 3 of       #
# the License, or (at your option) any later version.                  #
#                                                                      #
# indi::server-setup is distributed in the hope that it will be        #
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty  #
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the      #
# GNU General Public License for more details.                         #
#                                                                      #
# You should have received a copy of the GNU General Public License    #
# along with indi::server-setup.                                       #
# If not, see <https://www.gnu.org/licenses/>.                         #
#                                                                      #
########################################################################

# vim: syntax=sh #######################################################

# If logging function is not defined, define a dummy function.
#
# Presumably logging will be enabled later.
if ! type log >/dev/null
then
	log() {
		:
	}
fi

# FUNCTION: error [MESSAGE]... #########################################
#
# Prints an error message to stderr, and simultaneously logs the error,
# then exits with an error status.
#
# If the last status code was an error status, that is the exit status
# code used. Otherwise, 1 is used.

error() {
	# Get the last status code. If it was 0, use 1 instead.
	status=${?}
	if [ ${status} -eq 0 ]
	then
		status=1
	fi

	# Print the error message.
	printf '%s: %s\n' "${script_name:-[ERROR]}" "${*}" >&2

	# Log the error message.
	log '[ERROR]:' "${@}"

	# Exit with error status.
	exit ${status}
}

# FUNCTION: warning [MESSAGE]... #######################################
#
# Prints an warning message to stderr, and simultaneously logs the
# warning.

warning() {
	# Print the warning message.
	printf '[WARNING]: %s\n' "${*}" >&2

	# Log the warning message.
	log '[WARNING]:' "${@}"
}
