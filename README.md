# gcc-glibc2.15
Automated building of recent gcc versions in a minimal debootstrapped Ubuntu 12.04 for either compiling against the native glibc and system or compiling within a minimal environment containing only glibc 2.15 and the linux headers.


## About
This project is about providing a portable toolchain for CMake-based self-containing C/C++ projects targeting glibc 2.15.


## What is this good for?
I wanted a compact, portable CMake/GCC toolchain which doesn't require me to install all kinds of packages in my Linux systems.

My requirements:
 * Compiled libraries and executables have to be able to run on (almost) all distributions that are still in use
 * I have to be able to use dlopen to use the system libraries (so no static linking possible)
 * It should integrate well with my CMake / Visual Studio Code workflow (its CMake support is amazing nowadays)
 * It should be bloat-free
 * I need at least C++ 17 support at the moment
 * No libraries except those from glibc and gcc should be available (I use either dlopen or dummylibs for external dependencies)

## Why glibc 2.15 / Ubuntu 12.04?
 * I'm very familiar with Ubuntu
 * The original Steam runtime is based on Ubuntu 12.04
 * All still supported distributions use at least glibc 2.15 to my knowledge (RHEL7 uses 2.17)


## What does it include (currently)?
 * gcc 12.2.0
 * binutils 2.38
 * make 4.3
 * cmake 3.24.1
 * ninja 1.11.1
 
Along with this comes a minimal environment well suited for running inside bwrap, containing the glibc 2.15 from Ubuntu 12.04 and Linux headers.


## Source requirements for the wrapped environment
Your project has to be *self-contained*, meaning no external dependencies (except for glibc and the linux kernel).
Personally I use either dummy libraries to satisfy the linker for external libraries or dynamically load the required libraries (dlopen).
Some libraries already do the dynamic loading (e.g the SDL2 provided by the Steam runtime) so I just include them in my source tree.


## All of this sounds really complicated
Actually it isn't. Basically it comes down to run

    $ . setenv-bwrap.sh # The ". script" includes the file
    $ gcc --version # gcc now runs transparently inside a bwrapped environment using glibc 2.15
    gcc (GCC) 12.2.0
    Copyright (C) 2022 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
