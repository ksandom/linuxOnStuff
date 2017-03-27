#!/bin/bash
# Fix any permisions that are incorrect.

cd /dev
ln -s /proc/self/fd .
