**FREE

/if not defined(Rformatp)
  /define Rformatp
/else
  /eof
/endif

/include qcpylesrc/reciop

//==========================================================================================
// Constants
//==========================================================================================


//==========================================================================================
// Templates
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rfeov()  Force the End-of-File

dcl-pr Rformat extproc('_Rformat');
  fp pointer value;
  fmt pointer value options(*string);
end-pr;
