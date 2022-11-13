CREATE OR REPLACE PROCEDURE PROJECT.SET_INSTALLMENTS_NO ( P_CONTRACT_ID  number)
IS

CONTRACTS_REC  PROJECT.CONTRACTS%ROWTYPE;

V_INSTALLMENTS NUMBER(2);

BEGIN
                    SELECT * INTO CONTRACTS_REC
                    FROM PROJECT.CONTRACTS
                    WHERE CONTRACT_ID = P_CONTRACT_ID;    
                    
                    IF CONTRACTS_REC.CONTRACT_PAYMENT_TYPE = 'ANNUAL' THEN
                            
                           V_INSTALLMENTS := MONTHS_BETWEEN(CONTRACTS_REC.CONTRACT_ENDDATE , CONTRACTS_REC.CONTRACT_STARTDATE) / 12 ;
                           
                    ELSIF CONTRACTS_REC.CONTRACT_PAYMENT_TYPE = 'QUARTER' THEN

                           V_INSTALLMENTS := MONTHS_BETWEEN(CONTRACTS_REC.CONTRACT_ENDDATE , CONTRACTS_REC.CONTRACT_STARTDATE) / 3 ;                          
                           
                    ELSIF CONTRACTS_REC.CONTRACT_PAYMENT_TYPE = 'MONTHLY' THEN

                           V_INSTALLMENTS := MONTHS_BETWEEN(CONTRACTS_REC.CONTRACT_ENDDATE , CONTRACTS_REC.CONTRACT_STARTDATE) ;
                           
                    ELSIF CONTRACTS_REC.CONTRACT_PAYMENT_TYPE = 'HALFANNUAL' THEN

                           V_INSTALLMENTS := MONTHS_BETWEEN(CONTRACTS_REC.CONTRACT_ENDDATE , CONTRACTS_REC.CONTRACT_STARTDATE) / 6 ;
                    ELSE
                            V_INSTALLMENTS := 0 ;
                    END IF;
                    
                    UPDATE  PROJECT.CONTRACTS 
                    SET PAYMENT_INSTALLMENTS_NO =  V_INSTALLMENTS
                    WHERE CONTRACT_ID = P_CONTRACT_ID ;
                    
END;