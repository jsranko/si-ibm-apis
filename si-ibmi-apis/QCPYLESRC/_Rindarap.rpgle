**FREE

/if not defined(Rindarap)
  /define Rindarap
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

// _Rindara()  Set Separate Indicator Area

dcl-pr Rindara extproc('_Rindara');
  fp pointer value;
  indic_buf like(tRECIO_SYSindara) value;
end-pr;
