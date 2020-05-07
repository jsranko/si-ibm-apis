**FREE

/if not defined(SIROUTERP)
  /define SIROUTERP
/else
  /eof
/endif

dcl-c cSIROUTER_Payload_Length const(16000000);

//==========================================================================================
// Templates
//==========================================================================================

dcl-s tSIROUTER_Payload char(cSIROUTER_Payload_Length) template;
dcl-s tSIROUTER_Uri char(276) template;

dcl-ds tSIROUTER_Payload_Def qualified template;
  Uri like(tSIROUTER_Uri);
end-ds;


//==========================================================================================
// Prototypes
//==========================================================================================

dcl-pr SIROUTER extpgm('SIROUTER');
  PayloadIn like(tSIROUTER_Payload) options(*varsize);
  PayloadOut like(tSIROUTER_Payload) options(*varsize);
end-pr;
