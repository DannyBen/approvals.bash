Change Log
========================================

v0.5.1 - 2024-03-08
----------------------------------------

- Add auto-approval with AUTO_APPROVE environment variable
- Add `it` annotation and reduce annotation color noise


v0.5.0 - 2024-02-27
----------------------------------------

- Make output format more compact


v0.4.2 - 2024-02-15
----------------------------------------

- Fix unbound variable error when using `set -u`


v0.4.1 - 2024-01-05
----------------------------------------

- Update `allow_diff` to check with `sed -E` instead of just `sed`


<!-- break v0.4.0 -->
v0.4.0 - 2023-08-28
----------------------------------------

- Fix exit codes on failure and apply set -e
- Improve error handling and output
- Add `allow_diff` function to allow some diff by regex
