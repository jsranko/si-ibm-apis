**FREE
//******************************************************************************************
//
//
// Programname    : SIRIOT
// Programautor   : Sranko Informatik
// Created on     : 22.02.2021
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See makefile
//
//==========================================================================================

ctl-opt main(SIRIOT) dftactgrp(*no) actgrp(*new) bnddir('SIIIA/SIIIA');

//==========================================================================================
// Templates
//==========================================================================================

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

/include qcpylesrc/siriop

//==========================================================================================
// Procedures
//==========================================================================================

dcl-proc SIRIOT;
dcl-pi SIRIOT;
end-pi;
dcl-s myEmp like(tSIRIO);
dcl-ds inMyEmp extname('$(LIBRARY)/MY_EMP':*input) qualified inz;
end-ds;
dcl-ds keyMyEmp extname('$(LIBRARY)/MY_EMP':*key) qualified inz;
end-ds;

  myEmp = SIRIO_open('MY_EMP':'$(LIBRARY)');
  SIRIO_readNextWithLock(myEmp:%addr(inMyEmp):%size(inMyEmp));
  SIRIO_readNextWithLock(myEmp:%addr(inMyEmp):%size(inMyEmp));
  SIRIO_readPreviousWithLock(myEmp:%addr(inMyEmp):%size(inMyEmp));
  //SIRIO_setEOF( myEmp );
  //SIRIO_readPreviousWithLock(myEmp:%addr(inMyEmp):%size(inMyEmp));
  keyMyEmp.EmpId = 10;
  SIRIO_setLL(myEmp:%addr(keyMyEmp):%size(keyMyEmp));
  SIRIO_readNextWithLock(myEmp:%addr(inMyEmp):%size(inMyEmp));

  SIRIO_setBOF(myEmp);
  dou SIRIO_isEOF(myEmp);
    SIRIO_readNextNoLock(myEmp:%addr(inMyEmp):%size(inMyEmp));
  enddo;
  SIRIO_close(myEmp);

  return;
end-proc;

//------------------------------------------------------------------------------------------


