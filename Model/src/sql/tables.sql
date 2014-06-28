 drop SEQUENCE fm_seq;
CREATE SEQUENCE fm_seq
 INCREMENT BY 1
 START WITH 1
 NOCACHE ;
 
 select fm_seq.nextval from dual ;
 
  drop table form_master_questions ;
 drop table form_master_versions;
 drop table form_master ;
  
 create table form_master (
form_master_seq   number  ,
 form_name           varchar2(40) ,
 form_desc             varchar2(120) ,
 user_name              varchar2(20) ,
 online_date               date 
  , CONSTRAINT fm_master_seq_pk PRIMARY KEY (fm_master_seq) );

create table form_master_versions (
version_seq             number ,
form_master_seq number  ,
version                 number ,
version_descr       varchar2(50) ,
user_name varchar2(20) ,
online_date date  
  , CONSTRAINT version_seq_pk PRIMARY KEY (version_seq)
 ,   CONSTRAINT form_master_seq_fk    FOREIGN KEY (form_master_seq)   REFERENCES form_master(form_master_seq)    ) ;

 create table form_master_questions (
 question_seq              number ,
 version_seq               number,
 form_master_seq     number ,
 Question_order         number ,
 Question_datatype   varchar2(2) ,
 user_name varchar2(20) ,
 online_date    date  ,
   , CONSTRAINT question_seq_pk PRIMARY KEY (question_seq)
    CONSTRAINT version_seq_fk    FOREIGN KEY (version_seq)     REFERENCES form_versions(version_seq)  );
 
 
 INSERT INTO FORM_MASTER (  FM_MASTER_SEQ        , FORM_NAME           , FORM_DESC     , USER_NAME     , ONLINE_DATE   )
                                         VALUES (   1                                       , 'Training Request'    , null                      ,  user                    , sysdate   );
 
 INSERT INTO FORM_VERSIONS (  VERSION_SEQ        , FORM_MASTER_SEQ       , VERSION     , VERSION_DESCR  , USER_NAME  , ONLINE_DATE  )
                                              VALUES (   2                               , 1                                             ,  1                   ,'Version 1'                  ,  user                   , sysdate   );
 
 

 