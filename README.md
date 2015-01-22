Monitor the progress of large MySQL insert/import

# Introduction

If you ever impored a large mysql table, you know how frustrating the wait can be. 

This small bash script allows you to track the progress (in %) of large mysql insert/import. 

### Usage

```
./track-progress.sh [SQL-FILE]
```

You can run this script at any point during the mysql import.

### Example

```
$ mysql < large.sql &
[2] 12345
$ ./track-progress.sh large.sql
Line 144 out of 1467 (9.81%)
Line 151 out of 1467 (10.29%)
Line 154 out of 1467 (10.49%)
Line 161 out of 1467 (10.97%)
Line 167 out of 1467 (11.38%)
```

### Configuration

Change the MYSQL parameter to add user/password or alternative path for mysql executable.


