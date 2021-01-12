# Changelog

## v2.1.0

* Support for Terraform versions 0.13 and above to (but not including) 1.0

## v2.0.1

* Updated documentation for clarity and ease of use, added code validation to CircleCI config, pre-commit config, and updated license

## v2.0.0

* Support for Terraform version 0.13
* Removed variable `enabled`

## v1.0.2

* change: Move zipped package to `var.source_directory/..` to de-clutter the base directory
* bugfix: Add null response to outputs if module is disabled

## v1.0.1

* bugfix: Move zipped package to `path.root` for function state consistency

## v1.0.0

* Initial Release
