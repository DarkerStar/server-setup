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

# Sanity checks ########################################################

# Confirm module done file exists.
if [ ! -f "${logdir}/modules.done" ]
then
	: >"${logdir}/modules.done"
fi

# FUNCTION: modules_mark_done [MODULE]... ##############################
#
# Marks the modules given as successfully completed.

modules_mark_done() {
	{
		for module in "${@}"
		do
			printf '%s\n' "${module}"
		done
	} >>"${logdir}/modules.done"
}

# FUNCTION: modules_all_done [MODULE]... ###############################
#
# Given a list of modules, returns success if and only if ALL of those
# modules have been successfully completed.

modules_all_done() {
	for module in "${@}"
	do
		if ! grep -F -x -q "${module}" "${logdir}/modules.done"
		then
			return 1
		fi
	done

	return 0
}

# FUNCTION: modules_get_not_done [MODULE]... ###########################
#
# Given a list of modules, returns only those that have not been
# successfully completed.

modules_get_not_done() {
	for module in "${@}"
	do
		if ! grep -F -x -q "${module}" "${logdir}/modules.done"
		then
			printf '%s\n' "${module}"
		fi
	done
}
