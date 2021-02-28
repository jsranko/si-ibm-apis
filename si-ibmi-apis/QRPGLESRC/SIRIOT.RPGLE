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
dcl-ds outMyEmp extname('$(LIBRARY)/MY_EMP':*output) qualified inz;
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

  // Test write
  myEmp = SIRIO_open('MY_EMP':'$(LIBRARY)':*omit:cRECIO_READ_WRITE_AND_APPEND);
  outMyEmp.EmpID = 22;
  outMyEmp.Name = 'J Sranko';
  outMyEmp.Salary = 450;
  outMyEmp.Mgrid = 17;
  if not SIRIO_write(myEmp:%addr(outMyEmp):%size(outMyEmp));
    dsply ('not writed');
  endif;

  // Test update
  keyMyEmp.EmpId = 22;
  SIRIO_setLL(myEmp:%addr(keyMyEmp):%size(keyMyEmp));
  if not SIRIO_readNextWithLock(myEmp:%addr(inMyEmp):%size(inMyEmp));
    dsply ('not readed');
  endif;
  if not SIRIO_update(myEmp:%addr(outMyEmp):%size(outMyEmp));
    dsply ('not updated');
  endif;

  // Test delete
  keyMyEmp.EmpId = 22;
  SIRIO_setLL(myEmp:%addr(keyMyEmp):%size(keyMyEmp));
  if not SIRIO_readNextWithLock(myEmp:%addr(inMyEmp):%size(inMyEmp));
    dsply ('not readed');
  endif;
  if not SIRIO_delete(myEmp);
    dsply ('not readed');
  endif;
  SIRIO_close(myEmp);

  return;
end-proc;

//------------------------------------------------------------------------------------------


