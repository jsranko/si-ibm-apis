**FREE
//******************************************************************************************
//
//
// Programname    : SISCLIT
// Programautor   : Sranko Informatik
// Created on     : 05.03.2021
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See QCLLESRC,makesiiia
//
//==========================================================================================

 ctl-opt main(SISCLIT) dftactgrp(*no) actgrp(*new) bnddir('$(LIBRARY)/SIIIA');

//==========================================================================================
// Templates
//==========================================================================================

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

 /include qcpylesrc/sisclip

//==========================================================================================
// Procedures
//==========================================================================================

dcl-proc SISCLIT;
dcl-pi SISCLIT;
end-pi;
dcl-s ptr pointer;
dcl-s stmSelTBL like(tSISCLI_Statement);
dcl-s confWW like(tSISCLI_DBConfig);
dcl-s dbWW like(tSISCLI);
dcl-ds dsFetch extname('SYSTABLES') qualified;
end-ds;

  confWW = SISCLI_crtConfig('W+W');
  SISCLI_setSysNaming(confWW:*on);
  SISCLI_setCommit(confWW:cSISCLI_NO_COMMIT);

  dbWW = SISCLI_connect(*omit:confWW);

  stmSelTBL = SISCLI_crtStatement(dbWW:'select * from systables');
  if not SISCLI_execute(stmSelTBL);

  endif;
  dow not SISCLI_isEOF(stmSelTBL);
    dsFetch = SISCLI_fetch(stmSelTBL);

    ptr = crtBufferForResultSet(stmSelTBL);
  enddo;
  SISCLI_closeStatement(stmSelTBL);

  SISCLI_disconnect(dbWW);

return;

on-exit;
  SISCLI_closeStatement(stmSelTBL);
  SISCLI_disconnect(dbWW);
end-proc;
