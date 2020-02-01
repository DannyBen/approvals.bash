Approvals.bash - Bash Interactive Approval Testing
==================================================

![Version](https://img.shields.io/badge/version-0.2.4-blue.svg)
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
wget https://raw.githubusercontent.com/DannyBen/approvals.bash/master/approvals.bash
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


### Testing exit code and triggering custom failures

- The `approve` command returns the exit code of the command under test.
- You can use the `fail` command to force a failure.

For example:

```bash
approve "some-command --that --fails"
[[ $? == 0 ]] && fail "Expected non zero code, got $?"
```


Real World Examples
--------------------------------------------------

- The [test.sh](test/test.sh) file in this repository
- Approvals for the [rush command line][rush-example]
- Approvals for the [opcode command line][opcode-example]

[rush-example]: https://github.com/DannyBen/rush-cli/blob/master/test/test.sh
[opcode-example]: https://github.com/DannyBen/opcode/tree/master/test
