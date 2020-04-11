LIBRARY=SIIIA
DBGVIEW=*SOURCE
STGMDL=*INHERIT

OBJECT_DESC='(SI) IBM i Apis Framework'
MAKELOG=makefile.output
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SIIIA_CTLOPT=QCPYLESRC/SICTLOPT.RPGLE
DIR_CL=QCLLESRC
DIR_CMD=QCMDSRC
DIR_CPY=QCPYLESRC
DIR_RPG=QRPGLESRC
DIR_SQL=QSQLSRC
DIR_SRV=QSRVSRC
DIR_MSGF=QMSGFSRC
DIR_JAVA=src/java
EXT_CPYSRC=RPGLE
EXT_MSGF=MSGF
EXT_CMD=CMD
EXT_CL=CLLE
EXT_SQL=SQL
EXT_JAVA=java

SRVPGMS=\
	$(patsubst %.RPGLE,%.srvpgm,$(shell grep -il "nomain" QRPGLESRC/*.*))

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
	$(patsubst %.$(EXT_MSGF),%.messagefile,$(notdir $(wildcard $(DIR_MSGF)/*.$(EXT_MSGF))))

CMDS=\
	$(patsubst %.$(EXT_CMD),%.command,$(wildcard $(DIR_CMD)/*.$(EXT_CMD)))

EXITPGMS=\
	SIEPCSQ01.exitprogram

SQLS=\
	$(patsubst %.$(EXT_SQL),%.query,$(wildcard $(DIR_SQL)/*.$(EXT_SQL)))

CLS:=\
	$(patsubst %.$(EXT_CL),%.clpgm,$(wildcard $(DIR_CL)/*.$(EXT_CL)))

CPYSRCS:=\
	$(patsubst %.$(EXT_CPYSRC),%.cpysrc,$(wildcard $(DIR_CPY)/*.$(EXT_CPYSRC)))

SRCFILES=\
	$(DIR_CL).srcpf \
	$(DIR_CMD).srcpf \
	$(DIR_CPY).srcpf \
	$(DIR_RPG).srcpf \
	$(DIR_SQL).srcpf \
	$(DIR_SRV).srcpf \
	$(DIR_MSGF).srcpf	

JAVAS=\
	$(patsubst %.$(EXT_JAVA),%.jar,$(wildcard $(DIR_JAVA)/*.$(EXT_JAVA)))
	
# Ensure that intermediate files created by rules chains don't get
# automatically deleted
.PRECIOUS: %.srvpgm %.lib %.command %.messagefile %.pgm %.query %.srcpf %.clpgm %.jar

all: build

build: build-main build-tests

build-main: $(LIBRARY).lib \
			create-srcfiles \
	        $(LIBRARY).bnddir \
	        build-exitprograms \
	        build-srvpgms \
	        build-cls \
	        build-tests \
	        build-commands \
	        build-java \
	        build-sqls \
	        copy-cpysrc \
	        RPGINCDIR.envvar \
	        build-msgfs	        

build-msgfs: $(MSGFS)

build-srvpgms: $(SRVPGMS)

build-commands: $(CMDS)

build-exitprograms: $(EXITPGMS)

build-sqls: $(SQLS)

build-tests: $(TESTPGMS)

create-srcfiles: $(SRCFILES)

build-cls: $(CLS)

copy-cpysrc: $(CPYSRCS)

build-java: $(JAVAS)

%.envvar: 
	system -Kp "ADDENVVAR ENVVAR(RPGINCDIR) VALUE('$(ROOT_DIR)') CCSID(*JOB) LEVEL(*SYS) REPLACE(*YES)" && \
	touch $@

%.srvpgm: %.module
	$(call copy_to_srcpf,$(ROOT_DIR)/$(DIR_SRV)/$*.BND,$(LIBRARY),$(DIR_SRV),$*)
	system -Kp "CRTSRVPGM SRVPGM($(LIBRARY)/$(@:%.srvpgm=%)) MODULE($(LIBRARY)/$(@:%.srvpgm=%)) SRCSTMF('$(ROOT_DIR)/$(DIR_SRV)/$*.BND') ACTGRP(*CALLER) OPTION(*DUPPROC) STGMDL($(STGMDL))" && \
	touch $@	
	-system -Kp "ADDBNDDIRE BNDDIR($(LIBRARY)/$(LIBRARY)) OBJ(($(LIBRARY)/$(@:%.srvpgm=%) *SRVPGM *IMMED))" && \
	touch $@ 
	system -Kp "DLTMOD MODULE($(LIBRARY)/$(@:%.srvpgm=%))"

%.lib: 
	(system -Kp "CHKOBJ $* *LIB" || system -Kp "CRTLIB $* TEXT($(OBJECT_DESC))") && \
	touch $@
	touch $(SIIIA_CTLOPT) && printf "**FREE\n\n/if not defined(SICTLOPTP)\n  /define SICTLOPTP\n/else\n  /eof\n/endif\n\nctl-opt bnddir('$(LIBRARY)/SIIIA');" > $(SIIIA_CTLOPT)
	
%.module: %.RPGLE
	$(call copy_to_srcpf,$(ROOT_DIR)/$<,$(LIBRARY),$(DIR_RPG),$*)
	system -Kp "CRTRPGMOD MODULE($(LIBRARY)/$*) SRCSTMF('$(ROOT_DIR)/$<') DBGVIEW($(DBGVIEW)) REPLACE(*YES) INCDIR('$(ROOT_DIR)') STGMDL($(STGMDL)) TGTCCSID(*JOB) OUTPUT(*NONE)"  && \
	touch $@	
	
%.module: %.SQLRPGLE
	$(call copy_to_srcpf,$(ROOT_DIR)/$<,$(LIBRARY),$(DIR_RPG),$*)
	system -Kp "CRTSQLRPGI OBJ($(LIBRARY)/$*) SRCSTMF('$(ROOT_DIR)/$<') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) DBGVIEW($(DBGVIEW)) REPLACE(*YES) COMPILEOPT('INCDIR(''$(ROOT_DIR)'') OUTPUT(*NONE) TGTCCSID(*JOB) STGMDL($(STGMDL))')" && \
	touch $@
	
%.bnddir: $(LIBRARY).lib
	(system -Kp "CHKOBJ OBJ($(LIBRARY)/$*) OBJTYPE(*BNDDIR)" || system -Kp "CRTBNDDIR BNDDIR($(LIBRARY)/$*) TEXT($(OBJECT_DESC))") && touch $@	
	
%.pgm: %.SQLRPGLE
	$(call copy_to_srcpf,$(ROOT_DIR)/$<,$(LIBRARY),$(DIR_RPG),$*)
	system "CRTSQLRPGI OBJ($(LIBRARY)/$*) SRCSTMF('$(ROOT_DIR)/$<') OBJTYPE(*PGM) DBGVIEW($(DBGVIEW)) RPGPPOPT(*LVL2) REPLACE(*YES) COMPILEOPT('INCDIR(''$(ROOT_DIR)'') TGTCCSID(*JOB) DFTACTGRP(*NO) ACTGRP(*NEW) OUTPUT(*NONE)')"  && \
	touch $@

%.pgm: %.RPGLE
	$(call copy_to_srcpf,$(ROOT_DIR)/$<,$(LIBRARY),$(DIR_RPG),$*)
	system -Kp "CRTBNDRPG PGM($(LIBRARY)/$*) SRCSTMF('$(ROOT_DIR)/$<') DFTACTGRP(*NO) ACTGRP(*NEW) DBGVIEW($(DBGVIEW)) REPLACE(*YES) INCDIR('$(ROOT_DIR)') TGTCCSID(*JOB) OUTPUT(*NONE)" && \
	touch $@
		
%.messagefile: $(DIR_MSGF)/%.$(EXT_MSGF)
	$(call copy_to_srcpf,$(ROOT_DIR)/$<,$(LIBRARY),$(DIR_MSGF),$*)
	system -Kp "$(LIBRARY)/SICRTMSGF SRCSTMF('$(ROOT_DIR)/$<')" && touch $@ || rm $@
	
%.command: %.$(EXT_CMD)
	$(call copy_to_srcpf,$(ROOT_DIR)/$<,$(LIBRARY),$(DIR_CMD),$(notdir $*))
	system -Kp "CRTCMD CMD($(LIBRARY)/$(notdir $*)) PGM($(LIBRARY)/$(notdir $*)) SRCSTMF('$(ROOT_DIR)/$<') REPLACE(*YES)" && \
	touch $@
	
%.exitprogram: %.pgm
	system -Kp "ADDEXITPGM EXITPNT(QIBM_QCA_RTV_COMMAND) FORMAT(RTVC0100) PGMNBR(19820622) PGM($(LIBRARY)/$*) PGMDTA(*JOB 30 'CRTSQLRPGIQSYS      *BEFORE   ') REPLACE(*YES)" && \
	touch $@

%.query: %.$(EXT_SQL) 
	# echo "$$@=$@\n $$%=$%\n $$<=$<\n $$?=$?\n $$^=$^\n $$+=$+\n $$|=$|\n $$*=$*\n" 
	sed 's/$$(LIBRARY)/$(LIBRARY)/g; s/$$(ROOT_DIR)/$(subst /,\/,$(ROOT_DIR))/g' $< > $@
	$(call copy_to_srcpf,$(ROOT_DIR)/$*.query,$(LIBRARY),$(DIR_SQL),$(notdir $*))
	system -Kp "RUNSQLSTM SRCSTMF('$(ROOT_DIR)/$@') COMMIT(*NONE)"	

%.srcpf: $(LIBRARY).lib
	system -Kp "CRTSRCPF FILE($(LIBRARY)/$*) RCDLEN(240) MBR(*NONE) TEXT('just for read-only')" && \
	touch $@
	
%.clpgm: %.$(EXT_CL)
	$(call copy_to_srcpf,$(ROOT_DIR)/$<,$(LIBRARY),$(DIR_CL),$(notdir $*))
	system -kp "CRTBNDCL PGM($(LIBRARY)/$(notdir $*)) SRCSTMF('$(ROOT_DIR)/$<') DFTACTGRP(*NO) ACTGRP(*STGMDL) STGMDL(*SNGLVL) OUTPUT(*NONE) REPLACE(*YES) DBGVIEW($(DBGVIEW))" && \
	touch $@      

%.cpysrc: %.$(EXT_CPYSRC) $(DIR_CPY).srcpf
	$(call copy_to_srcpf,$(ROOT_DIR)/$<,$(LIBRARY),$(DIR_CPY),$(notdir $*)) && \
	touch $@

%.jar: %.$(EXT_JAVA)
	javac $< && \
	jar -cvf $*.jar $*.class && \
	rm $*.class

clean:
	rm -f *.lib *.pgm *.srvpgm *.module *.output *.bnddir *.envvar *.messagefile *.command *.exitprogram *.query *.srcpf *.clpgm *.jar
	system -Kp 'DLTLIB $(LIBRARY)' || :	

define copy_to_srcpf
	system -Kp "CPYFRMSTMF FROMSTMF('$(1)') TOMBR('/QSYS.LIB/$(2).LIB/$(3).FILE/$(4).MBR') MBROPT(*REPLACE) STMFCCSID(*STMF) DBFCCSID(*FILE) ENDLINFMT(*ALL)" && \
	system -Kp "CHGPFM FILE($(2)/$(3)) MBR($(4)) SRCTYPE($(subst .,,$(suffix $(1)))) TEXT('just for read-only')"
endef	