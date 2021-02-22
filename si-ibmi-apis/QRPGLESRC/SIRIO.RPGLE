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

 /include qcpylesrc/_ropenp

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
dcl-s output like(tSIRIO);
dcl-s filename char(33);

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

  output = ropen(filename:sOptions);

  return output;
end-proc;
