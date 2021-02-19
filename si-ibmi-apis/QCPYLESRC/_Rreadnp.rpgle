**FREE

/if not defined(Rreadn)
  /define Rreadn
/else
  /eof
/endif

/include qcpylesrc,reciop

//==========================================================================================
// Constants
//==========================================================================================


//==========================================================================================
// Templates
//==========================================================================================

dcl-s tRreadn_Size int(10) template;
dcl-s tRreadn_Opts int(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rreadn()  Read the Next Record

dcl-pr Rreadn like(tRECIO_RIOFB) extproc('_Rreadn');
  fp like(tRECIO_RFile) value;
  buf pointer value;
  size like(tRreadn_Size) value;
  opts like(tRreadn_Opts) value;
end-pr;
