**FREE

/if not defined(Rclosep)
  /define Rclosep
/else
  /eof
/endif

/include qcpylesrc,reciop

//==========================================================================================
// Constants
//==========================================================================================

dcl-c cRclose_Success const(0);

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tRclose_Return int(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rclose()  Close a File

dcl-pr Rclose like(tRclose_Return) extproc('_Rclose');
  fp pointer value;
end-pr;
