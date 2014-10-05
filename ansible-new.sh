#!/bin/sh
# Script for initializing the directory structure for Ansible playbooks
# see http://docs.ansible.com/playbooks_best_practices.html#directory-layout

if [ "$#" != 1 ];
then
  echo "Usage: $0 playbooks-dir"
  exit 1
fi

PLAYBOOKS_DIR="$1"

if [ -x "${PLAYBOOKS_DIR}" ];
then
  echo "Error: Playbooks directory already exists!"
  exit 1
fi

mkdir "${PLAYBOOKS_DIR}"
pushd "${PLAYBOOKS_DIR}" >/dev/null

echo "# inventory file for production servers" > production
echo "# inventory file for stage environment"  > stage

mkdir group_vars
echo "# here we assign variables to paticular groups" > group_vars/group1

mkdir host_vars
echo "# if systems need specific variables, put them here" > host_vars/hostname1

echo "# master playbook" > site.yml
echo "# playbook for webserver tier" > webservers.yml
echo "# playbook for dbserver tier"  > dbservers.yml

mkdir -p roles/common/tasks
pushd roles/common >/dev/null

echo "# this hierarchy represents a \"role\"" > tasks/main.yml
echo "#" >> tasks/main.yml
echo "# <-- tasks file can include smaller files if warranted" >> tasks/main.yml

mkdir handlers
echo "# <-- handlers file" > handlers/main.yml

mkdir templates
echo "# <-- files for use with the template resource" > templates/ntp.conf.j2
echo "# <------- templates end in .j2" >> templates/ntp.conf.j2

mkdir files
echo "# <-- files for use with the copy resource" > files/bar.txt
echo "# <-- script files for use with the script resource" > files/foo.sh

mkdir vars
echo "# <-- variables associated with this role" > vars/main.yml

mkdir defaults
echo "# <-- default lower priority variables for this role" > defaults/main.yml

mkdir meta
echo "# <-- role dependencies" > meta/main.yml

popd >/dev/null

popd >/dev/null

echo "Ansible playbooks directory layout initialized in ${PLAYBOOKS_DIR}"
exit 0
