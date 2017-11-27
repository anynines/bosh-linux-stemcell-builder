#!/usr/bin/env bash

set -e

base_dir=$(readlink -nf $(dirname $0)/../..)
source $base_dir/lib/prelude_apply.bash
source $base_dir/lib/prelude_bosh.bash

os_type=$(get_os_type)

## The opensuse script isn't executable, which seems like it should cause a failure.
## Might be slipping by because we don't have -o pipefail set.
if [ "${os_type}" == "centos" ] || [ "${os_type}" == "ubuntu" ] || [ "${os_type}" == "opensuse" ] ;  then
  cp -p $assets_dir/generate_dev_tools_file_list_$os_type.sh $chroot/bin/generate_dev_tools_file_list
  run_in_chroot $chroot "/bin/generate_dev_tools_file_list | sort | uniq > /var/vcap/bosh/etc/dev_tools_file_list"
  rm $chroot/bin/generate_dev_tools_file_list
fi
