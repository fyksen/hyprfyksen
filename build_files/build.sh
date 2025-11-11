#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

dnf copr enable fyksen/wiremix
dnf5 install -y wiremix

# Fetch the latest release version
TAG=$(curl -s https://api.github.com/repos/shazow/wifitui/releases/latest | grep "tag_name" | cut -d '"' -f4)
OS="linux-$(uname -m)" # x86_64 or arm64
LATEST_RELEASE="https://github.com/shazow/wifitui/releases/download/${TAG}/wifitui-${TAG:1}-${OS}"

mkdir /tmp/wifitui
cd /tmp/wifitui
wget -q -O- "${LATEST_RELEASE}.rpm"
dnf5 install -y wifitui-${TAG:1}-${OS}

# try to
#### Example for enabling a System Unit File

systemctl enable podman.socket
