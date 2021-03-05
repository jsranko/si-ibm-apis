**FREE

/if not defined(SISCLIP)
  /define SISCLIP
/else
  /eof
/endif



//==========================================================================================
// Constants
//==========================================================================================

dcl-c cSISCLI_NO_COMMIT const(1);


//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSISCLI like(tSISCLI_Def) template;
dcl-s tSISCLI_Environment int(10) template;
dcl-s tSISCLI_ConnectionHandle int(10) template;
dcl-s tSISCLI_ConnectionAttr int(10) template;
dcl-s tSISCLI_Return int(10) template;
dcl-s tSISCLI_Database varchar(50) template;
dcl-s tSISCLI_Option int(10) template;
dcl-s tSISCLI_StatementText varchar(1024) template;
dcl-s tSISCLI_StatementHandle int(10) template;
dcl-s tSISCLI_Statement like(tSISCLI_Statement_Def) template;

dcl-ds tSISCLI_Def qualified template;
  env like(tSISCLI_Environment);
  hdbc like(tSISCLI_ConnectionHandle);
  retCode like(tSISCLI_Return);
  db like(tSISCLI_Database);
end-ds;

dcl-ds tSISCLI_Statement_Def qualified template;
  hstmt like(tSISCLI_StatementHandle);
  text like(tSISCLI_StatementText);
end-ds;

//==========================================================================================
// Prototypes
//==========================================================================================

/if defined(SISCLI)
  /eof
/endif

dcl-pr SISCLI_connect like(tSISCLI) extproc(*dclcase);
  Database like(tSISCLI_Database) value options(*nopass);
end-pr;

dcl-pr SISCLI_disconnect ind extproc(*dclcase);
 SISCLI like(tSISCLI);
end-pr;

dcl-pr SISCLI_setAttrCommit ind extproc(*dclcase);
  SISCLI like(tSISCLI);
  Attr like(tSISCLI_ConnectionAttr) value options(*nopass);
end-pr;

dcl-pr SISCLI_createStatement like(tSISCLI_Statement) extproc(*dclcase);
  SISCLI like(tSISCLI);
  StatementText like(tSISCLI_StatementText) value;
end-pr;
