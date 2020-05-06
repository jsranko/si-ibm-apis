**FREE
/if not defined(RSLVSPP)
  /define RSLVSPP
/else
  /eof
/endif

//==========================================================================================
//             Templates
//==========================================================================================

dcl-s tRSLVSP_PointerForAddressabilityToObject char(34128) template;
dcl-s tRSLVSP_AuthorityToBeSet char(2) template;

//==========================================================================================
//             Prototypes
//==========================================================================================

dcl-pr ResolveSystemPointer pointer extproc('RSLVSP');
  PointerForAddressabilityToObject like(tRSLVSP_PointerForAddressabilityToObject) value;
  ResolveOptions pointer value options(*string);
  ContextThroughWhichObjectIsToBeLocated pointer value options(*string);
  AuthorityToBeSet like(tRSLVSP_AuthorityToBeSet) value;
end-pr;
