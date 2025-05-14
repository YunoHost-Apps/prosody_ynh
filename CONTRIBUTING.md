# Contributing

## Preamble

This app is based on Debian packages, not from source.
You can read about this choice in [doc/RATIONALE.md].

This choice has some subtle implications regarding the "traditional way" of packaging apps in yunohost:

- some manifest entries are not relevant, i.e. `ram.build = ...`
- some helpers not needed, i.e. `ynh_config_add_systemd ...`
- ...


## Contribution rules

### Make atomic commits

Do your best to modify as few lines as possible.

If you fix a bug at line 42 and find a minor typo at line 55 in the same file, please leave that typo alone :)

Atomic commits:
- are easier to review
- make git history easier to read
- avoid meaningless conflicts/merges
- are easier to revert if needed
