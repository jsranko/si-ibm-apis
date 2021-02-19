**FREE

/if not defined(Rreadindv)
  /define Rreadindv
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

dcl-s tRreadindv_Size int(10) template;
dcl-s tRreadindv_Opts int(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rreadindv()  Read from an Invited Device

dcl-pr Rreadindv like(tRECIO_RIOFB) extproc('_Rreadindv');
  fp like(tRECIO_RFile) value;
  buf pointer value;
  size like(tRreadindv_Size) value;
  opts like(tRreadindv_Opts) value;
end-pr;
