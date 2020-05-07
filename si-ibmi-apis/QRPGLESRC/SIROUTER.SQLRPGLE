**FREE

//******************************************************************************************
//
//
// Programname    : SIROUTER
// Programautor   : Sranko Informatik
// Created on     : 06.05.2020
//
//==========================================================================================
//             Program-Compiling
//==========================================================================================
//
// See makefile
//
//==========================================================================================

ctl-opt main(SIROUTER) dftactgrp(*no) actgrp(*new);

/include qcpylesrc/sictlopt

//==========================================================================================
// Templates
//==========================================================================================

//==========================================================================================
// Global-Definition
//==========================================================================================

//==========================================================================================
// Prototypes
//==========================================================================================

/include qcpylesrc/sirouterp
/include qcpylesrc/sisqlp
/include qcpylesrc/memcpyp
/include qcpylesrc/sisrvpgmp

//==========================================================================================
// Main
//==========================================================================================

dcl-proc SIROUTER;
dcl-pi SIROUTER;
  PayloadIn like(tSIROUTER_Payload) options(*varsize);
  PayloadOut like(tSIROUTER_Payload) options(*varsize);
end-pi;
dcl-s nStdIn ind inz(*off);
dcl-s nStdOut ind inz(*off);
dcl-s uri like(tSIROUTER_Uri);

if %addr(PayloadIn) = *null;
  nStdIn = *on;
endif;

if %addr(PayloadOut) = *null;
  nStdOut = *on;
endif;

uri = getUri(PayloadIn);

select;
when isServiceProgram(uri);
  PayloadOut = callServiceProgram(uri:PayloadIn);
when isProgram(uri);
  PayloadOut = callProgram(uri:PayloadIn);
endsl;


return;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc getUri;
dcl-pi getUri like(tSIROUTER_Uri);
  PayloadIn like(tSIROUTER_Payload);
end-pi;
dcl-s uri like(tSIROUTER_Uri);
dcl-s payloadInCLOB sqltype(clob:16000000);

payloadInCLOB_len = %len(%trim(PayloadIn));
memcpy(%addr(payloadInCLOB_data):%addr(PayloadIn):payloadInCLOB_len);

exec sql set :uri = json_value(:payloadInCLOB format json,
                               '$.uri' returning char(276)
                               error on error);
if SISQL_isError(sqlca);
  dsply 'Error';
  return '';
endif;

return uri;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isServiceProgram;
dcl-pi isServiceProgram ind;
  uri like(tSIROUTER_Uri);
end-pi;

return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc isProgram;
dcl-pi isProgram ind;
  uri like(tSIROUTER_Uri);
end-pi;

return *on;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc callServiceProgram;
dcl-pi callServiceProgram like(tSIROUTER_Payload);
  Uri like(tSIROUTER_Uri);
  PayloadIn like(tSIROUTER_Payload) options(*varsize);
end-pi;
dcl-s Payload like(tSIROUTER_Payload);

return Payload;
end-proc;

//------------------------------------------------------------------------------------------

dcl-proc callProgram;
dcl-pi callProgram like(tSIROUTER_Payload);
  Uri like(tSIROUTER_Uri);
  PayloadIn like(tSIROUTER_Payload) options(*varsize);
end-pi;
dcl-s Payload like(tSIROUTER_Payload);

return Payload;
end-proc;
