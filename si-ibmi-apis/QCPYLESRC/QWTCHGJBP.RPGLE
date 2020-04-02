000100191102**FREE
000101200120/if defined(qwtchgjbp)
000102191102/eof
000103191102/endif
000104191102
000105200120/define qwtchgjbp
000106191102
000107191217/include qcpylesrc/qusecp
000108191102
000109191102// -----------------------------------------------------------------------------
000110200120dcl-c cQWTCHGJB_Format_JOBC0100 const('JOBC0100');
000111200120dcl-c cQWTCHGJB_Format_JOBC0200 const('JOBC0200');
000112200120dcl-c cQWTCHGJB_Format_JOBC0300 const('JOBC0300');
000113200120dcl-c cQWTCHGJB_Format_JOBC0400 const('JOBC0400');
000114200120dcl-c cQWTCHGJB_TypeOfData_Binary const('B');
000115200120dcl-c cQWTCHGJB_TypeOfData_Character const('C');
000116200120dcl-c cQWTCHGJB_Key_BreakMessageHandling const(201);
000117200120dcl-c cQWTCHGJB_Key_CodedCharacterSetID const(302);
000118200120dcl-c cQWTCHGJB_Key_CountryOrRegionID const(303);
000119191102// -----------------------------------------------------------------------------
000120200120dcl-s tQWTCHGJB_CodedCharacterSetID int(10) template;
000121200120dcl-s tQWTCHGJB_QualifiedJobName char(26) template;
000122200120dcl-s tQWTCHGJB_InternalJobIdentifier char(16) template;
000123200120dcl-s tQWTCHGJB_FormatName char(8) template;
000124200120dcl-s tQWTCHGJB_JobChangeInformation char(1) template;
000125200120dcl-s tQWTCHGJB_LengthOfAttributeInformation int(10) template;
000126200120dcl-s tQWTCHGJB_TypeOfData char(1) template;
000127200120dcl-s tQWTCHGJB_LengthOfData int(10) template;
000128200120dcl-s tQWTCHGJB_Data256 char(256) template;
000129200120dcl-s tQWTCHGJB_Data10 char(10) template;
000130200120dcl-s tQWTCHGJB_Reserved1 char(1) template;
000131200120dcl-s tQWTCHGJB_Reserved2 char(2) template;
000132200120dcl-s tQWTCHGJB_Reserved3 char(3) template;
000133200120dcl-s tQWTCHGJB_Key int(10) template;
000134200120dcl-s tQWTCHGJB_NumberOfVariableLengthRecords int(10) template;
000135200120dcl-ds tQWTCHGJB_VariableLengthRecord1 qualified template;
000136200120  NumberOfVariableLengthRecords like(tQWTCHGJB_NumberOfVariableLengthRecords);
000137200120  LengthOfAttributeInformation like(tQWTCHGJB_LengthOfAttributeInformation);
000138200120  Key like(tQWTCHGJB_Key);
000139200120  TypeOfData like(tQWTCHGJB_TypeOfData);
000140200120  Reserved like(tQWTCHGJB_Reserved3);
000141200120  LengthOfData like(tQWTCHGJB_LengthOfData);
000142200120  Data like(tQWTCHGJB_Data256);
000143200120  Reserved2 like(tQWTCHGJB_Reserved1);
000144200120end-ds;
000145200120dcl-ds tQWTCHGJB_VariableLengthRecord2 qualified template;
000146200120  Key like(tQWTCHGJB_Key);
000147200120  Data like(tQWTCHGJB_Data10);
000148200120  Reserved2 like(tQWTCHGJB_Reserved2);
000149200120end-ds;
000210191102// -----------------------------------------------------------------------------
000211200120dcl-pr ChangeJob extpgm('QWTCHGJB');
000212200120  QualifiedJobName like(tQWTCHGJB_QualifiedJobName) const;
000213200120  InternalJobIdentifier like(tQWTCHGJB_InternalJobIdentifier) const;
000214200120  FormatName like(tQWTCHGJB_FormatName) const;
000215200120  JobChangeInformation like(tQWTCHGJB_JobChangeInformation) const;
000217191102  ErrorCode like(tQUSEC);
000218191102end-pr;
