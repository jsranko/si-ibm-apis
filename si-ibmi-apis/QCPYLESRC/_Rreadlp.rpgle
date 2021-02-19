**FREE

/if not defined(RFEODP)
  /define RFEODP
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

dcl-s tRreadl_Size int(10) template;
dcl-s tRreadl_Opts int(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rreadl()  Read the Last Record

dcl-pr Rreadl like(tRECIO_RIOFB) extproc('_Rreadl');
  fp like(tRECIO_RFile) value;
  buf pointer value;
  size like(tRreadl_Size) value;
  opts like(tRreadl_Opts) value;
end-pr;
