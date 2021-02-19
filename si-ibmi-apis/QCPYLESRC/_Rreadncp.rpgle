**FREE

/if not defined(Rreadnc)
  /define Rreadnc
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

dcl-s tRreadnc_Size int(10) template;
dcl-s tRreadnc_Opts int(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rreadnc()  Read the Next Changed Record in a Subfile

dcl-pr Rreadnc like(tRECIO_RIOFB) extproc('_Rreadnc');
  fp like(tRECIO_RFile) value;
  buf pointer value;
  size like(tRreadnc_Size) value;
  opts like(tRreadnc_Opts) value;
end-pr;
