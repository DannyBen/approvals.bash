# Approvals.bash - Bash Interactive Approval Testing

![repocard](https://repocard.dannyben.com/svg/approvals.svg)

Interactive approval testing for your bash scripts.

![demo](demo/cast.gif)

**approvals.bash** is a lightweight interactive testing framework for your bash
scripts.

With it, your tests will compare the output of a command with an
expected output stored in the approvals folder.

- When the approval file does not exist, the actual output will be displayed,
  and you will be prompted to approve (and save) it.
- When the approval file exists, but contains different data, the diff will
  be displayed, and you will be prompted to approve (and save) it.
- When the approval file exists and contains matching data, the approval
  test will pass.
- When a new/updated approval is rejected, your tests will exit immediately
  with exit code 1.
- When running in a CI environment (`CI` variable exists), or on GitHub
  Actions (`GITHUB_ACTIONS` variable exists), your tests will run in
  non-interactive mode - tests will fail automatically if they do not match.


## Installation

Download [approvals.bash](approvals.bash) to your test folder. You can also
download it by running this:

```shell
wget get.dannyb.co/approvals.bash
```

## Usage

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


### Annotation commands (`context`, `describe`, `it`)

If your apptovals test files become too long or complex, you may the
`describe`, `context` or `it` commands to annotate your tests. These commands
are purely decorative and will output the provided strings as captions.

```bash
describe "ls"
  it "shows the list of files"
    approve "ls"

context "when in a non-empty directory"
  cd ./tmp
  describe "ls -s"
    approve "ls -s"
    approve "ls -s" "ls_size"
  
  cd ../
```

You can use any of the annotation commands, in any order. The indentation is
optional.


### Testing exit code

You can test the exit code of the last approved command by using the
`expect_exit_code <code>` command:

For example:

```bash
approve "some-command --that --fails"
expect_exit_code 1
```


### Allowing some difference

In case the command under test outputs slightly different values each run,
you can use the `allow_diff <regex>` command. This regex will be replaced
with an asterisk (`*`) in the actual output in the following `approve` call
(once only).

```bash
allow_diff "[0-9]\+"
approve "date"
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


## Auto-approval

Setting `AUTO_APPROVE=1` prior to running your tests will automatically approve
all tests, as if the user has pressed `a` to approve each changed or new test.


## Compatibility

approvals.bash was tested in **bash** (version 4.0 or higher) and **zsh**,
but might work in other shells as well.


## Real World Examples

### Simple examples

- The [approve][approve] file in this repository
- Approvals for [fuzzy-cd][fuzzy-cd-example], the fuzzy search cd patch
- Approvals for [respec][respec-example], the RSpec convenience wrapper
- Approvals for [git-changelog][git-changelog-example], the changelog generator
- Approvals for [rush][rush-example], the personal shell-based package manager

### Advanced examples (multiple test files)

- Approvals for [opcode][opcode-example], the local alias manager
- Approvals for [alf][alf-example], the global bash alias manager

## Contributing / Support

If you experience any issue, have a question or a suggestion, or if you wish
to contribute, feel free to [open an issue][issues].


[rush-example]: https://github.com/DannyBen/rush-cli/blob/master/test/approve
[opcode-example]: https://github.com/DannyBen/opcode/tree/master/test
[alf-example]: https://github.com/DannyBen/alf/tree/master/test
[fuzzy-cd-example]: https://github.com/DannyBen/fuzzy-cd/tree/master/test/approve
[respec-example]: https://github.com/DannyBen/respec/tree/master/test/approve
[git-changelog-example]: https://github.com/DannyBen/git-changelog/blob/master/test/approve
[approve]: https://github.com/DannyBen/approvals.bash/blob/master/test/approve
[issues]: https://github.com/DannyBen/approvals.bash/issues