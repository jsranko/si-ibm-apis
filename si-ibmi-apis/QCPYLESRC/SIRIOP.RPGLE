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
dcl-s tSIRIO_Mode varchar(256) template;
dcl-s tSIRIO_Options int(10) template;
dcl-s tSIRIO_ErrorNummer int(10) template;
dcl-s tSIRIO_ErrorText varchar(256) template;
dcl-s tSIRIO_Buffer pointer template;
dcl-s tSIRIO_BufferLength int(10) template;
dcl-s tSIRIO_Key pointer template;
dcl-s tSIRIO_KeyLength int(10) template;

dcl-ds tSIRIO_Error qualified template;
  Nummer like(tSIRIO_ErrorNummer);
  Text like(tSIRIO_ErrorText);
end-ds;

dcl-ds tSIRIO_Def qualified template;
  fp like(tRECIO_RFile);
  fb like(tRECIO_RIOFB);
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
  Mode like(tSIRIO_Mode) const options(*nopass);
end-pr;

dcl-pr SIRIO_close ind extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pr;

dcl-pr SIRIO_readNext ind extproc(*dclcase);
  SIRIO like(tSIRIO);
  Buffer like(tSIRIO_Buffer) const;
  BufferLength like(tSIRIO_BufferLength) const;
  Options like(tSIRIO_Options) const;
end-pr;

dcl-pr SIRIO_readNextWithLock ind extproc(*dclcase);
  SIRIO like(tSIRIO);
  Buffer like(tSIRIO_Buffer) const;
  BufferLength like(tSIRIO_BufferLength) const;
end-pr;

dcl-pr SIRIO_readNextNoLock ind extproc(*dclcase);
  SIRIO like(tSIRIO);
  Buffer like(tSIRIO_Buffer) const;
  BufferLength like(tSIRIO_BufferLength) const;
end-pr;

dcl-pr SIRIO_setBOF ind extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pr;

dcl-pr SIRIO_setEOF ind extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pr;

dcl-pr SIRIO_setGT ind extproc(*dclcase);
  SIRIO like(tSIRIO);
  Key like(tSIRIO_Key) const;
  KeyLength like(tSIRIO_KeyLength) const;
end-pr;

dcl-pr SIRIO_setLL ind extproc(*dclcase);
  SIRIO like(tSIRIO);
  Key like(tSIRIO_Key) const;
  KeyLength like(tSIRIO_KeyLength) const;
end-pr;

dcl-pr SIRIO_setFIRST ind extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pr;

dcl-pr SIRIO_setLAST ind extproc(*dclcase);
  SIRIO like(tSIRIO);
end-pr;

dcl-pr SIRIO_readPrevious ind extproc(*dclcase);
  SIRIO like(tSIRIO);
  Buffer like(tSIRIO_Buffer) const;
  BufferLength like(tSIRIO_BufferLength) const;
end-pr;

dcl-pr SIRIO_readPreviousWithLock ind extproc(*dclcase);
  SIRIO like(tSIRIO);
  Buffer like(tSIRIO_Buffer) const;
  BufferLength like(tSIRIO_BufferLength) const;
end-pr;

dcl-pr SIRIO_readPreviousNoLock ind extproc(*dclcase);
  SIRIO like(tSIRIO);
  Buffer like(tSIRIO_Buffer) const;
  BufferLength like(tSIRIO_BufferLength) const;
end-pr;

dcl-pr SIRIO_isOpen ind extproc(*dclcase);
  dsSIRIO likeds(tSIRIO_Def);
end-pr;
