**FREE

///if defined(SIMFP)
//  /define SIMFP
///else
//  /eof
///endif

/include qcpylesrc/siitrp

// -----------------------------------------------------------------------------
dcl-s tSIMF like(tSIMF_Def) template;
dcl-s tSIMF_List like(tSIITR) template;
dcl-s tSIMF_File char(10) template;
dcl-s tSIMF_Library char(10) template;
dcl-s tSIMF_Streamfile char(512) template;
dcl-s tSIMF_Text char(50) template;
dcl-s tSIMF_SizeInitialStorageSize int(10) template;
dcl-s tSIMF_SizeIncrementStorageSize int(10) template;
dcl-s tSIMF_SizeMaximumIncrements char(6) template;
dcl-s tSIMF_Aut char(10) template;
dcl-s tSIMF_Ccsid char(11) template;
dcl-ds tSIMF_Description qualified template;
  text like(tSIMF_Text);
  sizeInitialStorageSize like(tSIMF_SizeInitialStorageSize);
  sizeIncrementStorageSize like(tSIMF_SizeIncrementStorageSize);
  sizeMaximumIncrements like(tSIMF_SizeMaximumIncrements);
  aut like(tSIMF_Aut);
  ccsid like(tSIMF_Ccsid);
end-ds;
dcl-ds tSIMF_Message qualified template;
  msgid char(7);
  msg char(132);
  seclvl char(3000);
  sev int(10);
  fmtDataType char(8);
  fmtLength int(10);
  fmtDecimalPositions int(10);
  type char(6);
  lenLength char(6);
  lenDecimalPositions int(10);
  values char(33) dim(20);
  spcvalOriginalFromValue char(33) dim(20);
  spcvalReplacementToValue char(33) dim(20);
  rangeLowerValue char(33);
  rangeUpperValue char(33);
  relRelationOperator char(5);
  relValue char(33);
  dft char(132);
  dftpgmObject char(10);
  dftpgmLibrary char(10);
  dmplst char(7) dim(20);
  alroptAlertArt char(9);
  alroptressourceNameVariable char(6);
  logprb char(4);
  ccsid char(11);
end-ds;

dcl-ds tSIMF_Def qualified;
  File like(tSIMF_File);
  Library like(tSIMF_Library);
  Streamfile like(tSIMF_Streamfile);
  Description likeds(tSIMF_Description);
  Messages likeds(tSIMF_Description);
end-ds;

/if defined(SIMF)
  /eof
/endif

//==========================================================================================
// Prototypes
//==========================================================================================

 dcl-pr SIMF_new like(tSIMF) extproc(*dclcase);
   File like(tSIMF_File) const;
   Library like(tSIMF_Library) const;
   Description likeds(tSIMF_Description) options(*nopass);
 end-pr;

 dcl-pr SIMF_createFromFile like(tSIMF) extproc(*dclcase);
   SIMF like(tSIMF);
   Streamfile like(tSIMF_Streamfile) const;
 end-pr;

