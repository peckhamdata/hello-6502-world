# hello-6502-world

`Hello World!` for various 6502/10 based machines.

Aim is to have a working toolchain that can do all the machine specific
stuff to get it running on an emulator and real hardware.

Starting with the Commodore 64:

![Commodore 64](assets/hello-world-c64.png)

And the VIC 20:

![VIC 20](assets/hello-world-vic20.png)

# Usage

Install depenencies with `install_tools.sh` then make with:

* `C64` - `make EMU=x64 PLATFORM=C64` then type `RUN` in the emulator.
* `VIC 20` - `make EMU=xvic PLATFORM=VIC20` then type `SYS 4352` in the emulator.

You'll need to `make clean` when switching platforms.