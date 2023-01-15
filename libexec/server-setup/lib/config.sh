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

# Check that git is installed.
if ! type /usr/bin/git >/dev/null 2>/dev/null
then
	error 'git executable not found at /usr/bin/git'
fi

if ! /usr/bin/git --version >/dev/null
then
	error 'error running git (/usr/bin/git)'
fi

# Confirm configuration file exists.
if [ ! -f "${configfile}" ]
then
	error 'configuration file not found:' "${configfile}"
fi

# Try to load a core configuration option.
if ! /usr/bin/git config -f "${configfile}" core.dirname >/dev/null
then
	error 'configuration file is malformed:' "${configfile}"
fi

# Configuration functions ##############################################

alias get-config="/usr/bin/git config -f \"${configfile}\""
