-- @C:\JDeveloper\mywork\11117\formMaster\formMaster\Model\src\sql\tables.sql

create table "BOBM"."FORM_MAIN"
    (
        "FORM_ID" number , "FORM_NAME" varchar2( 50 byte ) , "FORM_TYPE" varchar2( 20 byte ) , "USER_NAME" varchar2( 15 byte ) , "ENTRY_DATE" date , "APPROVAL" varchar2( 30 byte ) , primary key( "FORM_ID" ) using index pctfree 10 initrans 2 maxtrans 255 compute statistics storage( initial 65536 next 1048576 minextents 1 maxextents 2147483645 pctincrease 0 freelists 1 freelist groups 1 buffer_pool default flash_cache default cell_flash_cache default ) tablespace "DATA" enable
    )
    segment creation immediate pctfree 10 pctused 40 initrans 1 maxtrans 255 nocompress logging storage
    (
        initial 65536 next 1048576 minextents 1 maxextents 2147483645 pctincrease 0 freelists 1 freelist groups 1 buffer_pool default flash_cache default cell_flash_cache default
    )
    tablespace "DATA" ;
    
    
create table "BOBM"."FORM_DETAILS"
    (
        "FORM_DETAILS_ID" number , "FORM_ID" number , "INQUIRY_TYPE" varchar2( 10 byte ) , "INQUIRY" varchar2( 200 byte ) , "ORDER_BY" number , "DEPENDENCY" number , "DEPENDENCY_TYPE" varchar2( 10 byte ) , "USER_NAME" varchar2( 15 byte ) , "ENTRY_DATE" date , primary key( "FORM_DETAILS_ID" ) using index pctfree 10 initrans 2 maxtrans 255 compute statistics storage( initial 65536 next 1048576 minextents 1 maxextents 2147483645 pctincrease 0 freelists 1 freelist groups 1 buffer_pool default flash_cache default cell_flash_cache default ) tablespace "DATA" enable , constraint "FORM_DETAILS_FK" foreign key( "FORM_ID" ) references "BOBM"."FORM_MAIN"( "FORM_ID" ) enable
    )
    segment creation immediate pctfree 10 pctused 40 initrans 1 maxtrans 255 nocompress logging storage
    (
        initial 65536 next 1048576 minextents 1 maxextents 2147483645 pctincrease 0 freelists 1 freelist groups 1 buffer_pool default flash_cache default cell_flash_cache default
    )
    tablespace "DATA" ;
    
    
create table "BOBM"."FORM_MAIN"
    (
        "FORM_ID" number , "FORM_NAME" varchar2( 50 byte ) , "FORM_TYPE" varchar2( 20 byte ) , "USER_NAME" varchar2( 15 byte ) , "ENTRY_DATE" date , "APPROVAL" varchar2( 30 byte ) , primary key( "FORM_ID" ) using index pctfree 10 initrans 2 maxtrans 255 compute statistics storage( initial 65536 next 1048576 minextents 1 maxextents 2147483645 pctincrease 0 freelists 1 freelist groups 1 buffer_pool default flash_cache default cell_flash_cache default ) tablespace "DATA" enable
    )
    segment creation immediate pctfree 10 pctused 40 initrans 1 maxtrans 255 nocompress logging storage
    (
        initial 65536 next 1048576 minextents 1 maxextents 2147483645 pctincrease 0 freelists 1 freelist groups 1 buffer_pool default flash_cache default cell_flash_cache default
    )
    tablespace "DATA" ;
    
create table "BOBM"."FORM_RESPONSE"
    (
        "FORM_RESPONSE_ID" number , "FORM_ID" number , "PER_SEQ" number , "ONLINE_DATE" date , "USER_NAME" varchar2( 30 byte ) , "SUBMISSION_DATE" date , primary key( "FORM_RESPONSE_ID" ) using index pctfree 10 initrans 2 maxtrans 255 compute statistics storage( initial 65536 next 1048576 minextents 1 maxextents 2147483645 pctincrease 0 freelists 1 freelist groups 1 buffer_pool default flash_cache default cell_flash_cache default ) tablespace "DATA" enable
    )
    segment creation immediate pctfree 10 pctused 40 initrans 1 maxtrans 255 nocompress logging storage
    (
        initial 65536 next 1048576 minextents 1 maxextents 2147483645 pctincrease 0 freelists 1 freelist groups 1 buffer_pool default flash_cache default cell_flash_cache default
    )
    tablespace "DATA" ;
    
create table "BOBM"."FORM_RESPONSE_DETAILS"
    (
        "FORM_RESPONSE_DETAILS_ID" number , "FORM_RESPONSE_ID" number , "FORM_DETAILS_ID" number , "ORDER_BY" number , "INQUIRY_TYPE" varchar2( 2 byte ) , "DEPENDENCY" number , "RESPONSE" varchar2( 400 byte ) , "USER_NAME" varchar2( 15 byte ) , "ENTRY_DATE" date , primary key( "FORM_RESPONSE_DETAILS_ID" ) using index pctfree 10 initrans 2 maxtrans 255 compute statistics storage( initial 65536 next 1048576 minextents 1 maxextents 2147483645 pctincrease 0 freelists 1 freelist groups 1 buffer_pool default flash_cache default cell_flash_cache default ) tablespace "DATA" enable , constraint "FORM_RESPONSE_DETAIL_FK" foreign key( "FORM_RESPONSE_ID" ) references "BOBM"."FORM_RESPONSE"( "FORM_RESPONSE_ID" ) enable
    )
    segment creation immediate pctfree 10 pctused 40 initrans 1 maxtrans 255 nocompress logging storage
    (
        initial 65536 next 1048576 minextents 1 maxextents 2147483645 pctincrease 0 freelists 1 freelist groups 1 buffer_pool default flash_cache default cell_flash_cache default
    )
    tablespace "DATA" ;


connect sys/admin@ssf as sysdba
DROP USER formMaster CASCADE;

CREATE USER formMaster  
PROFILE DEFAULT  
IDENTIFIED BY formMaster  
DEFAULT TABLESPACE USERS  
TEMPORARY TABLESPACE TEMP  
ACCOUNT UNLOCK  ;

connect sys/admin@ssf as sysdba
GRANT CONNECT,RESOURCE , create session, create table, create procedure,
create sequence, create view, create trigger,
create synonym, create public synonym , create materialized view, query rewrite,
create any directory, create type to formMaster ;

connect sys/admin@ssf as sysdba
grant select on hr.employees to formMaster ;
grant select on hr.departments to formMaster ;
grant select on hr.jobs to formMaster ;

connect formMaster/formMaster@ssf ;

drop SEQUENCE fm_seq;
CREATE SEQUENCE fm_seq
INCREMENT BY 1
START WITH 1
NOCACHE ;
select fm_seq.nextval from dual ;

DROP PUBLIC Synonym FM_SEQ;
Create PUBLIC Synonym FM_SEQ FOR FORMMASTER.FM_SEQ;

drop table form_master_questions ;
drop table form_master_versions;
drop table form_master ;

create table form_master (
form_master_seq   number  ,
form_name           varchar2(40) ,
form_desc             varchar2(120) ,
user_name              varchar2(20) ,
online_date               date 
, CONSTRAINT fm_master_seq_pk PRIMARY KEY (form_master_seq) );

create table form_master_versions (
version_seq             number ,
form_master_seq number  ,
version                 number ,
version_descr       varchar2(50) ,
user_name varchar2(20) ,
online_date date   ,
CONSTRAINT version_seq_pk PRIMARY KEY (version_seq) ,
CONSTRAINT form_master_seq_fk    FOREIGN KEY (form_master_seq)   REFERENCES form_master(form_master_seq)    ) ;

drop table form_master_questions ;
create table form_master_questions (
question_seq              number ,
version_seq               number,
Question_order         number ,
Question                    varchar2(200) ,
Question_datatype   varchar2(2) ,
user_name varchar2(20) ,
online_date    date   ,
CONSTRAINT question_seq_pk PRIMARY KEY (question_seq),
CONSTRAINT version_seq_fk    FOREIGN KEY (version_seq)     REFERENCES form_master_versions(version_seq)  );

delete from FORM_MASTER_QUESTIONS ;
delete from FORM_MASTER_VERSIONS ;
delete from form_master ;
commit ;


INSERT INTO form_master (  form_master_seq        , FORM_NAME           , FORM_DESC     , USER_NAME     , ONLINE_DATE   )
                                 VALUES (   1                                       , 'Training Request'    , null                      ,  user                    , sysdate   );

INSERT INTO FORM_MASTER_VERSIONS (  VERSION_SEQ , FORM_MASTER_SEQ       , VERSION       , VERSION_DESCR , USER_NAME     , ONLINE_DATE   )
                                                               VALUES (   2                        , 1                                             ,  1                   ,'Version 1'                  ,  user                   , sysdate   );


INSERT INTO FORM_MASTER_QUESTIONS (  QUESTION_SEQ       , VERSION_SEQ   ,  QUESTION_ORDER   , Question         , QUESTION_DATATYPE     , USER_NAME     , ONLINE_DATE   )
                                                              VALUES (   3                                     , 2                             ,  1                                     ,  'When is it'      , 'd'                                            ,  user                   , sysdate   );
                
INSERT INTO FORM_MASTER_QUESTIONS (  QUESTION_SEQ       , VERSION_SEQ   ,  QUESTION_ORDER    , Question           , QUESTION_DATATYPE     , USER_NAME     , ONLINE_DATE   )
                                                                VALUES (  4                                    , 2                              , 2                                       , 'Where is it'       , 'ff'                                          ,  user                   , sysdate   );
                                                             
commit ;                                                                     
                                  
INSERT INTO form_master (  form_master_seq        , FORM_NAME           , FORM_DESC     , USER_NAME     , ONLINE_DATE   )
                                 VALUES (   2                                 , 'Time Off Request'    , null                      ,  user                    , sysdate   );

INSERT INTO FORM_MASTER_VERSIONS (  VERSION_SEQ , FORM_MASTER_SEQ       , VERSION       , VERSION_DESCR , USER_NAME     , ONLINE_DATE   )
                                                              VALUES (   3                         , 2                                            ,  1                   , 'Version 1'                  ,  user                   , sysdate   );


INSERT INTO FORM_MASTER_QUESTIONS (  QUESTION_SEQ       , VERSION_SEQ   ,  QUESTION_ORDER   , Question         , QUESTION_DATATYPE     , USER_NAME     , ONLINE_DATE   )
                                                                 VALUES (  5                                     ,3                             ,  1                                     ,  'Time off Type'      , 'l'                                            ,  user                   , sysdate   );
              
INSERT INTO FORM_MASTER_QUESTIONS (  QUESTION_SEQ       , VERSION_SEQ   ,  QUESTION_ORDER    , Question           , QUESTION_DATATYPE     , USER_NAME     , ONLINE_DATE   )
                                                             VALUES   (   6                                   , 3                                , 2                                       , 'from date'       , 'd'                                          ,  user                   , sysdate   );
                   
INSERT INTO FORM_MASTER_QUESTIONS (  QUESTION_SEQ       , VERSION_SEQ   ,  QUESTION_ORDER    , Question           , QUESTION_DATATYPE     , USER_NAME     , ONLINE_DATE   )
                                                             VALUES   (   7                                   , 3                                , 2                                       , 'To Date'       , 'd'                                          ,  user                   , sysdate   );
                                                             
commit ;                                        
                                  
                                  
                                  
                                                             
@s form_master             
@s FORM_MASTER_VERSIONS
@s FORM_MASTER_QUESTIONS

create or replace view form_master_client_data as (
select
EMPLOYEE_ID        fm_seq ,
first_name                 fname ,
last_name                 lname ,       
email                         login ,
phone_number        phone ,
job_id                       role  ,
(select job_title from hr.jobs where job_id = e.job_id)   job_title ,
manager_id             manager_id ,
(select last_name||', '||first_name from hr.employees where employee_id = manager_id)   manager
from hr.employees e  );







