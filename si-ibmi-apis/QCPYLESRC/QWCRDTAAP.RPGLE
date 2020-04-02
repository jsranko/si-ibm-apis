000100200127**FREE
000101200127/if not defined(QWCRDTAAP)
000102200127/define QWCRDTAAP
000103200127/else
000104200127/eof
000105200127/endif
000113190309
000114200127/include qcpylesrc/qusecp
000115200127
000116200127//==========================================================================================
000117200127// Constants
000118200127//==========================================================================================
000119200127
000120200127dcl-c cQWCRDTAA_Max_Length const(2000);
000121200127
000122200127//==========================================================================================
000123200127// Templates
000124200127//==========================================================================================
000125190309
000126200127dcl-s tQWCRDTAA_DataAreaName char(10) template;
000127200127dcl-s tQWCRDTAA_DataAreaLibrary char(10) template;
000128200127dcl-s tQWCRDTAA_ReceiverVariable char(2035) template;
000129200127dcl-s tQWCRDTAA_LengthOfReceiverVariable int(10) template;
000130200127dcl-ds tQWCRDTAA_QualifiedDataAreaName qualified template;
000131200127  Name like(tQWCRDTAA_DataAreaName);
000132200127  Library like(tQWCRDTAA_DataAreaLibrary);
000133200127end-ds;
000134200127dcl-s tQWCRDTAA_StartingPosition int(10) template;
000135200127dcl-s tQWCRDTAA_LengthOfData int(10) template;
000136200127dcl-s tQWCRDTAA_BytesAvailable int(10) template;
000137200127dcl-s tQWCRDTAA_BytesReturned int(10) template;
000138200127dcl-s tQWCRDTAA_TypeOfValueReturned char(10) template;
000139200127dcl-s tQWCRDTAA_LibraryName char(10) template;
000140200127dcl-s tQWCRDTAA_LengthOfValueReturned int(10) template;
000141200127dcl-s tQWCRDTAA_NumberOfDecimalPositions int(10) template;
000142200127dcl-s tQWCRDTAA_Value char(2000) template;
000143200127dcl-ds tQWCRDTAA_FormatOfDataReturned qualified template;
000144200127  BytesAvailable like(tQWCRDTAA_BytesAvailable);
000145200127  BytesReturned like(tQWCRDTAA_BytesReturned);
000146200127  TypeOfValueReturned like(tQWCRDTAA_TypeOfValueReturned);
000147200127  LibraryName like(tQWCRDTAA_LibraryName);
000148200127  LengthOfValueReturned like(tQWCRDTAA_LengthOfValueReturned);
000149200127  NumberOfDecimalPositions like(tQWCRDTAA_NumberOfDecimalPositions);
000150200127  Value like(tQWCRDTAA_Value);
000151200127end-ds;
000152190309
000153200127//==========================================================================================
000154200127// Prototypes
000155200127//==========================================================================================
000156190309
000157200127dcl-pr RetrieveDataArea extpgm('QWCRDTAA');
000158200127  FormatOfDataReturned like(tQWCRDTAA_FormatOfDataReturned) const;
000159200127  LengthOfReceiverVariable like(tQWCRDTAA_LengthOfReceiverVariable) const;
000160200127  QualifiedDataAreaName like(tQWCRDTAA_QualifiedDataAreaName) const;
000161200127  StartingPosition like(tQWCRDTAA_StartingPosition) const;
000162200127  LengthOfData like(tQWCRDTAA_LengthOfData) const;
000163200127  ErrorCode likeds(tQUSEC);
000172200127end-pr;
