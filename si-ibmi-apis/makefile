OBJECT_LIBRARY=SIIIA
OBJECT_DESC='(SI) IBM i Apis Framework'
CLLE_DIR=QCLLESRC
CLLE_SRC=$(wildcard $(CLLE_DIR)/*.clle)
RPG_DIR=QRPGLESRC
RPG_SRC=$(wildcard $(RPG_DIR)/*.rpgle)
SQLRPG_SRC=$(wildcard $(RPG_DIR)/*.sqlrpgle)
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

all: $(CLLE_SRC) $(RPG_SRC) $(SQLRPG_SRC)

%.clle:
	system -q "CRTBNDCL PGM($(OBJECT_LIBRARY)/$*) SRCSTMF('$(CLLE_DIR)/$*.clle') REPLACE(*YES) ALWRTVSRC(*YES) DBGVIEW(*ALL) INCDIR('$(ROOT_DIR)')";	
	
%.rpgle:
	system -q "CRTSQLRPGI OBJ($(OBJECT_LIBRARY)/$*) SRCSTMF('$(CLLE_DIR)/$*.rpgle') OBJTYPE(*PGM) RPGPPOPT(*LVL2) DBGVIEW(*SOURCE) COMPILEOPT('INCDIR(''$(ROOT_DIR)'')')"
	
%.sqlrpgle:
	system -q "CRTSQLRPGI OBJ($(OBJECT_LIBRARY)/$*) SRCSTMF('$(CLLE_DIR)/$*.sqlrpgle') OBJTYPE(*PGM) RPGPPOPT(*LVL2) DBGVIEW(*SOURCE) COMPILEOPT('INCDIR(''$(ROOT_DIR)'')')"
	