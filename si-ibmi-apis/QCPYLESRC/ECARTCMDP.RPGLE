000100200327**FREE
000101200327/if not defined(ECARTCMDP)
000102200327/define ECARTCMDP
000103200327/else
000104200327/eof
000105200327/endif
000106190313
000108200327//==========================================================================================
000109200327//             Constants
000110200327//==========================================================================================
000111190313
000112200327dcl-c cECARTCMD_SUCCESSFUL const(0);
000118190313
000119200327//==========================================================================================
000120200327//             Templates
000121200327//==========================================================================================
000122200327dcl-s tECARTCMD_ExitPointName char(20) template;
000123200327dcl-s tECARTCMD_ExitPointFormatName char(8) template;
000124200327dcl-s tECARTCMD_CommandName char(10) template;
000125200327dcl-s tECARTCMD_LibraryName char(10) template;
000126200327dcl-s tECARTCMD_Reserved2 char(2) template;
000127200327dcl-s tECARTCMD_Reserved1 char(1) template;
000128200327dcl-s tECARTCMD_BeforeOrAfterIndicator char(2) template;
000129200327dcl-s tECARTCMD_OffsetToOriginalCommandString int(10) template;
000130200327dcl-s tECARTCMD_LengthOfOriginalCommandString int(10) template;
000131200327dcl-s tECARTCMD_OffsetToReplacementCommandString int(10) template;
000132200327dcl-s tECARTCMD_LengthOfReplacementCommandString int(10) template;
000133200327dcl-s tECARTCMD_OffsetToProxyChain int(10) template;
000134200327dcl-s tECARTCMD_NumberOfEntriesInProxyChain int(10) template;
000135200327dcl-s tECARTCMD_Data char(32000) template;
000136200327
000137200327dcl-ds tECARTCMD_RTVC0100 qualified template;
000138200327  ExitPointName like(tECARTCMD_ExitPointName);
000139200327  ExitPointFormatName like(tECARTCMD_ExitPointFormatName);
000140200327  CommandName like(tECARTCMD_CommandName);
000141200327  LibraryName like(tECARTCMD_LibraryName);
000142200327  Reserved2 like(tECARTCMD_Reserved2);
000143200327  BeforeOrAfterIndicator like(tECARTCMD_BeforeOrAfterIndicator);
000144200327  Reserved1 like(tECARTCMD_Reserved1);
000145200327  OffsetToOriginalCommandString like(tECARTCMD_OffsetToOriginalCommandString);
000146200327  LengthOfOriginalCommandString like(tECARTCMD_LengthOfOriginalCommandString);
000147200327  OffsetToReplacementCommandString like(tECARTCMD_OffsetToReplacementCommandString);
000148200327  LengthOfReplacementCommandString like(tECARTCMD_LengthOfReplacementCommandString);
000149200327  OffsetToProxyChain like(tECARTCMD_OffsetToProxyChain);
000150200327  NumberOfEntriesInProxyChain like(tECARTCMD_NumberOfEntriesInProxyChain);
000151200327  Data like(tECARTCMD_Data);
000153200327end-ds;
000185190313
000189190228
