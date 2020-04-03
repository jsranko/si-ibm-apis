LIBRARY=SIIIA
DBGVIEW=*SOURCE
STGMDL=*INHERIT

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
	SIJI.srvpgm \
	SICJ.srvpgm

TESTPGMS=\
	SICJUT.pgm \
	SICURLUT.pgm \
	SIDBGAUT.pgm \
	SIDTUT.pgm \
	SIHASHUT.pgm \
	SIISFUT.pgm \
	SIJIUT.pgm \
	SIJLUT.pgm \
	SIQSHLOGUT.pgm \
	SISTRUT.pgm \
	SIUUIDUT.pgm \
	SIXCPUT.pgm

MSGFS=\
	SIMSGF.messagefile

CMDS=\
	SICRTMSGF.command

# Ensure that intermediate files created by rules chains don't get
# automatically deleted
.PRECIOUS: %.srvpgm %.lib %.command %.messagefile

all: build

# build: build-main

build: build-main build-tests

build-main: $(LIBRARY).lib $(LIBRARY).bnddir $(SRVPGMS) $(MSGFS) RPGINCDIR.envvar

build-tests: $(TESTPGMS)

%.envvar: 
	system -q "ADDENVVAR ENVVAR(RPGINCDIR) VALUE('$(ROOT_DIR)') CCSID(*JOB) LEVEL(*SYS) REPLACE(*YES)" && touch $@

%.srvpgm: %.module
	system -q "CRTSRVPGM SRVPGM($(LIBRARY)/$(@:%.srvpgm=%)) MODULE($(LIBRARY)/$(@:%.srvpgm=%)) EXPORT(*ALL) ACTGRP(*CALLER) OPTION(*DUPPROC) STGMDL($(STGMDL))" && touch $@	
	-system -q "ADDBNDDIRE BNDDIR($(LIBRARY)/$(LIBRARY)) OBJ(($(LIBRARY)/$(@:%.srvpgm=%) *SRVPGM *IMMED))" && touch $@ 
	system -q "DLTMOD MODULE($(LIBRARY)/$(@:%.srvpgm=%))"

%.lib:
	(system -q "CHKOBJ $* *LIB" || system -q "CRTLIB $* TEXT($(OBJECT_DESC))") && touch $@
	
%.module: QRPGLESRC/%.RPGLE
	system -q "CRTRPGMOD MODULE($(LIBRARY)/$*) SRCSTMF('$(ROOT_DIR)/$<') DBGVIEW($(DBGVIEW)) REPLACE(*YES) INCDIR('$(ROOT_DIR)') STGMDL($(STGMDL)) TGTCCSID(*JOB)" && touch $@	
	
%.module: QRPGLESRC/%.SQLRPGLE
	system -q "CRTSQLRPGI OBJ($(LIBRARY)/$*) SRCSTMF('$(ROOT_DIR)/$<') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) DBGVIEW($(DBGVIEW)) REPLACE(*YES) COMPILEOPT('INCDIR(''$(ROOT_DIR)'') TGTCCSID(*JOB) STGMDL($(STGMDL))')" && touch $@
	
%.bnddir: $(LIBRARY).lib
	(system -q "CHKOBJ OBJ($(LIBRARY)/$*) OBJTYPE(*BNDDIR)" || system -q "CRTBNDDIR BNDDIR($(LIBRARY)/$*) TEXT($(OBJECT_DESC))") && touch $@	
	
%.pgm: QRPGLESRC/%.SQLRPGLE
	system -q "CRTSQLRPGI OBJ($(LIBRARY)/$*) SRCSTMF('$(ROOT_DIR)/$<') OBJTYPE(*PGM) DBGVIEW($(DBGVIEW)) RPGPPOPT(*LVL2) REPLACE(*YES) COMPILEOPT('INCDIR(''$(ROOT_DIR)'') TGTCCSID(*JOB) DFTACTGRP(*NO) ACTGRP(*NEW)')" && touch $@

%.pgm: QRPGLESRC/%.RPGLE
	system -q "CRTBNDRPG PGM($(LIBRARY)/$*) SRCSTMF('$(ROOT_DIR)/$<') DFTACTGRP(*NO) ACTGRP(*NEW) DBGVIEW($(DBGVIEW)) REPLACE(*YES) INCDIR('$(ROOT_DIR)') TGTCCSID(*JOB)" && touch $@
		
%.messagefile: QMSGFSRC/%.msgf
	system -q "SICRTMSGF SRCSTMF('$(ROOT_DIR)/$<')" && touch $@
	
%.command: QCMDSRC/%.cmd
	system -q "CRTCMD CMD($(LIBRARY)/$*) PGM($(LIBRARY)/$<) SRCSTMF($(ROOT_DIR)/$<) REPLACE(*YES)" && touch $@
			
clean:
	rm -f *.lib *.pgm *.srvpgm *.module *.output *.bnddir
	system -q 'DLTLIB $(LIBRARY)' || :	