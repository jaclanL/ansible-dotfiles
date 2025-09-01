# Molecule

Molecule lets you test roles and playbooks by spinning up containers to run against.

For running the full test sequence run `molecule test`

## Development workflow

```shell
# Quick iteration cycle
molecule create
molecule converge
molecule verify

# Make changes, then repeat
molecule converge
molecule verify

# Clean up when done
molecule destroy
```

## To test roles selectivly

By using tags one can selectivly test a certain role by exporting the tag with
`ANSIBLE_RUN_TAGS` before running molecule.

`export ANSIBLE_RUN_TAGS=<tag1> && molecule converge && unset ANSIBLE_RUN_TAGS`

The unset command is used to reset back to running-all-roles-by-default.
