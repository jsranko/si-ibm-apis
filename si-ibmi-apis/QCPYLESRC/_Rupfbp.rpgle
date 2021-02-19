**FREE

/if not defined(Rupfb)
  /define Rupfb
/else
  /eof
/endif

/include qcpylesrc,reciop

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rupfb()  Provide Information on Last I/O Operation

dcl-pr Rupfb like(tRECIO_RIOFB) extproc('_Rupfb');
  fp like(tRECIO_RFile) value;
end-pr;
