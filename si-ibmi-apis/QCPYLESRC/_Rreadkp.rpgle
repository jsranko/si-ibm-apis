**FREE

/if not defined(Rreadk)
  /define Rreadk
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

dcl-s tRreadk_Size int(10) template;
dcl-s tRreadk_Opts int(10) template;
dcl-s tRreadk_KeyLen uns(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rreadk()  Read a Record by Key

dcl-pr Rreadk like(tRECIO_RIOFB) extproc('_Rreadk');
  fp like(tRECIO_RFile) value;
  buf pointer value;
  size like(tRreadk_Size) value;
  opts like(tRreadk_Opts) value;
  key pointer value;
  keyLen like(tRreadk_KeyLen) value;
end-pr;
