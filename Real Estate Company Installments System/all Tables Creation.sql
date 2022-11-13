
CREATE TABLE PROJECT.CLIENTS
(
  CLIENT_ID       NUMBER(6),
  CLIENT_NAME     VARCHAR2(30 BYTE),
  CLIENT_ADDRESS  VARCHAR2(30 BYTE),
  CLIENT_NOTES    VARCHAR2(250 BYTE)
);


ALTER TABLE PROJECT.CLIENTS ADD (CONSTRAINT CLIENTS_PK  PRIMARY KEY (CLIENT_ID) );
               
CREATE TABLE PROJECT.CONTRACTS
(
  CONTRACT_ID              NUMBER(5),
  CONTRACT_STARTDATE       DATE                 NOT NULL,
  CONTRACT_ENDDATE         DATE                 NOT NULL,
  PAYMENT_INSTALLMENTS_NO  NUMBER(2),
  CONTRACT_TOTAL_FEES      NUMBER(10,2)         NOT NULL,
  CONTRACT_DEPOSIT_FEES    NUMBER(10,2),
  CLIENT_ID                NUMBER(5)            NOT NULL,
  CONTRACT_PAYMENT_TYPE    VARCHAR2(10 BYTE),
  NOTES                    VARCHAR2(250 BYTE)
);


ALTER TABLE PROJECT.CONTRACTS ADD ( CONSTRAINT CONTRACTS_PK PRIMARY KEY (CONTRACT_ID) );
               
CREATE TABLE PROJECT.INSTALLMENTS_PAID
(
  INSTALLMENT_ID    NUMBER(10),
  CONTRACT_ID       NUMBER(5),
  INSTALLMET_ID     DATE,
  INSTALLEMENT_AMT  NUMBER(10,2),
  PAID              NUMBER(2)
)

ALTER TABLE PROJECT.INSTALLMENTS_PAID ADD ( CONSTRAINT INSTALLMENTS_PAID_PK PRIMARY KEY (INSTALLMENT_ID) );