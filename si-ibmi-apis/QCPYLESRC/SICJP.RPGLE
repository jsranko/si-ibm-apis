000100191106**FREE
000101200120         /if not defined(SICJP)
000102200120         /define SICJP
000103190309         /else
000104190309         /eof
000105190309         /endif
000106190802
000107191217         /include siiia/qcpylesrc,qusrjobip
000108190309
000114190309        //==========================================================================================
000115190309        // Constants
000116190309        //==========================================================================================
000117190309
000118200120        dcl-c cSICJ_CurrentJob const('*');
000120190802        //==========================================================================================
000121190802        // Templates
000122190802        //==========================================================================================
000123190802
000125200120        dcl-s tSICJ_CodedCharacterSetID int(10) template;
000126200120        dcl-s tSICJ_Jobname char(10) template;
000127200120        dcl-s tSICJ_Username char(10) template;
000128200120        dcl-s tSICJ_Jobnumber char(6) template;
000129200121        dcl-ds tSICJ_QualifiedJobName qualified template;
000130200120           Jobname like(tSICJ_Jobname);
000131200120           Username like(tSICJ_Username);
000132200120           Jobnumber like(tSICJ_Jobnumber);
000133200120        end-ds;
000134200120        dcl-s tSICJ_CCSID like(tSICJ_CodedCharacterSetID) template;
000160190802
000161200120         /if defined(SICJ)
000162190309         /eof
000163190309         /endif
000164190309
000165190309        //==========================================================================================
000166190309        // Prototypes
000167190309        //==========================================================================================
000168190309
000175200120         dcl-pr SICJ_setCCSID ind extproc(*dclcase);
000176200120           QualifiedJobName likeds(tSICJ_QualifiedJobName) const;
000177200120           CCSID like(tSICJ_CCSID) const;
000178200120         end-pr;
000179200120
000180200120         dcl-pr SICJ_setCodedCharacterSetID ind extproc(*dclcase);
000181200120           QualifiedJobName likeds(tSICJ_QualifiedJobName) const;
000182200120           CodedCharacterSetID like(tSICJ_CodedCharacterSetID) value;
000183200120         end-pr;
