**FREE

//******************************************************************************************
//
//
// Programname    : SISRVPGM
// Programautor   : Sranko Informatik
// Created on     : 05.05.2020
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See makefile
//
//==========================================================================================

 ctl-opt NoMain;
 ctl-opt bnddir('SIIIA/SIIIA');

//==========================================================================================
// Templates
//==========================================================================================

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

/define SISRVPGM
/include qcpylesrc/sisrvpgmp

/include qcpylesrc/qlicvttpp
/include qcpylesrc/rslvspp
/include qcpylesrc/qleawip


//==========================================================================================
// Procedures
//==========================================================================================

//------------------------------------------------------------------------------------------

dcl-proc SISRVPGM_ export;
dcl-pi SISRVPGM_ like(tSISRVPGM) extproc(*dclcase);
  ServiceProgram like(tSISRVPGM_ServiceProgram) const;
  Library like(tSISRVPGM_Library) const;
end-pi;
dcl-ds SISRVPGM likeds(tSISRVPGM);
dcl-ds ErrorCode likeds(tQUSEC);
dcl-s Auth like(tRSLVSP_AuthorityToBeSet) inz(*loval);

SISRVPGM.ServiceProgram = ServiceProgram;
SISRVPGM.Library = Library;
SISRVPGM.SymbolicObjectType = cSISRVPGM_ObjectType;

ConvertType(cQLICVTTP_TO_HEX
           :SISRVPGM.SymbolicObjectType
           :SISRVPGM.HexadecimalObjectType
           :ErrorCode);

SISRVPGM.SystemPointer = ResolveSystemPointer(SISRVPGM.HexadecimalObjectType
                                             :SISRVPGM.ServiceProgram
                                             :SISRVPGM.Library
                                             :Auth
                                             );

return SISRVPGM;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISRVPGM_load export;
dcl-pi SISRVPGM_load ind extproc(*dclcase);
  SISRVPGM like(tSISRVPGM);
end-pi;
dcl-ds dsSISRVPGM likeds(tSISRVPGM) based(pSISRVPGM);
dcl-ds ErrorCode likeds(tQUSEC);

pSISRVPGM = %addr(SISRVPGM);

ActivateBoundProgram(dsSISRVPGM.SystemPointer
                    :dsSISRVPGM.ActivationMark
                    :dsSISRVPGM.ActivationInformation
                    :%size(dsSISRVPGM.ActivationInformation)
                    :ErrorCode
                    );

return SISRVPGM;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc SISRVPGM_getProcedurePointerByName export;
dcl-pi SISRVPGM_getProcedurePointerByName like(tSISRVPGM_ProcedurePointer) extproc(*dclcase);
  SISRVPGM like(tSISRVPGM);
  Procedure like(tSISRVPGM_Procedure) const options(*string);
end-pi;
dcl-ds dsSISRVPGM likeds(tSISRVPGM) based(pSISRVPGM);
dcl-s ProcedurePointer like(tSISRVPGM_ProcedurePointer);
dcl-s TypeOfExportItem like(tSISRVPGM_ProcedurePointer);
dcl-ds ErrorCode likeds(tQUSEC);

pSISRVPGM = %addr(SISRVPGM);

GetExport(dsSISRVPGM.ActivationMark
         :cQLEAWI_Use_export_name
         :cQLEAWI_Export_name_is_a_null_terminated
         :%trim(Procedure)
         :ProcedurePointer
         :TypeOfExportItem
         :ErrorCode
         );

return SISRVPGM;
end-proc;
