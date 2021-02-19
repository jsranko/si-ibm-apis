**FREE

/if not defined(Rpgmdev)
  /define Rpgmdev
/else
  /eof
/endif

/include qcpylesrc,reciop

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rfeod()  Force the End-of-Data

dcl-pr Rpgmdev extproc('_Rpgmdev');
  fp like(tRECIO_RFile) value;
  dev pointer value options(*string);
end-pr;
