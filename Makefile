# Commodore/Atari 8 bit toolchain

KICKASS_JAR=$(KICK_HOME)/KickAss.jar
C1541=$(VICE_HOME)/tools/c1541
PRG2BBC=$(BEEB_HOME)/bin/prg2bbc.py
CREATE_SSD=$(BEEB_HOME)/bin/ssd_create.py
PROG=hello
EMU=x64
PLATFORM=C64
PACKAGE=d64
OBJ=prg

.PHONY: deploy clean

deploy:$(PROG).$(PACKAGE)
ifeq ($(EMU), Atari800MacX)
	open $(PROG).$(PACKAGE)
endif
ifeq ($(EMU), BeebEm)
	open $(PROG).$(PACKAGE)
else
	$(EMU) -autostart $(PROG).d64
endif

$(PROG).$(PACKAGE):$(PROG).$(OBJ)
ifeq ($(PACKAGE), xex)
	prg2xex < $(PROG).prg > $(PROG).xex
else
	$(C1541) -format $(PROG),1 d64 $(PROG).d64 -attach $(PROG).d64 -write $(PROG).prg 
endif

$(PROG).$(OBJ):$(PROG).asm *.asm
	java -jar $(KICKASS_JAR) -define PLATFORM_$(PLATFORM) $(KICKASS_OPTS) $(PROG).asm

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

clean:
	rm -f *.prg
	rm -f *.d64
	rm -f *.sym
	rm -f *.xex
	rm -f *.inf
	rm -f *.ssd
	rm -f $$.*