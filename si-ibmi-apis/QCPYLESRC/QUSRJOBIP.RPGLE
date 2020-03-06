**FREE
         /if not defined(QUSRJOBIP)
         /define QUSRJOBIP
         /else
         /eof
         /endif

         /include qcpylesrc/qusecp

        //==========================================================================================
        // Constants
        //==========================================================================================

         dcl-c cQUSRJOBI_FORMAT_BasicPerformanceInformation const('JOBI0100');
         dcl-c cQUSRJOBI_FORMAT_AdditionalPerformanceInformation const('JOBI0150');

        //==========================================================================================
        // Tempaltes
        //==========================================================================================

         dcl-s tQUSRJOBI_ReceiverVariable char(32767) template;
         dcl-s tQUSRJOBI_LengthOfReceiverVariable int(10) template;
         dcl-s tQUSRJOBI_FormatName char(8) template;
         dcl-s tQUSRJOBI_QualifiedJobName char(26) template;

         dcl-s tQUSRJOBI_BytesReturned int(10) template;
         dcl-s tQUSRJOBI_BytesAvailable int(10) template;
         dcl-s tQUSRJOBI_JobName char(10) template;
         dcl-s tQUSRJOBI_UserName char(10) template;
         dcl-s tQUSRJOBI_JobNumber char(6) template;
         dcl-s tQUSRJOBI_InternalJobIdentifier char(16) template;
         dcl-s tQUSRJOBI_JobStatus char(10) template;
         dcl-s tQUSRJOBI_JobType char(1) template;
         dcl-s tQUSRJOBI_JobSubtype char(1) template;
         dcl-s tQUSRJOBI_Reserved char(2) template;
         dcl-s tQUSRJOBI_RunPriority int(10) template;
         dcl-s tQUSRJOBI_TimeSlice int(10) template;
         dcl-s tQUSRJOBI_DefaultWait int(10) template;
         dcl-s tQUSRJOBI_Purge char(10) template;
         dcl-s tQUSRJOBI_TimesliceEndPool char(10) template;
         dcl-s tQUSRJOBI_ProcessingUnitTime1 int(10) template;
         dcl-s tQUSRJOBI_SystemPoolIdentifier int(10) template;
         dcl-s tQUSRJOBI_MaximumProcessingUnitTimeAllowed int(10) template;
         dcl-s tQUSRJOBI_TemporaryStorageUsed1 int(10) template;
         dcl-s tQUSRJOBI_MaximumTemporaryStorageAllowed1 int(10) template;
         dcl-s tQUSRJOBI_ThreadCount int(10) template;
         dcl-s tQUSRJOBI_MaximumThreads int(10) template;
         dcl-s tQUSRJOBI_TemporaryStorageUsed uns(10) template;
         dcl-s tQUSRJOBI_MaximumTemporaryStorage int(10) template;
         dcl-s tQUSRJOBI_PeakTemporaryStorageUsed uns(10) template;
         dcl-s tQUSRJOBI_ProcessingUnitTimeUsed uns(20) template;

         dcl-ds tQUSRJOBI_JOBI0100 qualified template;
           BytesReturned  like(tQUSRJOBI_BytesReturned);
           BytesAvailable  like(tQUSRJOBI_BytesAvailable);
           JobName like(tQUSRJOBI_JobName);
           UserName like(tQUSRJOBI_UserName);
           JobNumber like(tQUSRJOBI_JobNumber);
           InternalJobIdentifier like(tQUSRJOBI_InternalJobIdentifier);
           JobStatus like(tQUSRJOBI_JobStatus);
           JobType like(tQUSRJOBI_JobType);
           JobSubtype like(tQUSRJOBI_JobSubtype);
           Reserved like(tQUSRJOBI_Reserved);
           RunPriority like(tQUSRJOBI_RunPriority);
           TimeSlice like(tQUSRJOBI_TimeSlice);
           DefaultWait like(tQUSRJOBI_DefaultWait);
           Purge like(tQUSRJOBI_Purge);
         end-ds;

         dcl-ds tQUSRJOBI_JOBI0150 qualified template;
           BytesReturned  like(tQUSRJOBI_BytesReturned);
           BytesAvailable  like(tQUSRJOBI_BytesAvailable);
           JobName like(tQUSRJOBI_JobName);
           UserName like(tQUSRJOBI_UserName);
           JobNumber like(tQUSRJOBI_JobNumber);
           InternalJobIdentifier like(tQUSRJOBI_InternalJobIdentifier);
           JobStatus like(tQUSRJOBI_JobStatus);
           JobType like(tQUSRJOBI_JobType);
           JobSubtype like(tQUSRJOBI_JobSubtype);
           Reserved like(tQUSRJOBI_Reserved);
           RunPriority like(tQUSRJOBI_RunPriority);
           TimeSlice like(tQUSRJOBI_TimeSlice);
           DefaultWait like(tQUSRJOBI_DefaultWait);
           Purge like(tQUSRJOBI_Purge);
           TimesliceEndPool like(tQUSRJOBI_TimesliceEndPool);
           ProcessingUnitTime1 like(tQUSRJOBI_ProcessingUnitTime1);
           SystemPoolIdentifier like(tQUSRJOBI_SystemPoolIdentifier);
           MaximumProcessingUnitTimeAllowed like(tQUSRJOBI_MaximumProcessingUnitTimeAllowed);
           TemporaryStorageUsed1 like(tQUSRJOBI_TemporaryStorageUsed1);
           MaximumTemporaryStorageAllowed1 like(tQUSRJOBI_MaximumTemporaryStorageAllowed1);
           ThreadCount like(tQUSRJOBI_ThreadCount);
           MaximumThreads like(tQUSRJOBI_MaximumThreads);
           TemporaryStorageUsed like(tQUSRJOBI_TemporaryStorageUsed);
           MaximumTemporaryStorage like(tQUSRJOBI_MaximumTemporaryStorage);
           PeakTemporaryStorageUsed like(tQUSRJOBI_PeakTemporaryStorageUsed);
           ProcessingUnitTimeUsed like(tQUSRJOBI_ProcessingUnitTimeUsed);
         end-ds;

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr RetrieveJobInformation extpgm('QUSRJOBI');
           ReceiverVariable like(tQUSRJOBI_ReceiverVariable) const;
           LengthOfReceiverVariable like(tQUSRJOBI_LengthOfReceiverVariable) const;
           IFormatName like(tQUSRJOBI_FormatName) const;
           QualifiedJobName like(tQUSRJOBI_QualifiedJobName) const;
           InternalJobIdentifier like(tQUSRJOBI_InternalJobIdentifier) const;
           ErrorCode likeds(tQUSEC);
         end-pr;

