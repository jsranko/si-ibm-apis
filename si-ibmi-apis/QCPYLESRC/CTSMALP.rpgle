         /if not defined(CTSMALLOCP)
         /define CTSMALLOCP
         /else
         /eof
         /endif

        //==========================================================================================
        // Constant
        //==========================================================================================

        //==========================================================================================
        // Templates
        //==========================================================================================

        dcl-s tCTSMALLOC_Length uns(10) template;

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr C_TS_malloc pointer extproc('_C_TS_malloc');
           Length like(tCTSMALLOC_Length) value;
         end-pr;
