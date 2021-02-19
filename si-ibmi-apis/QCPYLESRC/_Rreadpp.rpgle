**FREE

/if not defined(Rreadp)
  /define Rreadp
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

dcl-s tRreadp_Size int(10) template;
dcl-s tRreadp_Opts int(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rreadp()  Read the Previous Record

dcl-pr Rreadp like(tRECIO_RIOFB) extproc('_Rreadp');
  fp like(tRECIO_RFile) value;
  buf pointer value;
  size like(tRreadp_Size) value;
  opts like(tRreadp_Opts) value;
end-pr;
