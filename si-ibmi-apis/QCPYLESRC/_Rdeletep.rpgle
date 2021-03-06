**FREE

/if not defined(Rdeletep)
  /define Rdeletep
/else
  /eof
/endif

/include qcpylesrc/reciop

//==========================================================================================
// Constants
//==========================================================================================

dcl-c cRdelete_Success const(1);

//==========================================================================================
// Templates
//==========================================================================================

dcl-ds tRdelete_Return likeds(tRECIO_RIOFB) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rdelete() — Delete a Record

dcl-pr Rdelete pointer extproc('_Rdelete');
  fp pointer value;
end-pr;
