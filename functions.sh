#!/bin/bash
# Copyright 2016 Mirantis, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -eux

ROOT="$(dirname "$(readlink -f "$0")")"
MODULES_DIR="${ROOT}"/deployment_scripts/modules
RPM_REPO="${ROOT}"/repositories/centos/
DEB_REPO="${ROOT}"/repositories/ubuntu/

# Download RPM or DEB packages and store them in the local repository directory
function download_package {
    local package_type=$1
    local url=$2
    local wget_lvl=${3:-4}
    if [[ "$package_type" == 'deb' ]]; then
      REPO=$DEB_REPO
    elif [[ "$package_type" == 'rpm' ]]; then
      REPO=$RPM_REPO
    else
      echo "Invalid package type: $1"
    fi

    wget -P "$REPO" -A "$package_type" -nd -r -l ${wget_lvl} "$url"
}

# Download official Puppet module and store it in the local directory
function download_puppet_module {
    rm -rf "${MODULES_DIR:?}"/"$1"
    mkdir -p "${MODULES_DIR}"/"$1"
    wget -qO- "$2" | tar -C "${MODULES_DIR}/$1" --strip-components=1 -xz
}
