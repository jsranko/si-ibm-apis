**FREE
//******************************************************************************************
//
//
// Programname    : SIDT
// Programautor   : Sranko Informatik
// Created on     : 20.03.2019
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See QCLLESRC,makesiiia
//
//==========================================================================================

 ctl-opt NoMain bnddir('SIIIA/SIIIA');

//==========================================================================================
// Constants
//==========================================================================================

dcl-c cLIBL const('*LIBL');
dcl-c cFIRST const('*FIRST');

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

 /define SIRIO
 /include qcpylesrc/siriop

 /include qsysinc/qrpglesrc,errno
 /include qcpylesrc/strerrorp
 /include qcpylesrc/_ropenp
 /include qcpylesrc/_rclosep
 /include qcpylesrc/_rreadnp
 /include qcpylesrc/_rlocatep

//==========================================================================================
// Procedures
//==========================================================================================

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_open export;
dcl-pi SIRIO_open like(tSIRIO) extproc(*dclcase);
  File like(tSIRIO_File) const;
  Library like(tSIRIO_Library) const options(*omit:*nopass);
  Format like(tSIRIO_Format) const options(*omit:*nopass);
  Options like(tSIRIO_Options) const options(*nopass);
end-pi;
dcl-s sFile like(tSIRIO_File);
dcl-s sLibrary like(tSIRIO_Library);
dcl-s sFormat like(tSIRIO_Format);
dcl-s sOptions like(tSIRIO_Options);
dcl-s filename char(33);
dcl-ds dsSIRIO likeds(tSIRIO_Def);

  sFile = File;

  if %parms() >= %parmnum(Library);
    if %addr(Library) <> *null;
      sLibrary = Library;
    else;
      sLibrary = cLIBL;
    endif;
  else;
    sLibrary = cLIBL;
  endif;

  if %parms() >= %parmnum(Format);
    if %addr(Format) <> *null;
      sFormat = Format;
    else;
      sFormat = cFIRST;
    endif;
  else;
    sFormat = cFIRST;
  endif;

  if %parms() >= %parmnum(Options);
    if %addr(Options) <> *null;
      sOptions = Options;
    else;
      sOptions = cRECIO_READ_ONLY;
    endif;
  else;
    sOptions = cRECIO_READ_ONLY;
  endif;
  filename = sLibrary + '/' + sFile + '(' + sFormat + ')';

  dsSIRIO.fp = Ropen(filename:sOptions);
  if dsSIRIO.fp = *null;
    dsSIRIO.error = getError(dsSIRIO);
  endif;

  return dsSIRIO;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_close export;
dcl-pi SIRIO_close likeds(tSIRIO_Error) extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pi;
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);
dcl-s output like(tRclose_Return);

  init(SIRIO);

  pSIRIO = %addr(SIRIO);

  output = rclose(dsSIRIO.fp);
  if output <> cRclose_Success;
    dsSIRIO.error = getError(SIRIO);
    return *off;
  endif;

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_readNext export;
dcl-pi SIRIO_readNext likeds(tSIRIO_Error) extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pi;
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  init(SIRIO);

  pSIRIO = %addr(SIRIO);

  dsSIRIO.fb = Rreadn(dsSIRIO.fp:%addr(dsSIRIO.buffer):cSIRIO_BufferSize:cRECIO_DFT);

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_setBOF export;
dcl-pi SIRIO_setBOF likeds(tSIRIO_Error) extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pi;
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  init(SIRIO);

  pSIRIO = %addr(SIRIO);

  dsSIRIO.fb = Rlocate(dsSIRIO.fp:*null:0:cRECIO_START);

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_setGT export;
dcl-pi SIRIO_setGT likeds(tSIRIO_Error) extproc(*dclcase);
  SIRIO like(tSIRIO);
  Key like(tSIRIO_Key);
  KeyLength like(tSIRIO_KeyLength);
end-pi;
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  init(SIRIO);

  pSIRIO = %addr(SIRIO);

  dsSIRIO.fb = Rlocate(dsSIRIO.fp:Key:KeyLength:cRECIO_KEY_GT);

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_setLL export;
dcl-pi SIRIO_setLL likeds(tSIRIO_Error) extproc(*dclcase);
  SIRIO like(tSIRIO);
  Key like(tSIRIO_Key);
  KeyLength like(tSIRIO_KeyLength);
end-pi;
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  init(SIRIO);

  pSIRIO = %addr(SIRIO);

  dsSIRIO.fb = Rlocate(dsSIRIO.fp:Key:KeyLength:cRECIO_KEY_LT);

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SIRIO_setEOF export;
dcl-pi SIRIO_setEOF likeds(tSIRIO_Error) extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pi;
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  init(SIRIO);

  pSIRIO = %addr(SIRIO);

  dsSIRIO.fb = Rlocate(dsSIRIO.fp:*null:0:cRECIO_END);

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc init;
dcl-pi init;
  SIRIO like(tSIRIO);
end-pi;
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  init(SIRIO);

  pSIRIO = %addr(SIRIO);
  clear dsSIRIO.error;

  return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc getError;
dcl-pi getError likeds(tSIRIO_Error);
  SIRIO like(tSIRIO);
end-pi;
dcl-s errno int(10) BASED(pErrno);
dcl-ds output likeds(tSIRIO_Error);
dcl-ds dsSIRIO likeds(tSIRIO_Def) based(pSIRIO);

  pSIRIO = %addr(SIRIO);

  pErrno = getErrnoPtr();
  output.Nummer = errno;
  output.Text = %str(strerror(errno));

  return output;
end-proc;
