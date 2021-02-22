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

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSIRIO like(tRECIO_RFile) template;
dcl-s tSIRIO_File varchar(10) template;
dcl-s tSIRIO_Library varchar(10) template;
dcl-s tSIRIO_Format varchar(10) template;
dcl-s tSIRIO_Options varchar(256) template;

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
