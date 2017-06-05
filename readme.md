# linuxOnStuff

This is a chroot manager that I have made generic to cater to all the things I want to do on various devices. I've been through several iterations to get to this point, and have honed in a design that I'm very happy with.

## Installing it

### On a linux host

* run `./install-linux.sh`
* Go to "Getting started", below to do something useful with it.

### On an android host

* run `./install-android.sh`
* Go to "Getting started", below to do something useful with it.

## Getting started

### Overview

You need

* An image to mount.
* A config file in install_dir/.cr/config.d

I suggest taking a skim over [this page](http://funnyhacks.com/chroot), where I put together a large collection of opinions as a result of making a chroot environment practical for me on various types of devices. It may or may not be useful for you.

### An image to mount.

This needs to be
* an image of a partition, not an image of a disk with partitions. If you use something like a Raspberry pi image, you will need to extract the desired partition from it.
* containing binaries compatible with your 
  * CPU. Eg ARM vs x86, 32 vs 64 bit etc.
  * hardware in general.
  * kernel. I usually take a low effort guess based on the compatibility with the hardware and have almost always gotten good results. If you have trouble, try a different image.


### A config file

This describes the chroot enviroment. You can have as many as you like.
There is an example in config.d/examples.
