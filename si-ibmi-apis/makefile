LIBRARY=SIIIA
DBGVIEW=*SOURCE
STGMDL=*INHERIT

OBJECT_DESC='(SI) IBM i Apis Framework'
MAKELOG=makefile.output
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SIIIA_CTLOPT=$(DIR_CPY)/SICTLOPT.RPGLE
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
EXT_PGM=RPGLE

SRVPGMS=\
	$(DIR_RPG)/SIUI.srvpgm \
	$(DIR_RPG)/SIXCP.srvpgm \
	$(DIR_RPG)/SIHASH.srvpgm \
	$(DIR_RPG)/SIOD.srvpgm \
	$(DIR_RPG)/SIITR.srvpgm \
	$(DIR_RPG)/SIJL.srvpgm \
	$(DIR_RPG)/SIDT.srvpgm \
	$(DIR_RPG)/SISQL.srvpgm \
	$(DIR_RPG)/SIULC.srvpgm \
	$(DIR_RPG)/SIPATH.srvpgm \
	$(DIR_RPG)/SIDBGA.srvpgm \
	$(DIR_RPG)/SIUUID.srvpgm \
	$(DIR_RPG)/SISTR.srvpgm \
	$(DIR_RPG)/SIQSH.srvpgm \
	$(DIR_RPG)/SIQSHLOG.srvpgm \
	$(DIR_RPG)/SICURL.srvpgm \
	$(DIR_RPG)/SIIMF.srvpgm \
	$(DIR_RPG)/SIIOF.srvpgm \
	$(DIR_RPG)/SINL.srvpgm \
	$(DIR_RPG)/SIISF.srvpgm \
	$(DIR_RPG)/SIDIR.srvpgm \
	$(DIR_RPG)/SIJI.srvpgm \
	$(DIR_RPG)/SICJ.srvpgm \
	$(DIR_RPG)/SIMF.srvpgm \
	$(DIR_RPG)/SIRE.srvpgm

PGMS:=\
	$(patsubst %.RPGLE,%.pgm,$(shell grep -il " main" $(DIR_RPG)/*.*))

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

build: build-main

build-main: $(LIBRARY).lib \
			create-srcfiles \
	        $(LIBRARY).bnddir \
	        build-exitprograms \
	        RPGINCDIR.envvar \
	        build-srvpgms \
	        build-pgms \	        
	        build-cls \
	        build-commands \
	        build-java \
	        build-sqls \
	        build-msgfs	\	
	        copy-cpysrc         

build-msgfs: $(MSGFS)

build-srvpgms: $(SRVPGMS)

build-commands: $(CMDS)

build-exitprograms: $(EXITPGMS)

build-sqls: $(SQLS)

build-pgms: $(PGMS)

create-srcfiles: $(SRCFILES)

build-cls: $(CLS)

copy-cpysrc: $(CPYSRCS)

build-java: $(JAVAS)

%.envvar: 
	system -Kp "ADDENVVAR ENVVAR(RPGINCDIR) VALUE('$(ROOT_DIR)') CCSID(*JOB) LEVEL(*SYS) REPLACE(*YES)" && \
	touch $@

%.srvpgm: %.module
	$(call copy_to_srcpf,$(ROOT_DIR)/$(DIR_SRV)/$(notdir $*).BND,$(LIBRARY),$(DIR_SRV),$(notdir $*))
	system -Kp "CRTSRVPGM SRVPGM($(LIBRARY)/$(notdir $*)) MODULE($(LIBRARY)/$(notdir $*)) SRCSTMF('$(ROOT_DIR)/$(DIR_SRV)/$(notdir $*).BND') ACTGRP(*CALLER) OPTION(*DUPPROC) STGMDL($(STGMDL))" && \
	touch $@	
	-system -Kp "ADDBNDDIRE BNDDIR($(LIBRARY)/$(LIBRARY)) OBJ(($(LIBRARY)/$(notdir $*) *SRVPGM *IMMED))" && \
	touch $@ 
	system -Kp "DLTMOD MODULE($(LIBRARY)/$(notdir $*))"

%.lib: 
	(system -Kp "CHKOBJ $* *LIB" || system -Kp "CRTLIB $* TEXT($(OBJECT_DESC))") && \
	touch $@
	touch $(SIIIA_CTLOPT) && printf "**FREE\n\n/if not defined(SICTLOPTP)\n  /define SICTLOPTP\n/else\n  /eof\n/endif\n\nctl-opt bnddir('$(LIBRARY)/SIIIA');" > $(SIIIA_CTLOPT)
	
%.module: %.RPGLE
	$(call copy_to_srcpf,$(ROOT_DIR)/$<,$(LIBRARY),$(DIR_RPG),$(notdir $*))
	system -Kp "CRTRPGMOD MODULE($(LIBRARY)/$(notdir $*)) SRCSTMF('$(ROOT_DIR)/$<') DBGVIEW($(DBGVIEW)) REPLACE(*YES) INCDIR('$(ROOT_DIR)') STGMDL($(STGMDL)) TGTCCSID(*JOB) OUTPUT(*NONE)"  && \
	touch $@	
	
%.module: %.SQLRPGLE
	$(call copy_to_srcpf,$(ROOT_DIR)/$<,$(LIBRARY),$(DIR_RPG),$(notdir $*))
	system -Kp "CRTSQLRPGI OBJ($(LIBRARY)/$(notdir $*)) SRCSTMF('$(ROOT_DIR)/$<') OBJTYPE(*MODULE) RPGPPOPT(*LVL2) DBGVIEW($(DBGVIEW)) REPLACE(*YES) COMPILEOPT('INCDIR(''$(ROOT_DIR)'') OUTPUT(*NONE) TGTCCSID(*JOB) STGMDL($(STGMDL))')" && \
	touch $@
	
%.bnddir: $(LIBRARY).lib
	(system -Kp "CHKOBJ OBJ($(LIBRARY)/$*) OBJTYPE(*BNDDIR)" || system -Kp "CRTBNDDIR BNDDIR($(LIBRARY)/$*) TEXT($(OBJECT_DESC))") && touch $@	
	
%.pgm: %.SQLRPGLE
	$(call copy_to_srcpf,$(ROOT_DIR)/$<,$(LIBRARY),$(DIR_RPG),$(notdir $*))
	system "CRTSQLRPGI OBJ($(LIBRARY)/$(notdir $*)) SRCSTMF('$(ROOT_DIR)/$<') OBJTYPE(*PGM) DBGVIEW($(DBGVIEW)) RPGPPOPT(*LVL2) REPLACE(*YES) COMPILEOPT('INCDIR(''$(ROOT_DIR)'') TGTCCSID(*JOB) DFTACTGRP(*NO) ACTGRP(*NEW) OUTPUT(*NONE)')"  && \
	touch $@

%.pgm: %.RPGLE
	$(call copy_to_srcpf,$(ROOT_DIR)/$<,$(LIBRARY),$(DIR_RPG),$(notdir $*))
	system -Kp "CRTBNDRPG PGM($(LIBRARY)/$(notdir $*)) SRCSTMF('$(ROOT_DIR)/$<') DFTACTGRP(*NO) ACTGRP(*NEW) DBGVIEW($(DBGVIEW)) REPLACE(*YES) INCDIR('$(ROOT_DIR)') TGTCCSID(*JOB) OUTPUT(*NONE)" && \
	touch $@
		
%.messagefile: $(DIR_MSGF)/%.$(EXT_MSGF)
	$(call copy_to_srcpf,$(ROOT_DIR)/$<,$(LIBRARY),$(DIR_MSGF),$*)
	system -Kp "$(LIBRARY)/SICRTMSGF SRCSTMF('$(ROOT_DIR)/$<')" && touch $@ || rm $@
	
%.command: %.$(EXT_CMD)
	$(call copy_to_srcpf,$(ROOT_DIR)/$<,$(LIBRARY),$(DIR_CMD),$(notdir $*))
	system -Kp "CRTCMD CMD($(LIBRARY)/$(notdir $*)) PGM($(LIBRARY)/$(notdir $*)) SRCSTMF('$(ROOT_DIR)/$<') REPLACE(*YES)" && \
	touch $@
	
%.exitprogram: $(DIR_RPG)/%.pgm
	system -Kp "ADDEXITPGM EXITPNT(QIBM_QCA_RTV_COMMAND) FORMAT(RTVC0100) PGMNBR(19820622) PGM($(LIBRARY)/$*) PGMDTA(*JOB 30 'CRTSQLRPGIQSYS      *BEFORE   ') REPLACE(*YES)" && \
	touch $@

%.query: %.$(EXT_SQL) 
	# echo "$$@=$@\n $$%=$%\n $$<=$<\n $$?=$?\n $$^=$^\n $$+=$+\n $$|=$|\n $$*=$*\n" 
	sed 's/$$(LIBRARY)/$(LIBRARY)/g; s/$$(ROOT_DIR)/$(subst /,\/,$(ROOT_DIR))/g; s/$$(DIR_JAVA)/$(subst /,\/,$(DIR_JAVA))/g' $< > $@
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
	rm -f *.lib \
	      $(DIR_RPG)/*.pgm \
	      $(DIR_RPG)/*.srvpgm \
	      $(DIR_RPG)/*.module \
	      *.output \
	      *.bnddir \
	      *.envvar \
	      $(DIR_MSGF)/*.messagefile \
	      $(DIR_CMD)/*.command \
	      *.exitprogram \
	      $(DIR_SQL)/*.query \
	      *.srcpf \
	      $(DIR_CL)/*.clpgm \
	      *.jar \
	      $(DIR_CPY)/*.cpysrc
	system -Kp 'DLTLIB $(LIBRARY)' || :	

define copy_to_srcpf
	system -Kp "CPYFRMSTMF FROMSTMF('$(1)') TOMBR('/QSYS.LIB/$(2).LIB/$(3).FILE/$(4).MBR') MBROPT(*REPLACE) STMFCCSID(*STMF) DBFCCSID(*FILE) ENDLINFMT(*ALL)" && \
	system -Kp "CHGPFM FILE($(2)/$(3)) MBR($(4)) SRCTYPE($(subst .,,$(suffix $(1)))) TEXT('just for read-only')"
endef	