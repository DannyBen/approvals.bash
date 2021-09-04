Approvals.bash - Bash Interactive Approval Testing
==================================================

![Version](https://img.shields.io/badge/version-0.2.7-blue.svg)
[![Build Status](https://github.com/DannyBen/approvals.bash/workflows/Test/badge.svg)](https://github.com/DannyBen/approvals.bash/actions?query=workflow%3ATest)

---

Interactive approval testing for your bash scripts.

![demo](demo/cast.svg)

This script will compare the output of a command with an expected output
stored in the approvals folder.

- When the approval file does not exist, the actual output will be shown to
  you, and you will be prompted to approve (and save) it.
- When the approval file exists, but contains different data, the diff will
  be shown to you, and you will be prompted to approve (and save) it.
- When the approval file exists and contains matching data, the approval
  test will pass.
- When a new/updated approval is rejected, we will exit immediately with
  exit code 1.
- When running in a CI environment (CI variable exists), or on GitHub
  Actions (GITHUB_ACTIONS variable exists), we will run in non interactive
  mode (so tests will fail automatically if they do not match).


Installation
--------------------------------------------------

Download [approvals.bash](approvals.bash) to your test folder. You can also
download it by running this:

```shell
wget get.dannyb.co/approvals.bash
```

Usage
--------------------------------------------------

In your test script, add `approve` commands, using this syntax:

```bash
approve <command> [<approval file name>]
```

For example:

```bash
#!/usr/bin/env bash
source approvals.bash

approve "ls -s"
approve "ls -s" "ls_size"
# ... more tests
```


### Adding `describe` annotations

If your apptovals test files become too long, you may use the `describe`
command to annotate your tests. This is purely decorative.

```bash
describe "test ls"
  approve "ls -s"

describe "test ls in another directory"
  cd ./tmp
  approve "ls -s"
  approve "ls -s" "ls_size"
  cd ../
```

The indentation is optional.


### Testing exit code

You can test the exit code of the last approved command by using the
`expect_exit_code <code>` command:

For example:

```bash
approve "some-command --that --fails"
expect_exit_code 1
```


### Triggering custom failures

You can use the `fail <message>` command to trigger custom failures:

```bash
approve "some-command-that-creates some-dir"
[[ -d some-dir ]] || fail "Expected directory some-dir to exist"
```


### Configuration

By default, all approvales are stored in the `./approvals` directory
(relative to the currently running test).

If you wish to store approvals in a different directory, set the
`APPROVALS_DIR` environment variable before running your tests:

```shell
# test/test.sh
export APPROVALS_DIR=$PWD/my-approvals

approve "..."
```


Compatibility
--------------------------------------------------

approvals.bash was tested in **bash** (version 4.0 or higher) and **zsh**,
but might work in other shells as well.


Real World Examples
--------------------------------------------------

- The [approve][approve] file in this repository
- Approvals for [rush][rush-example], the personal shell-based package manager
- Approvals for [opcode][opcode-example], the local alias manager
- Approvals for [alf][alf-example], the global bash alias manager


[rush-example]: https://github.com/DannyBen/rush-cli/blob/master/test/approve
[opcode-example]: https://github.com/DannyBen/opcode/tree/master/test
[alf-example]: https://github.com/DannyBen/alf/tree/master/test
[approve]: https://github.com/DannyBen/approvals.bash/blob/master/test/approve