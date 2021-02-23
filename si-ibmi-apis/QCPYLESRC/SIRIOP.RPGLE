**FREE

/if not defined(SIRIOP)
  /define SIRIOP
/else
  /eof
/endif

/include qcpylesrc/reciop

//==========================================================================================
// Constants
//==========================================================================================

dcl-c cSIRIO_BufferSize const(32767);
dcl-c cSIRIO_KeySize const(1024);

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSIRIO like(tSIRIO_Def) template;
dcl-s tSIRIO_File varchar(10) template;
dcl-s tSIRIO_Library varchar(10) template;
dcl-s tSIRIO_Format varchar(10) template;
dcl-s tSIRIO_Options varchar(256) template;
dcl-s tSIRIO_ErrorNummer int(10) template;
dcl-s tSIRIO_ErrorText varchar(256) template;
dcl-s tSIRIO_Buffer char(cSIRIO_BufferSize) template ccsid(*hex);
dcl-s tSIRIO_Key char(cSIRIO_KeySize) template ccsid(*hex);
dcl-s tSIRIO_KeyLength int(10) template;

dcl-ds tSIRIO_Error qualified template;
  Nummer like(tSIRIO_ErrorNummer);
  Text like(tSIRIO_ErrorText);
end-ds;

dcl-ds tSIRIO_Def qualified template;
  fp like(tRECIO_RFile);
  fb like(tRECIO_RIOFB);
  buffer like(tSIRIO_Buffer);
  error likeds(tSIRIO_Error);
end-ds;

//==========================================================================================
// Prototypes
//==========================================================================================

/if defined(SIRIO)
  /eof
/endif

dcl-pr SIRIO_open like(tSIRIO) extproc(*dclcase);
  File like(tSIRIO_File) const;
  Library like(tSIRIO_Library) const options(*omit:*nopass);
  Format like(tSIRIO_Format) const options(*omit:*nopass);
  Options like(tSIRIO_Options) const options(*nopass);
end-pr;

dcl-pr SIRIO_close likeds(tSIRIO_Error) extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pr;

dcl-pr SIRIO_readNext likeds(tSIRIO_Error) extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pr;

dcl-pr SIRIO_setBOF likeds(tSIRIO_Error) extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pr;

dcl-pr SIRIO_setEOF likeds(tSIRIO_Error) extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pr;

dcl-pr SIRIO_setGT likeds(tSIRIO_Error) extproc(*dclcase);
  SIRIO like(tSIRIO);
  Key like(tSIRIO_Key);
  KeyLength like(tSIRIO_KeyLength);
end-pr;

dcl-pr SIRIO_setLL likeds(tSIRIO_Error) extproc(*dclcase);
  SIRIO like(tSIRIO);
  Key like(tSIRIO_Key);
  KeyLength like(tSIRIO_KeyLength);
end-pr;
