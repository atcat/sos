#!/bin/sh

#=====================================================================
# install into ~/.bash_profile.
#=====================================================================

if [[ -z "$sospath" ]]; then
echo "# Add this to the bottom of your ~/.bash_profile file:"
echo ""

read -r -d '' sos_bash_profile <<EOF
#=====================================================================
# github.com/atcat/sos
#=====================================================================
sospath="`pwd`"
source "\$sospath/sos.sh"
#source "$sospath/atcat/.bash_profile" 
unset sospath
EOF
cat <<EOF
$sos_bash_profile

EOF

read -r -p "Add that to your ~/.bash_profile now? [Y/n] " response
if [[ ${response:-Y} =~ ^([yY][eE][sS]|[yY])$ ]]
then
cat >>"$HOME/.bash_profile" <<EOF
$sos_bash_profile
EOF
fi

exit 1
fi


#=====================================================================
# sourcing into ~/.bash_profile
#=====================================================================

# add sos/bin to PATH.
export PATH="$PATH:$sospath/bin"

# add sos/atcat/bin to PATH and PYTHONPATH.
export PATH="$PATH:$sospath/atcat/bin"
export PYTHONPATH="$PYTHONPATH:$sospath/atcat/bin"

