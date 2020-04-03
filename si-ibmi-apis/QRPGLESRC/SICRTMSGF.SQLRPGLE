**FREE

//******************************************************************************************
//
//
// Programname    : SICRTMSGF
// Programautor   : Sranko Informatik, Juraj Sranko
// Created on     : 01.20.2020
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// gmake SICRTMSGF.pgm
//
//==========================================================================================

 ctl-opt main(SICRTMSGF) dftactgrp(*no) actgrp(*new);

 /include qcpylesrc/sictlopt

//==========================================================================================
// Templates
//==========================================================================================

dcl-ds tDescription qualified template;
  text char(50);
  sizeInitialStorageSize int(10);
  sizeIncrementStorageSize int(10);
  sizeMaximumIncrements int(10);
  aut char(10);
  ccsid char(11);
end-ds;

dcl-ds tMessage qualified template;
  msgid char(7);
  msg char(132);
  seclvl char(3000);
  sev int(10);
  fmtDataType char(8);
  fmtLength int(10);
  fmtDecimalPositions int(10);
  type char(6);
  len int(10);
  values char(33) dim(20);
  spcvalOriginalFromValue char(33) dim(20);
  spcvalReplacementToValue char(33) dim(20);
  rangeLowerValue char(33);
  rangeUpperValue char(33);
  relRelationOperator char(5);
  relvalue char(33);
  dft char(132);
  dftpgmObject char(10);
  dftpgmLibrary char(10);
  dmplst char(7) dim(20);
  alroptAlertArt char(9);
  alroptressourceNameVariable char(6);
  logprb char(4);
  ccsid char(11);
end-ds;

//==========================================================================================
// Prototypes
//==========================================================================================

/include qcpylesrc/sicrtmsgfp

/include qcpylesrc/sixcpp
/include qcpylesrc/siisfp

exec sql set option commit = *chg;

//==========================================================================================
// Procedures
//==========================================================================================

dcl-proc SICRTMSGF;
dcl-pi SICRTMSGF;
  Streamfile like(tSICRTMSGF_Streamfile) const;
end-pi;
dcl-s StmFile like(tSIISF);

  StmFile = SIISF_newByFileName(%trim(Streamfile));

  if not SIISF_exist(StmFile);
    SIXCP_throwWithMessage('Streamfile ' + %trim(Streamfile) + ' not found');
  endif;
  SIISF_close(StmFile);


  return;
end-proc;

//==========================================================================================
// getDescription
//==========================================================================================

dcl-proc getDescription;
dcl-pi getDescription like(tDescription);
  Streamfile like(tSICRTMSGF_Streamfile);
end-pi;
dcl-s XXxx char(1000);
dcl-ds Desc likeds(tDescription);

  exec sql
       select *
         Into :Desc
         from json_table(GET_CLOB_FROM_FILE(:streamfile) Format JSON,
              'lax $'
              Columns ("text" Char(50),
         "initialStorageSize" Integer Path 'lax $.size.initialStorageSize',
         "incrementStorageSize" Integer Path 'lax $.size.incrementStorageSize',
         "maximumIncrements" Integer Path 'lax $.size.maximumIncrements',
         "aut" Char(10),
         "ccsid" Char(11)
               ) Error On Error
         ) as jsontbl
  ;

  return Desc;
end-proc;

//------------------------------------------------------------------------------------------
