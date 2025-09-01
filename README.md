# ansible-dotfiles

An opinionated set of dotfiles, setup as Ansible roles.

The intent of this repository is to automate the installation of tools/programs and
setup of configurations (dotfiles, etc.)

Given this, the development environment will be consistent and setup of new devices
smooth.

**Note:** Currently supports setup for MacOS and to a large extent also Debian
distributions.

## Install pre-requisites

`./install.sh`

## Ansible

To run the Ansible playbook

`ansible-playbook playbook.yaml --ask-become-pass`

or to run a specific role using `--tags`

`ansible-playbook playbook.yaml --ask-become-pass --tags <tag>`

The minimum installations will always run, but to omit the additional installations
then specify that with `--skip-tags additional`.

To check the list of available tags, run

`ansible-playbook playbook.yaml --list-tags`

To check what tasks each tag contain, run

`ansible-playbook playbook.yaml --tags <tag> --list-tasks`

Additional flags (Ansible builtin)

* `-v` (verbose) for debugging
* `--check` to only check and not running the installations
* `--diff` to also display any diffs of the changed installations

To list the available host groups

`ansible-inventory -i inventory --list`

### Molecule

To test the roles, run `molecule test`. For more details see [molecule/README.md](molecule/README.md)
