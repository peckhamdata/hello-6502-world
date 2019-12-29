# Commodore/Atari 8 bit toolchain

KICKASS_JAR=$(KICK_HOME)/KickAss.jar
C1541=$(VICE_HOME)/tools/c1541
PROG=hello
EMU=x64
PLATFORM=C64
PACKAGE=d64
OBJ=prg

.PHONY: deploy clean

deploy:$(PROG).$(PACKAGE)
ifeq ($(EMU), Atari800MacX)
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

clean:
	rm -f *.prg
	rm -f *.d64
	rm -f *.sym
	rm -f *.xex
