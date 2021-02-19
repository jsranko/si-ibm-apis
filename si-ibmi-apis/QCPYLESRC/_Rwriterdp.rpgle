**FREE

/if not defined(Rwriterd)
  /define Rwriterd
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

dcl-s tRwriterd_Size int(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rwriterd()  Write and Read a Record

dcl-pr Rwriterd like(tRECIO_RIOFB) extproc('_Rwriterd');
  fp like(tRECIO_RFile) value;
  buf pointer value;
  size like(tRwriterd_Size) value;
end-pr;
