**FREE

/if not defined(ROPENP)
  /define ROPENP
/else
  /eof
/endif

/include qcpylesrc,reciop

//==========================================================================================
// Prototypes
//==========================================================================================

// _Ropen()  Open a Record File for I/O Operations
dcl-pr Ropen like(tRECIO_RFile) extproc('_Ropen');
  filename pointer value options(*string);
  mode pointer value options(*string);
end-pr;
