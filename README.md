# hello-6502-world

`Hello World!` for various 6502/10 based machines.

Aim is to have a working toolchain that can do all the machine specific
stuff to get it running on an emulator and real hardware.

Starting with the Commodore 64:

![Commodore 64](assets/hello-world-c64.png)

VIC 20:

![VIC 20](assets/hello-world-vic20.png)

Atari 8-bit:

![A8](assets/hello-world-a8.png)

BBC Micro:

![Beeb](assets/hello-world-beeb.png)

# Usage

Install depenencies with `install_tools.sh` then make with:

* `C64` - `make EMU=x64 PLATFORM=C64`.
* `VIC 20` - `make EMU=xvic PLATFORM=VIC20` then type `SYS 4352` in the emulator.
* `Atari 8-bit` - `make PLATFORM=ATARI EMU=Atari800MacX PACKAGE=xex`
* `BBC Micro` - `make PLATFORM=BEEB EMU=BeebEm PACKAGE=ssd`

You'll need to `make clean` when switching platforms.
