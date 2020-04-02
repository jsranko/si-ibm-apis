**FREE
        //******************************************************************************************
        //
        //
        // Programname    : SIJL
        // Programautor   : Sranko Informatik
        // Created on     : 06.03.2019
        //
        //==========================================================================================
        //             Program-Compiling
        //==========================================================================================
        //
        // See QCLLESRC,makesiiia
        //
        //==========================================================================================

         ctl-opt NoMain bnddir('SIIIA/SIIIA');

        //==========================================================================================
        // Constants
        //==========================================================================================

        //==========================================================================================
        // Templates
        //==========================================================================================

        //==========================================================================================
        // Global-Definition
        //==========================================================================================

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         /define SIJI
         /include qcpylesrc/sijip
         /include qcpylesrc/sixcpp

        //==========================================================================================
        // Procedures
        //==========================================================================================

        //------------------------------------------------------------------------------------------

         dcl-proc SIJI_new export;
         dcl-pi SIJI_new like(tSIJI) extproc(*dclcase);
           Jobname like(tSIJI_Jobname) options(*varsize) const;
           Username like(tSIJI_Username) options(*varsize:*nopass) const;
           Jobnumber like(tSIJI_Jobnumber) options(*nopass) const;
         end-pi;
         dcl-ds dsSIJI likeds(tSIJI_Def) inz;

         dsSIJI.QualifiedJobName.Jobname = Jobname;
         if %parms >= %parmnum(Username);
           dsSIJI.QualifiedJobName.Username = Username;
         endif;
         if %parms >= %parmnum(Jobnumber);
           dsSIJI.QualifiedJobName.Jobnumber = Jobnumber;
         endif;

         if Jobname = *blanks;
           SIXCP_throwWithMessageId('CPD3CB2':dsSIJI.QualifiedJobName:cSIXCP_QCPFMSG);
         endif;

         return dsSIJI;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc getData;
         dcl-pi getData char(32767);
           dsSIJI likeds(tSIJI_Def);
           FormatName like(tQUSRJOBI_FormatName) const;
         end-pi;
         dcl-s ReceiverVariable like(tQUSRJOBI_ReceiverVariable);
         dcl-ds ErrorCode likeds(tQUSEC);

         RetrieveJobInformation(ReceiverVariable
                               :%size(ReceiverVariable)
                               :FormatName
                               :dsSIJI.QualifiedJobName
                               :*blanks
                               :ErrorCode);
         if ErrorCode.ExceptionId <> *blanks;
           return *off;
         endif;

         return ReceiverVariable;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIJI_getTemporaryStorageUsed export;
         dcl-pi SIJI_getTemporaryStorageUsed like(tSIJI_TemporaryStorageUsed) extproc(*dclcase);
           SIJI like(tSIJI);
         end-pi;
         dcl-ds dsSIJI likeds(tSIJI_Def) based(pSIJI);
         pSIJI = %addr(SIJI);

         monitor;
           dsSIJI.Data0150 = getData(dsSIJI:cQUSRJOBI_FORMAT_AdditionalPerformanceInformation);
         on-error;
           SIXCP_throwWithMessageId('CPD3CB2':dsSIJI.QualifiedJobName:cSIXCP_QCPFMSG);
         endmon;

         return dsSIJI.Data0150.TemporaryStorageUsed;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIJI_listCallStackEntrys export;
         dcl-pi SIJI_listCallStackEntrys like(tSIJI_List) extproc(*dclcase);
           SIJI like(tSIJI);
         end-pi;
         dcl-ds dsSIJI likeds(tSIJI_Def) based(pSIJI);
         pSIJI = %addr(SIJI);

         return listCallStackEntrys(dsSIJI);
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIJI_existProgramInCallStack export;
         dcl-pi SIJI_existProgramInCallStack ind extproc(*dclcase);
           SIJI like(tSIJI);
           Program like(tSIJI_Program) const;
         end-pi;
         dcl-ds dsSIJI likeds(tSIJI_Def) based(pSIJI);
         dcl-ds Entry likeds(tSIJI_CallStackEntry);
         dcl-s CallStackList like(tSIJI_List);

         pSIJI = %addr(SIJI);
         CallStackList = listCallStackEntrys(dsSIJI);
         dow SIITR_ForEach(CallStackList);
             SIITR_setValue(CallStackList:%addr(Entry));

             if Entry.ProgramName = Program;
                SIITR_close(CallStackList);
                return *on;
             endif;
         enddo;
         SIITR_close(CallStackList);

         return *off;

         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIJI_getCallStackEntryForCaller export;
         dcl-pi SIJI_getCallStackEntryForCaller like(tSIJI_CallStackEntry) extproc(*dclcase);
           SIJI like(tSIJI);
         end-pi;
         dcl-ds dsSIJI likeds(tSIJI_Def) based(pSIJI);
         dcl-ds Entry likeds(tSIJI_CallStackEntry);
         dcl-s CallStackList like(tSIJI_List);
         dcl-s ProgrammName char(20) inz(*blanks);
         dcl-s ProgrammCounter uns(5) inz(0);
         dcl-s ProgrammCounterInd ind inz(*off);

         pSIJI = %addr(SIJI);
         CallStackList = listCallStackEntrys(dsSIJI);
         dow SIITR_ForEach(CallStackList);
             SIITR_setValue(CallStackList:%addr(Entry));

             if Entry.ProcedureName = 'SIJI_getCallStackEntryForCaller';
               ProgrammCounterInd = *on;
               ProgrammName = Entry.ProgramName + Entry.ProgramLibraryName;
               iter;
             endif;

             if ProgrammCounterInd;
               if ProgrammName <> Entry.ProgramName + Entry.ProgramLibraryName;
                 ProgrammCounter += 1;
                 ProgrammName = Entry.ProgramName + Entry.ProgramLibraryName;
               endif;

               if ProgrammCounter = 2;
                 SIITR_close(CallStackList);
                 return Entry;
               endif;
             endif;
         enddo;
         SIITR_close(CallStackList);

         return *off;

         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc listCallStackEntrys;
         dcl-pi listCallStackEntrys like(tSIJI_List);
           dsSIJI likeds(tSIJI_Def);
         end-pi;

         dcl-s CallStackEntrys like(tQWVRCSTK_ReceiverVariable);
         dcl-ds Job likeds(tQWVRCSTK_JobIdentificationInformation) inz;
         dcl-s JobFormat like(tQWVRCSTK_FormatOfJobIdentificationInformation);
         dcl-ds ErrorCode likeds(tQUSEC) inz;
         dcl-ds Format100 likeds(tQWVRCSTK_CSTK0100) based(pFormat100);
         dcl-s i like(tQWVRCSTK_NumberOfCallStackEntriesReturned);
         dcl-ds Entry likeds(tQWVRCSTK_Entry) based(pEntry);
         dcl-ds CallStackEntry likeds(tSIJI_CallStackEntry);
         dcl-s CallStackList like(tSIJI_List);
         dcl-s ProcedureName like(tQWVRCSTK_ProcedureName) based(pProcedureName);

         Job.JobName = dsSIJI.QualifiedJobName.Jobname;
         Job.UserName = dsSIJI.QualifiedJobName.Username;
         Job.JobNumber = dsSIJI.QualifiedJobName.Jobnumber;
         Job.ThreadIndicator = 1;
         Job.Reserved = *loval;
         Job.ThreadIdentifier = *loval;
         RetrieveCallStack(CallStackEntrys
                          :%size(CallStackEntrys)
                          :cQWVRCSTK_Format0100
                          :Job
                          :cQWVRCSTK_JobFormat0100
                          :ErrorCode
                          );
         if ErrorCode.ExceptionId <> *blanks;
           return CallStackList;
         endif;
         pFormat100 = %Addr(CallStackEntrys);

         for i = 1 to Format100.NumberOfCallStackEntriesReturned;
           if i = 1;
             pEntry = pFormat100 + Format100.OffsetToCallStackEntryInformation;
           else;
             pEntry = pEntry + Entry.LengthOfThisCallStackEntry;
           endif;
           eval-corr CallStackEntry = Entry;
           pProcedureName = pEntry + Entry.DisplacementToTheProcedureName;
           CallStackEntry.ProcedureName = %subst(ProcedureName:1:Entry.LengthOfProcedureName);
           SIITR_addEntry(CallStackList:%addr(CallStackEntry):%size(CallStackEntry));
         endfor;

         return CallStackList;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIJI_getQualifiedJobName export;
         dcl-pi SIJI_getQualifiedJobName like(tSIJI_QualifiedJobName) extproc(*dclcase);
           SIJI like(tSIJI);
         end-pi;
         dcl-ds dsSIJI likeds(tSIJI_Def) based(pSIJI);
         pSIJI = %addr(SIJI);

         monitor;
           dsSIJI.Data0150 = getData(dsSIJI:cQUSRJOBI_FORMAT_AdditionalPerformanceInformation);
         on-error;
           SIXCP_throwWithMessageId('CPD3CB2':dsSIJI.QualifiedJobName:cSIXCP_QCPFMSG);
         endmon;

         return %char(dsSIJI.Data0150.JobNumber) + '/' +
                %trim(dsSIJI.Data0150.UserName) + '/' +
                %trim(dsSIJI.Data0150.JobName);
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIJI_close export;
         dcl-pi SIJI_close extproc(*dclcase);
           SIJI like(tSIJI);
         end-pi;
         dcl-ds dsSIJI likeds(tSIJI_Def) based(pSIJI);
         pSIJI = %addr(SIJI);

         clear dsSIJI;

         return;
         end-proc;

        //------------------------------------------------------------------------------------------

         dcl-proc SIJI_getCodedCharacterSetID export;
         dcl-pi SIJI_getCodedCharacterSetID like(tSIJI_CodedCharacterSetID) extproc(*dclcase);
           SIJI like(tSIJI);
         end-pi;
         dcl-ds dsSIJI likeds(tSIJI_Def) based(pSIJI);
         pSIJI = %addr(SIJI);

         monitor;
           dsSIJI.Data0400 = getData(dsSIJI:cQUSRJOBI_FORMAT_JobAttributeInformation);
         on-error;
           SIXCP_throwWithMessageId('CPD3CB2':dsSIJI.QualifiedJobName:cSIXCP_QCPFMSG);
         endmon;

         return dsSIJI.Data0400.CodedCharacterSetID;
         end-proc;

