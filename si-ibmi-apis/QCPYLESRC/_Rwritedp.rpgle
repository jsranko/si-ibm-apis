**FREE

/if not defined(Rwritedd)
  /define Rwritedd
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

dcl-s tRwrited_Size int(10) template;
dcl-s tRwrited_Rrn uns(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rwrited()  Write the Next Record

dcl-pr Rwrited like(tRECIO_RIOFB) extproc('_Rwrited');
  fp like(tRECIO_RFile) value;
  buf pointer value;
  size like(tRwrited_Size) value;
  rrn like(tRwrited_Rrn) value;
end-pr;
