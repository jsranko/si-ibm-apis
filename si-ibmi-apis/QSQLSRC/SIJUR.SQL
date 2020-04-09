--Call SQLJ.REMOVE_JAR('SIJUR', 0)
--;

Call SQLJ.INSTALL_JAR('file:$(ROOT_DIR)/src/java/si-java-utils/Regex.jar', 'SIJUR', 0)
;

Create or Replace Function $(LIBRARY)/SIJUR_matches
(
   in_pattern Varchar(512),
   in_string Varchar(1024)
)
Returns Char(1)
Language Java
Parameter Style Java
Specific $(LIBRARY)/SIJURM
Not Deterministic
No Sql
Called On Null Input
No External Action
Disallow Parallel
External Name 'SIJUR:de.si.java.utils.matches'
Not Fenced
;
Label On Function $(LIBRARY)/SIJUR_matches Is 'UDF: Regular Expresion match'
;
