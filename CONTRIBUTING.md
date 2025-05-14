# Contributing

## Preamble

This app is based on Debian packages, not from source.
You can read about this choice in [doc/RATIONALE.md].

This choice has some subtle implications regarding the "traditional way" of packaging apps in yunohost.

TODO:
- list manifest entries that are not relevant
- list some helpers not needed (i.e. ynh_config_add_systemd)
- ...


## Contribution rules

### Minimal diff

Do your best to modify a few lines as possible.

If you fix a bug at line 42 and find a minor typo at line 55 in the same file, please leave that typo alone :)

Small diff:
- are easier to review
- make git history easier to read
- avoid useless code conflicts/merges
- are easier to revert if needed
