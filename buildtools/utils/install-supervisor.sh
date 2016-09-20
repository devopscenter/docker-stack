#!/bin/bash

# Install supervisor 3.2.3 via pip install, and mimic installation structure and configs of apt-get install.
# Must be run after python and it's pip is installed.
#
# There is a single argument: "custom" if python will install supervisor in /usr/local/opt/python/bin/,
# "normal" (or anything else if python will install supervisor in /usr/local/bin.

sudo pip install supervisor
if [[ $1 == "custom" ]]; then
  export PATH="${1}/:${PATH}"
  sudo cp ~/docker-stack/buildtools/utils/initd-supervisor-custom /etc/init.d/supervisor
else
  sudo cp ~/docker-stack/buildtools/utils/initd-supervisor /etc/init.d/supervisor
fi

# Create the config directory structure that the ubuntu-packaged supervisor uses.
sudo mkdir /etc/supervisor
sudo mkdir /etc/supervisor/conf.d
sudo mkdir /var/log/supervisor
sudo cp ~/docker-stack/buildtools/utils/supervisord.conf /etc/supervisor/

# make a symlink so that the pip-installed supervisor can find the configuration file
sudo ln -s /etc/supervisor/supervisord.conf /etc/supervisord.conf

# Now make sure that it starts up upon reboot
sudo update-rc.d supervisor defaults

# Finally set up symlinks if installed in the custom location (using a non-ubuntu python)
if [[ $1 == "custom" ]]; then
  sudo ln -s /usr/local/opt/python/bin/supervisord /usr/bin/supervisord
  sudo ln -s /usr/local/opt/python/bin/supervisorctl /usr/bin/supervisorctl
fi