**FREE

/if not defined(Ropnfbk)
  /define Ropnfbk
/else
  /eof
/endif

/include qcpylesrc,reciop

//==========================================================================================
// Prototypes
//==========================================================================================

// _Ropnfbk()  Obtain Open Feedback Information

dcl-pr Ropnfbk like(tRECIO_XXOPFB) extproc('_Ropnfbk');
  fp like(tRECIO_RFile) value;
end-pr;
