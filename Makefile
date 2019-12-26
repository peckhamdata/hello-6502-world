# C64 toolchain

KICKASS_JAR=$(KICK_HOME)/KickAss.jar
C1541=$(VICE_HOME)/tools/c1541
PROG=hello
EMU=xvic
PLATFORM=VIC20

.PHONY: deploy clean

deploy:$(PROG).d64
	$(EMU) -autoload $(PROG).d64

$(PROG).d64:$(PROG).prg
	$(C1541) -format $(PROG),1 d64 $(PROG).d64 -attach $(PROG).d64 -write $(PROG).prg 

$(PROG).prg:$(PROG).asm *.asm
	java -jar $(KICKASS_JAR) -define PLATFORM_$(PLATFORM) $(PROG).asm

clean:
	rm -f *.prg
	rm -f *.d64
	rm -f *.sym
