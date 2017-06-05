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

    nf.linux
    
    Thu Mar 30 06:34:04 UTC 2017
    93a94,96
    > sdh
    > sdh1
    > sdh2

# nf.linux vs nf.android?

* `nf.android` - Use when running locally on the Android command line.
* `nf.linux`
  * Use when running natively on linux.
  * Use when running a linux chroot on Android.
