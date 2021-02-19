**FREE

/if not defined(RIOFBKP)
  /define RIOFBKP
/else
  /eof
/endif

/include qcpylesrc,reciop

//==========================================================================================
// Prototypes
//==========================================================================================

// _Riofbk()  Obtain I/O Feedback Information

dcl-pr Riofbk extproc('_Riofbk');
  fp like(tRECIO_RFile) value;
end-pr;
