000100190404**FREE
000101200217         /if not defined(QMHRTVMP)
000102200217         /define QMHRTVMP
000103190227         /else
000104190227         /eof
000105190227         /endif
000106190227
000107200217         /include siiia/qcpylesrc,qusecp
000108200217
000109190227        //==========================================================================================
000110190404        //             Templates
000111190227        //==========================================================================================
000112190227
000116190404
000117200217        dcl-s tQMHRTVM_MessageInformation varchar(3000) template;
000118200217        dcl-s tQMHRTVM_LengthOfMessageInformation int(10) template;
000125200217        dcl-s tQMHRTVM_FormatName char(8) template;
000126200217        dcl-s tQMHRTVM_MessageIdentifier char(7) template;
000127200217        dcl-s tQMHRTVM_QualifiedMessageFileName char(20) template;
000128200217        dcl-s tQMHRTVM_ReplacementData char(3000) template;
000129200217        dcl-s tQMHRTVM_LengthOfReplacementData int(10) template;
000130200217        dcl-s tQMHRTVM_ReplaceSubstitutionValues char(10) template;
000131200217        dcl-s tQMHRTVM_ReturnFormatControlCharacters char(10) template;
000132200217        dcl-s tQMHRTVM_RetrieveOption char(10) template;
000133200217        dcl-s tQMHRTVM_CCSIDToConvertTo int(10) template;
000134200217        dcl-s tQMHRTVM_CCSIDOfreplacementData int(10) template;
000135200217        dcl-s tQMHRTVM_BytesReturned int(10) template;
000136200217        dcl-s tQMHRTVM_BytesAvailable int(10) template;
000137200217        dcl-s tQMHRTVM_LengthOfMessageReturned int(10) template;
000138200217        dcl-s tQMHRTVM_LengthOfMessageAvailable int(10) template;
000139200217        dcl-s tQMHRTVM_LengthOfMessageHelpReturned int(10) template;
000140200217        dcl-s tQMHRTVM_LengthOfMessageHelpAvailable int(10) template;
000141200217        dcl-s tQMHRTVM_Message char(3000) template;
000142200217        dcl-s tQMHRTVM_MessageHelp char(3000) template;
000143200217
000144200217        dcl-ds tQMHRTVM_RTVM0100 qualified template;
000145200217          BytesReturned like(tQMHRTVM_BytesReturned);
000146200217          BytesAvailable like(tQMHRTVM_BytesAvailable);
000147200217          LengthOfMessageReturned like(tQMHRTVM_LengthOfMessageReturned);
000148200217          LengthOfMessageAvailable like(tQMHRTVM_LengthOfMessageAvailable);
000149200217          LengthOfMessageHelpReturned like(tQMHRTVM_LengthOfMessageHelpReturned);
000150200217          LengthOfMessageHelpAvailable like(tQMHRTVM_LengthOfMessageHelpAvailable);
000151200217          Message like(tQMHRTVM_Message);
000152200217        end-ds;
000153190404
000154190404        //==========================================================================================
000155190404        //             Prototypes
000156190404        //==========================================================================================
000157190404
000158200217        dcl-pr RetrieveMessage extpgm('QMHRTVM');
000159200217           MessageInformation like(tQMHRTVM_MessageInformation) options(*varsize);
000160200217           LengthOfMessageInformation like(tQMHRTVM_LengthOfMessageInformation) const;
000161200217           FormatName like(tQMHRTVM_FormatName) const;
000162200217           MessageIdentifier like(tQMHRTVM_MessageIdentifier) const;
000163200217           QualifiedMessageFileName like(tQMHRTVM_QualifiedMessageFileName) const;
000164200217           ReplacementData like(tQMHRTVM_ReplacementData) const;
000165200217           LengthOfReplacementData like(tQMHRTVM_LengthOfReplacementData) const;
000166200217           ReplaceSubstitutionValues like(tQMHRTVM_ReplaceSubstitutionValues) const;
000167200217           ReturnFormatControlCharacters like(tQMHRTVM_ReturnFormatControlCharacters) const;
000168200217           ErrorCode likeds(tQUSEC);
000169200217           RetrieveOption like(tQMHRTVM_RetrieveOption) options(*nopass);
000170200217           CCSIDToConvertTo like(tQMHRTVM_CCSIDToConvertTo) options(*nopass);
000171200217           CCSIDOfreplacementData like(tQMHRTVM_CCSIDOfreplacementData) options(*nopass);
000172190404        end-pr;
