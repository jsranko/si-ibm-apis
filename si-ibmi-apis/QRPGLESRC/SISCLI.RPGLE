**FREE
//******************************************************************************************
//
//
// Programname    : SISCLI
// Programautor   : Sranko Informatik
// Created on     : 05.03.2021
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See QCLLESRC,makesiiia
//
//==========================================================================================

 ctl-opt NoMain bnddir('$(LIBRARY)/SIIIA');

//==========================================================================================
// Constants
//==========================================================================================

dcl-c cLOCAL const('*LOCAL');

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

/define SISCLI
/include qcpylesrc/sisclip

/include qcpylesrc/sqlclip

//==========================================================================================
// Procedures
//==========================================================================================

//------------------------------------------------------------------------------------------

dcl-proc SISCLI_connect export;
dcl-pi SISCLI_connect like(tSISCLI) extproc(*dclcase);
 Database like(tSISCLI_Database) value options(*nopass);
end-pi;
dcl-s sDatabase like(tSISCLI_Database);
dcl-ds dsSISCLI likeds(tSISCLI_Def);

  if %parms() >= %parmnum(Database);
    sDatabase = Database;
  else;
    sDatabase = cLOCAL;
  endif;

  dsSISCLI.retCode = SqlAllocEnv(dsSISCLI.env);
  dsSISCLI.retCode = SqlAllocConnect(dsSISCLI.env:dsSISCLI.hdbc);
  dsSISCLI.db = sDatabase;
  dsSISCLI.retCode = SQLConnect(dsSISCLI.hdbc
                               :sDatabase
                               :SQL_NTS
                               :*null
                               :SQL_NTS
                               :*null
                               :SQL_NTS
                               );

  return dsSISCLI;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISCLI_disconnect export;
dcl-pi SISCLI_disconnect ind extproc(*dclcase);
 SISCLI like(tSISCLI);
end-pi;
dcl-ds dsSISCLI likeds(tSISCLI_Def) based(pSISCLI);

  pSISCLI = %addr(SISCLI);

  dsSISCLI.retCode = SQLDisconnect(dsSISCLI.hdbc);
  dsSISCLI.retCode = SQLFreeConnect(dsSISCLI.hdbc);
  dsSISCLI.retCode = SQLFreeEnv(dsSISCLI.env);

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISCLI_setAttrCommit export;
dcl-pi SISCLI_setAttrCommit ind extproc(*dclcase);
  SISCLI like(tSISCLI);
  Attr like(tSISCLI_ConnectionAttr) value options(*nopass);
end-pi;
dcl-s sAttr like(tSISCLI_ConnectionAttr);
dcl-ds dsSISCLI likeds(tSISCLI_Def) based(pSISCLI);

  pSISCLI = %addr(SISCLI);

  if %parms() >= %parmnum(Attr);
    sAttr = Attr;
  else;
    sAttr = CLI_TXN_READ_UNCOMMITTED;
  endif;

  dsSISCLI.retCode = setAttr(dsSISCLI:CLI_ATTR_COMMIT:%addr(sAttr));

  return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISCLI_createStatement export;
dcl-pi SISCLI_createStatement like(tSISCLI_Statement) extproc(*dclcase);
  SISCLI like(tSISCLI);
  StatementText like(tSISCLI_StatementText) value;
end-pi;
dcl-ds output likeds(tSISCLI_Statement_Def);
dcl-ds dsSISCLI likeds(tSISCLI_Def) based(pSISCLI);

  pSISCLI = %addr(SISCLI);

  dsSISCLI.retCode = SQLAllocStmt(dsSISCLI.hdbc:output.hstmt);
  output.text =  StatementText;

  return output;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc setAttr;
dcl-pi setAttr like(tSISCLI_Return);
  dsSISCLI likeds(tSISCLI_Def);
  Option like(tSISCLI_Option) value;
  Value like(SQLPOINTER) value;
end-pi;

  return SQLSetConnectOption(dsSISCLI.hdbc:Option:Value);
end-proc;
