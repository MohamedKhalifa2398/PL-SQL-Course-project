DECLARE
        CURSOR PK_CURS IS
                    SELECT  cons.constraint_type , cols.owner , cols.column_name  , tab.table_name 
                    FROM user_constraints cons, user_cons_columns cols , USER_TAB_COLUMNS tab
                    WHERE cons.constraint_type = 'P'  -- select  all primary keys
                    AND tab.data_type = 'NUMBER'        -- select the numeric values
                    AND cons.constraint_name = cols.constraint_name --join condation
                    AND cons.owner = cols.owner --joinconstrains  condation
                    AND cols.column_name = tab.column_name --join condation
                    AND cols.table_name = tab.table_name;
                    

BEGIN
        FOR DEPT_RECORD IN PK_CURS LOOP

             
                    EXECUTE IMMEDIATE 'CREATE SEQUENCE '||DEPT_RECORD.owner||'.'||DEPT_RECORD.table_name||'_SEQ
                                                    START WITH 600
                                                     MAXVALUE 99999999
                                                     MINVALUE 1
                                                     increment by 1' ;
                                                     
                     EXECUTE IMMEDIATE 'CREATE OR REPLACE TRIGGER '||DEPT_RECORD.owner||'.'||DEPT_RECORD.table_name||'_TRG
                                                     BEFORE INSERT 
                                                     ON '||DEPT_RECORD.owner||'.'||DEPT_RECORD.table_name||'
                                                     FOR EACH ROW
                                                     BEGIN
                                                        :new.'||DEPT_RECORD.column_name||' := '||DEPT_RECORD.table_name||'_SEQ.nextval;
                                                     END;' ;
                                                     
        END LOOP;
END;
