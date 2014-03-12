dynamips-microcode
==================

Turning the microcodes of dynamips into compilable sources.

I'm gonna start with `ppc32_microcode` since 32-bit PowerPC assembly is easier
than 64-bit MIPS assembly.

_Flávio J. Saraiva_

Dynamips
--------

dynamips can be found at:
 - https://github.com/GNS3/dynamips (source repository)
 - http://sourceforge.net/projects/gns-3/files/Dynamips/ (releases)
 - Debian/Ubuntu packages

The emulated hardware has missing features in many places.
It's able to load the IOS images because of the microcode,
which is a replacement for the original ROMMON.

I haven't tried it (can't find one) but it's unlikely that a real ROMMON image
would work, due to the missing hardware features.

Microcode
---------

The microcode has enough features to run the IOS image but don't expect any of
other ROMMON features. There is some work done for restart but it appears to be
incomplete.

It is unlikely to work in other emulators since it relies on the incompleteness
of the emulated hardware and on the custom remote control device found in
`dev_remote.c`.


Cross-compilers
===============

I use two cross-compilers created with [crosstools-ng](http://crosstool-ng.org/) 1.19.0:
 - powerpc-unknown-elf for `ppc32_microcode`
 - mips64-unknown-elf for `mips64_microcode`

Each toolchain will be inside a subdirectory of ~/x-tools.
They are used to decompile the original binary files and to compile the
disassembled microcode for testing and comparing purposes.

At a later date I'll try to use existing cross-compilers to compile the
resulting source. (no idea what to use or how to use them)

powerpc-unknown-elf
-------------------

```
ct-ng mips-unknown-elf
ct-ng menuconfig
  >  Target options  >  Target Architecture (powerpc)
ct-ng build
```

mips64-unknown-elf
------------------

```
ct-ng mips-unknown-elf
ct-ng menuconfig
  >  Paths and misc options  >  [*] Try features marked as EXPERIMENTAL
  >  Target options  >  Bitness (64-bit)
  >  Target options  >  ABI (n64)
ct-ng build
```
