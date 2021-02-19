**FREE

/if not defined(Rreadf)
  /define Rreadf
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

dcl-s tRreadf_Size int(10) template;
dcl-s tRreadf_Opts int(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rreadf()  Read the First Record

dcl-pr Rreadf like(tRECIO_RIOFB) extproc('_Rreadf');
  fp like(tRECIO_RFile) value;
  buf pointer value;
  size like(tRreadf_Size) value;
  opts like(tRreadf_Opts) value;
end-pr;
