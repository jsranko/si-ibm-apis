LIBRARY=SIIIA
DBGVIEW=*SOURCE

OBJECT_DESC='(SI) IBM i Apis Framework'
MAKELOG=makefile.output
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

SRVPGMS=\
	SIUI.srvpgm \
	SIXCP.srvpgm \
	SIHASH.srvpgm \
	SIOD.srvpgm \
	SIITR.srvpgm \
	SIJL.srvpgm \
	SIDT.srvpgm \
	SISQL.srvpgm \
	SIULC.srvpgm \
	SIPATH.srvpgm \
	SIDBGA.srvpgm \
	SIUUID.srvpgm \
	SISTR.srvpgm \
	SIQSH.srvpgm \
	SIQSHLOG.srvpgm \
	SICURL.srvpgm \
	SIIMF.srvpgm \
	SIIOF.srvpgm \
	SINL.srvpgm \
	SIISF.srvpgm \
	SIDIR.srvpgm \
	SIJI.srvpgm 

# Ensure that intermediate files created by rules chains don't get
# automatically deleted
.PRECIOUS: %.srvpgm %.lib

all: build

build: build-main

build-main: $(LIBRARY).lib $(LIBRARY).bnddir $(SRVPGMS)

%.srvpgm: %.module
	system -q "CRTSRVPGM SRVPGM($(LIBRARY)/$(@:%.srvpgm=%)) MODULE($(LIBRARY)/$(@:%.srvpgm=%)) EXPORT(*ALL) ACTGRP(*CALLER)" > $(MAKELOG) && touch $@	
	-system -q "ADDBNDDIRE BNDDIR($(LIBRARY)/$(LIBRARY)) OBJ(($(LIBRARY)/$(@:%.srvpgm=%) *SRVPGM *IMMED))" > $(MAKELOG) 
	system -q "DLTMOD MODULE($(LIBRARY)/$(@:%.srvpgm=%))" > $(MAKELOG) 

%.lib:
	(system -q "CHKOBJ $* *LIB" || system -q "CRTLIB $* TEXT($(OBJECT_DESC))") && touch $@
	
%.module: QRPGLESRC/%.RPGLE
	system -q "CRTRPGMOD MODULE($(LIBRARY)/$*) SRCSTMF('$<') DBGVIEW($(DBGVIEW)) REPLACE(*YES) INCDIR('$(ROOT_DIR)')" > $(MAKELOG)  && touch $@	
	
%.module: QRPGLESRC/%.SQLRPGLE
	system -q "CRTSQLRPGI OBJ($(LIBRARY)/$*) SRCSTMF('$<') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) REPLACE(*YES) COMPILEOPT('INCDIR(''$(ROOT_DIR)'')')" > $(MAKELOG)  && touch $@
	
%.bnddir: $(LIBRARY).lib
	(system -q "CHKOBJ OBJ($(LIBRARY)/$*) OBJTYPE(*BNDDIR)" || system -q "CRTBNDDIR BNDDIR($(LIBRARY)/$*) TEXT($(OBJECT_DESC))") > $(MAKELOG) && touch $@	
	
clean:
	rm -f *.lib *.pgm *.srvpgm *.module *.output *.bnddir
	system -q 'DLTLIB $(LIBRARY)' || :	