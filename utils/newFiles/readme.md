# nf - newFiles 
is a tool to help you identify new devices as they are plugged in. But it can be used more generally to find new files in a given directory.

# Syntax

    $0 [directoryToMonitor[ tempDirectory]]

## directoryToMonitor

Specifies which directory to monitor. This is option, but required if you want to specify the tempDirectory.

If directoryToMonitor is absent, it will be assumed to be `/dev/block` .

## tempDirectory

* `nf.linux` defaults to `/tmp/nf`
* `nf.android` defaults to `/sdcard/tmp/nf`

# Example

    nf