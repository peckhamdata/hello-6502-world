AC_JAR=$(AC_HOME)/AppleCommander-ac-1.5.0.jar
KICKASS_JAR=$(KICK_HOME)/KickAss.jar
C1541=$(VICE_HOME)/tools/c1541
PRG2BBC=$(BEEB_HOME)/bin/prg2bbc.py
CREATE_SSD=$(BEEB_HOME)/bin/ssd_create.py

PROG=hello
EMU=x64
PLATFORM=C64 # APPLEII
PACKAGE=d64 # dsk
OBJ=prg

.PHONY: deploy clean

deploy:$(PROG).$(PACKAGE)
ifeq ($(PLATFORM), C64)
	EMU_OPTS='-autostart'
else
	EMU_OPTS='-autoload'	
endif
	$(EMU) $(EMU_OPTS) $(PROG).$(PACKAGE)

# Atari

$(PROG).xex: $(PROG).prg
	prg2xex < $(PROG).prg > $(PROG).xex

# C64, VIC

$(PROG).d64: $(PROG).prg
	$(C1541) -format $(PROG),1 d64 $(PROG).d64 -attach $(PROG).d64 -write $(PROG).prg 

# Beeb

$(PROG).ssd: $(PROG).inf $$.\!Boot
	# Create boot file / inf
	$(CREATE_SSD) -o $(PROG).ssd --opt4=3 $$.\!Boot $$.$(PROG)

$(PROG).inf: $(PROG).prg
	$(PRG2BBC) $(PROG).prg $$.$(PROG)
$(PROG).ssd: $(PROG).inf

$$.\!Boot: $(PROG).prg
	echo *RUN $(PROG) '\x0d' > $$.\!Boot

Boot.inf:
	echo $.!Boot 00000000 ffffffff > $$.\!Boot.inf

# Apple II

$(PROG).dsk: resources/appleii/blank.dsk loader.txt $(PROG).bin
	cp resources/appleii/blank.dsk $(PROG).dsk
	java -jar $(AC_JAR) -bas $(PROG).dsk HELLO < loader.txt
	java -jar $(AC_JAR) -dos $(PROG).dsk TEST B < $(PROG).bin

$(PROG).bin: $(PROG).b2
	dd bs=1 skip=2 if=$(PROG).b2 of=$(PROG).bin
$(PROG).b2: $(PROG).prg	
	prg2xex < $(PROG).prg > $(PROG).b2

# ORIC

$(PROG).tap: $(PROG).prg
	prg2tap < $(PROG).prg > $(PROG).tap

# All

$(PROG).$(OBJ):$(PROG).asm *.asm
	java -jar $(KICKASS_JAR) -define PLATFORM_$(PLATFORM) $(KICKASS_OPTS) $(PROG).asm

clean:
	rm -f *.prg
	rm -f *.d64
	rm -f *.sym
	rm -f *.xex
	rm -f *.inf
	rm -f *.ssd
	rm -f *.bin
	rm -f *.dsk
	rm -f $$.*