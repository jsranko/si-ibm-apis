**FREE

/if not defined(Rreadd)
  /define Rreadd
/else
  /eof
/endif

/include qcpylesrc,reciop


//==========================================================================================
// Templates
//==========================================================================================

dcl-s tRreadd_Size int(10) template;
dcl-s tRreadd_Rrn int(20) template;
dcl-s tRreadd_Opts int(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rreadd()  Read a Record by Relative Record Number

dcl-pr Rreadd like(tRECIO_RIOFB) extproc('_Rreadd');
  fp like(tRECIO_RFile) value;
  buf pointer value;
  size like(tRreadd_Size) value;
  opts like(tRreadd_Opts) value;
  rrn like(tRreadd_Rrn) value;
end-pr;
