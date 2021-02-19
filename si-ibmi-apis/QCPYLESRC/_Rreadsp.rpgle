**FREE

/if not defined(Rreads)
  /define Rreads
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

dcl-s tRreads_Size int(10) template;
dcl-s tRreads_Opts int(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rreads()  Read the Same Record

dcl-pr Rreads like(tRECIO_RIOFB) extproc('_Rreads');
  fp like(tRECIO_RFile) value;
  buf pointer value;
  size like(tRreads_Size) value;
  opts like(tRreads_Opts) value;
end-pr;
