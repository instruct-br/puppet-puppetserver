BOXES=( default centos-6-x64 ubuntu-1604-x64 ubuntu-1804-x64 )

export BEAKER_PUPPET_COLLECTION=puppet5

for BOX in "${BOXES[@]}"; do
  PUPPET_INSTALL_TYPE="agent" BEAKER_set="${BOX}" rake beaker
done
