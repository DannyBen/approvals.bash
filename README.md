Approvals.bash - Bash Interactive Approval Testing
==================================================

Interactive approval testing for your bash scripts.

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
- When running in a CI environment (CI variable exists), we will run in non
  interactive mode (so tests will fail automatically if they do not match).

Usage
--------------------------------------------------

In your test script:

```bash
#!/usr/bin/env bash
source approvals.bash
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

See the [test.sh](test/test.sh) file in this repository for a simple working 
example, or [this real world example][1].


[1]: https://github.com/DannyBen/rush-cli/blob/master/test/test.sh