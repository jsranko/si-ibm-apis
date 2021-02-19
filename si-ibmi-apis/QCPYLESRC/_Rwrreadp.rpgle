**FREE

/if not defined(Rwrread)
  /define Rwrread
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

dcl-s tRwrread_Size int(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rwrread()  Write and Read a Record (separate buffers)

dcl-pr Rwrread like(tRECIO_RIOFB) extproc('_Rwrread');
  fp like(tRECIO_RFile) value;
  inBuf pointer value;
  inBufSize like(tRwrread_Size) value;
  outBuf pointer value;
  outBufSize like(tRwrread_Size) value;
end-pr;
