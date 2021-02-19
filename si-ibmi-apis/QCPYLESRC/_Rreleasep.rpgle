**FREE

/if not defined(Rrelease)
  /define Rrelease
/else
  /eof
/endif

/include qcpylesrc,reciop

//==========================================================================================
// Constants
//==========================================================================================

dcl-c tRrelease_Successful const(1);
dcl-c tRrelease_Unsuccessful const(0);

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tRrelease_Dev char(10) template;
dcl-s tRrelease_Return int(10) template;

//==========================================================================================
// Prototypes
//==========================================================================================

// _Rrelease()  Release a Program Device

dcl-pr Rrelease like(tRrelease_Return) extproc('_Rrelease');
  fp like(tRECIO_RFile) value;
  dev like(tRrelease_Dev) value;
end-pr;
