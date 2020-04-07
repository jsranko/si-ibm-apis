LIBRARY=SIIIA
DBGVIEW=*SOURCE
STGMDL=*INHERIT

OBJECT_DESC='(SI) IBM i Apis Framework'
MAKELOG=makefile.output
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SIIIA_CTLOPT=QCPYLESRC/SICTLOPT.RPGLE

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
	SICJ.srvpgm \
	SIMF.srvpgm \
	SIRE.srvpgm

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
	SIXCPUT.pgm \
	SIREUT.pgm

MSGFS=\
	SIMSGF.messagefile

CMDS=\
	SICRTMSGF.command

EXITPGMS=\
	SIEPCSQ01.exitprogram

SQLS=\
	SIRE.query
	
# Ensure that intermediate files created by rules chains don't get
# automatically deleted
.PRECIOUS: %.srvpgm %.lib %.command %.messagefile %.pgm %.query

all: build

build: build-main build-tests

build-main: $(LIBRARY).lib \
	        $(LIBRARY).bnddir \
	        build-exitprograms \
	        build-srvpgms \
	        build-commands \
	        build-msgfs \
	        build-sqls \
	        RPGINCDIR.envvar

build-msgfs: $(MSGFS)

build-srvpgms: $(SRVPGMS)

build-commands: $(CMDS)

build-exitprograms: $(EXITPGMS)

build-sqls: $(SQLS)

build-tests: $(TESTPGMS)

%.envvar: 
	system -Kp "ADDENVVAR ENVVAR(RPGINCDIR) VALUE('$(ROOT_DIR)') CCSID(*JOB) LEVEL(*SYS) REPLACE(*YES)" && touch $@

%.srvpgm: %.module
	system -Kp "CRTSRVPGM SRVPGM($(LIBRARY)/$(@:%.srvpgm=%)) MODULE($(LIBRARY)/$(@:%.srvpgm=%)) SRCSTMF('$(ROOT_DIR)/QSRVSRC/$*.BND') ACTGRP(*CALLER) OPTION(*DUPPROC) STGMDL($(STGMDL))" && touch $@	
	-system -Kp "ADDBNDDIRE BNDDIR($(LIBRARY)/$(LIBRARY)) OBJ(($(LIBRARY)/$(@:%.srvpgm=%) *SRVPGM *IMMED))" && touch $@ 
	system -Kp "DLTMOD MODULE($(LIBRARY)/$(@:%.srvpgm=%))"

%.lib: 
	(system -Kp "CHKOBJ $* *LIB" || system -Kp "CRTLIB $* TEXT($(OBJECT_DESC))") && touch $@
	touch $(SIIIA_CTLOPT) && printf "**FREE\n\n/if not defined(SICTLOPTP)\n  /define SICTLOPTP\n/else\n  /eof\n/endif\n\nctl-opt bnddir('$(LIBRARY)/SIIIA');" > $(SIIIA_CTLOPT)
	
%.module: QRPGLESRC/%.RPGLE
	system -Kp "CRTRPGMOD MODULE($(LIBRARY)/$*) SRCSTMF('$(ROOT_DIR)/$<') DBGVIEW($(DBGVIEW)) REPLACE(*YES) INCDIR('$(ROOT_DIR)') STGMDL($(STGMDL)) TGTCCSID(*JOB) OUTPUT(*NONE)" && touch $@	
	
%.module: QRPGLESRC/%.SQLRPGLE
	system -Kp "CRTSQLRPGI OBJ($(LIBRARY)/$*) SRCSTMF('$(ROOT_DIR)/$<') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) DBGVIEW($(DBGVIEW)) REPLACE(*YES) COMPILEOPT('INCDIR(''$(ROOT_DIR)'') OUTPUT(*NONE) TGTCCSID(*JOB) STGMDL($(STGMDL))')" && touch $@
	
%.bnddir: $(LIBRARY).lib
	(system -Kp "CHKOBJ OBJ($(LIBRARY)/$*) OBJTYPE(*BNDDIR)" || system -Kp "CRTBNDDIR BNDDIR($(LIBRARY)/$*) TEXT($(OBJECT_DESC))") && touch $@	
	
%.pgm: QRPGLESRC/%.SQLRPGLE
	system "CRTSQLRPGI OBJ($(LIBRARY)/$*) SRCSTMF('$(ROOT_DIR)/$<') OBJTYPE(*PGM) DBGVIEW($(DBGVIEW)) RPGPPOPT(*LVL2) REPLACE(*YES) COMPILEOPT('INCDIR(''$(ROOT_DIR)'') TGTCCSID(*JOB) DFTACTGRP(*NO) ACTGRP(*NEW) OUTPUT(*NONE)')"  && touch $@

%.pgm: QRPGLESRC/%.RPGLE
	system -Kp "CRTBNDRPG PGM($(LIBRARY)/$*) SRCSTMF('$(ROOT_DIR)/$<') DFTACTGRP(*NO) ACTGRP(*NEW) DBGVIEW($(DBGVIEW)) REPLACE(*YES) INCDIR('$(ROOT_DIR)') TGTCCSID(*JOB) OUTPUT(*NONE)" && touch $@
		
%.messagefile: QMSGFSRC/%.msgf
	system -Kp "$(LIBRARY)/SICRTMSGF SRCSTMF('$(ROOT_DIR)/$<')" && touch $@ || rm $@
	
%.command: QCMDSRC/%.cmd %.pgm
	system -Kp "CRTCMD CMD($(LIBRARY)/$*) PGM($(LIBRARY)/$*) SRCSTMF('$(ROOT_DIR)/$<') REPLACE(*YES)" && touch $@
	
%.exitprogram: %.pgm
	system -Kp "ADDEXITPGM EXITPNT(QIBM_QCA_RTV_COMMAND) FORMAT(RTVC0100) PGMNBR(19820622) PGM($(LIBRARY)/$*) PGMDTA(*JOB 30 'CRTSQLRPGIQSYS      *BEFORE   ') REPLACE(*YES)"

%.query: QSQLSRC/%.SQL 
	sed 's/$$(LIBRARY)/$(LIBRARY)/g' $< > $*.query
	system -Kp "RUNSQLSTM SRCSTMF('$(ROOT_DIR)/$@') COMMIT(*NONE)"	

clean:
	rm -f *.lib *.pgm *.srvpgm *.module *.output *.bnddir
	system -Kp 'DLTLIB $(LIBRARY)' || :	
