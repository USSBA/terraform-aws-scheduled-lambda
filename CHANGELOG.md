# Changelog

## v3.0.0

* change: Added configurable retry attempts variable to control what happens when an invocation error occurs

## v2.1.0

* change: Adding tag variables
* bugfix: Fixing bug when no environment variables passed in

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
