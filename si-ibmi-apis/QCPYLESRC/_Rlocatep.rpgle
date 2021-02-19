**FREE

/if not defined(Rlocate)
  /define Rlocate
/else
  /eof
/endif

/include qcpylesrc,reciop

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tRlocate_KeyLen int(10) template;
dcl-s tRlocate_Opts int(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rlocate()  Position a Record

dcl-pr Rlocate extproc('_Rlocate');
  fp like(tRECIO_RFile) value;
  key pointer value options(*string);
  keyLenOrRrn like(tRlocate_KeyLen) value;
  opts like(tRlocate_KeyLen) value;
end-pr;
