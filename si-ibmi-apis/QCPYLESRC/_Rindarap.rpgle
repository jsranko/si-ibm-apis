**FREE

/if not defined(RINDARA)
  /define RINDARA
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


//==========================================================================================
// Prototypes
//==========================================================================================

// _Rindara()  Set Separate Indicator Area

dcl-pr Rindara extproc('_Rindara');
  fp like(tRECIO_RFile) value;
  indic_buf like(tRECIO_SYSindara) value;
end-pr;