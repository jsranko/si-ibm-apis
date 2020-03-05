         /if not defined(SISQLP)
         /define SISQLP
         /else
         /eof
         /endif

        //==========================================================================================
        // Constant
        //==========================================================================================

        //==========================================================================================
        // Templates
        //==========================================================================================

         /if defined(SISQL)
         /eof
         /endif

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr SISQL_isWarning ind extproc(*dclcase);
           SQLCommArea likeds(SQLCA);
         end-pr;

         dcl-pr SISQL_noData ind extproc(*dclcase);
           SQLCommArea likeds(SQLCA);
         end-pr;

         dcl-pr SISQL_isError ind extproc(*dclcase);
           SQLCommArea likeds(SQLCA);
         end-pr;
