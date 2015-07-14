#!/bin/sh

#=====================================================================
# install into ~/.bash_profile.
#=====================================================================

if [[ -z "$sospath" ]]; then
echo "# Add this to the bottom of your ~/.bash_profile file:"
echo ""

read -r -d '' sos_bash_profile <<EOF
#
# github.com/atcat/sos
#
sospath="`pwd`"
source "\$sospath/sos.sh"
EOF
cat <<EOF
$sos_bash_profile

EOF

read -r -p "Append this to your ~/.bash_profile now? [Y/n] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
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
export PATH="$PATH:$(pwd)/bin"

# add sos/atcat/bin to PATH.
export PATH="$PATH:$(pwd)/atcat/bin"

