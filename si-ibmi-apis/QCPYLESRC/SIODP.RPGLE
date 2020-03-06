**FREE
         /if not defined(SIODP)
         /define SIODP
         /else
         /eof
         /endif

         /include qcpylesrc/siobjtypp
         /include qcpylesrc/qusrobjdp

        //==========================================================================================
        // Constant
        //==========================================================================================


        //==========================================================================================
        // Templates
        //==========================================================================================

         dcl-s tSIOD like(tSIOD_Def) template;
         dcl-s tSIOD_Library char(10) template;
         dcl-s tSIOD_Object char(10) template;
         dcl-s tSIOD_Type char(10) template;
         dcl-s tSIOD_FormatNubmer uns(5) template;

         dcl-s tSIOD_CreationDateAndTime like(tQUSROBJD_CreationDateAndTime) template;

         dcl-ds tSIOD_Def qualified;
           Data likeds(tQUSROBJD_OBJD0400);
           Library like(tSIOD_Library);
           Object like(tSIOD_Object);
           Type like(tSIOD_Type);
           lastFormat like(tSIOD_FormatNubmer);
         end-ds;

         /if defined(SIOD)
         /eof
         /endif

        //==========================================================================================
        // Prototypes
        //==========================================================================================

         dcl-pr SIOD_new like(tSIOD) extproc(*dclcase);
           Library like(tSIOD_Library) const;
           Object like(tSIOD_Object) const;
           Type like(tSIOD_Type) const;
         end-pr;

         dcl-pr SIOD_creationDateAndTime like(tSIOD_CreationDateAndTime) extproc(*dclcase);
           SIOD like(tSIOD);
         end-pr;
