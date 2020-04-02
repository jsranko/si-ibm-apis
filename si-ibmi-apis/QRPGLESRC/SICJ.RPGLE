000100190802**FREE
000200190802        //******************************************************************************************
000300190802        //
000400190802        //
000500200120        // Programname    : SICJ
000600190802        // Programautor   : Sranko Informatik
000700200120        // Created on     : 20.01.2020
000800190802        //
000900190802        //==========================================================================================
001000190802        //             Program-Compiling
001100190802        //==========================================================================================
001200190802        //
001300190802        // See QCLLESRC,makesiiia
001400190802        //
001500190802        //==========================================================================================
001600190802
001700200109         ctl-opt NoMain bnddir('SIIIA/SIIIA');
001800190802
001900190802        //==========================================================================================
002000190802        // Constants
002100190802        //==========================================================================================
002200190802
002300190802        //==========================================================================================
002400190802        // Templates
002500190802        //==========================================================================================
002600190802
002700190802        //==========================================================================================
002800190802        // Global-Definition
002900190802        //==========================================================================================
003000190802
003100190802        //==========================================================================================
003200190802        // Prototypes
003300190802        //==========================================================================================
003400190802
003500200120         /define SICJ
003600200120         /include qcpylesrc/sicjp
003700200120         /include qcpylesrc/qwtchgjbp
003701200120         /include qcpylesrc/memcpyp
003900190802
004000190802        //==========================================================================================
004100190802        // Procedures
004200190802        //==========================================================================================
004300190802
006500190802        //------------------------------------------------------------------------------------------
006600190802
006700200120         dcl-proc changeData0100;
006800200120         dcl-pi changeData0100 ind;
006801200120           QualifiedJobName likeds(tSICJ_QualifiedJobName) const;
006802200120           VariableLengthRecord likeds(tQWTCHGJB_VariableLengthRecord1);
007000190802         end-pi;
007003200109         dcl-ds ErrorCode likeds(tQUSEC);
007004200109
007005200120         ChangeJob(%trim(QualifiedJobName)
007006200120                  :*blanks
007007200120                  :cQWTCHGJB_Format_JOBC0100
007008200120                  :VariableLengthRecord
007010200120                  :ErrorCode);
007011200109         if ErrorCode.ExceptionId <> *blanks;
007012200109           return *off;
007013200109         endif;
007100190802
007200190802         return *on;
007300190802         end-proc;
007301200120
007302200120        //------------------------------------------------------------------------------------------
007303200120
007304200120         dcl-proc SICJ_setCCSID export;
007305200120         dcl-pi SICJ_setCCSID ind extproc(*dclcase);
007306200120           QualifiedJobName likeds(tSICJ_QualifiedJobName) const;
007307200120           CCSID like(tSICJ_CCSID) const;
007308200120         end-pi;
007311200120
007312200120         return SICJ_setCodedCharacterSetID(QualifiedJobName:CCSID);
007319200120
007321200120         end-proc;
007322200120
007323200120        //------------------------------------------------------------------------------------------
007324200120
007325200120         dcl-proc SICJ_setCodedCharacterSetID export;
007326200120         dcl-pi SICJ_setCodedCharacterSetID ind extproc(*dclcase);
007327200120           QualifiedJobName likeds(tSICJ_QualifiedJobName) const;
007328200120           CodedCharacterSetID like(tSICJ_CodedCharacterSetID) value;
007329200120         end-pi;
007330200120         dcl-ds VariableLengthRecord likeds(tQWTCHGJB_VariableLengthRecord1) inz;
007331200120
007332200120         VariableLengthRecord.NumberOfVariableLengthRecords = 1;
007333200120         VariableLengthRecord.Key = cQWTCHGJB_Key_CodedCharacterSetID;
007334200120         VariableLengthRecord.LengthOfAttributeInformation = %size(VariableLengthRecord) -
007335200120                              %size(VariableLengthRecord.NumberOfVariableLengthRecords);
007336200120         VariableLengthRecord.TypeOfData = cQWTCHGJB_TypeOfData_Binary;
007337200120         VariableLengthRecord.LengthOfData = %size(CodedCharacterSetID);
007338200120         memcpy(%addr(VariableLengthRecord.Data):%addr(CodedCharacterSetID):%size(CodedCharacterSetID));
007340200120         return changeData0100(QualifiedJobName:VariableLengthRecord);
007341200120
007342200120         end-proc;
007400190802
007500200120
