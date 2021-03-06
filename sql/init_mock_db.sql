-- Copyright 2017 Google Inc.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE _transicator_metadata
(key varchar primary key,
value varchar);
INSERT INTO "_transicator_metadata" VALUES('snapshot','1142790:1142790:');
CREATE TABLE _transicator_tables
(tableName varchar not null,
columnName varchar not null,
typid integer,
primaryKey bool);
INSERT INTO "_transicator_tables" VALUES('kms_bundle_config','id',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_bundle_config','data_scope_id',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_bundle_config','name',25,0);
INSERT INTO "_transicator_tables" VALUES('kms_bundle_config','uri',25,0);
INSERT INTO "_transicator_tables" VALUES('kms_bundle_config','checksumtype',25,0);
INSERT INTO "_transicator_tables" VALUES('kms_bundle_config','checksum',25,0);
INSERT INTO "_transicator_tables" VALUES('kms_bundle_config','created',1114,0);
INSERT INTO "_transicator_tables" VALUES('kms_bundle_config','created_by',25,0);
INSERT INTO "_transicator_tables" VALUES('kms_bundle_config','updated',1114,0);
INSERT INTO "_transicator_tables" VALUES('kms_bundle_config','updated_by',25,0);
INSERT INTO "_transicator_tables" VALUES('kms_bundle_config','crc',25,0);
INSERT INTO "_transicator_tables" VALUES('kms_deployment','id',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_deployment','bundle_config_id',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_deployment','apid_cluster_id',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_deployment','data_scope_id',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_deployment','bundle_config_name',25,0);
INSERT INTO "_transicator_tables" VALUES('kms_deployment','bundle_config_json',25,0);
INSERT INTO "_transicator_tables" VALUES('kms_deployment','config_json',25,0);
INSERT INTO "_transicator_tables" VALUES('kms_deployment','created',1114,0);
INSERT INTO "_transicator_tables" VALUES('kms_deployment','created_by',25,0);
INSERT INTO "_transicator_tables" VALUES('kms_deployment','updated',1114,0);
INSERT INTO "_transicator_tables" VALUES('kms_deployment','updated_by',25,0);
INSERT INTO "_transicator_tables" VALUES('kms_deployment','_change_selector',25,1);
INSERT INTO "_transicator_tables" VALUES('kms_api_product','id',2950,1);
INSERT INTO "_transicator_tables" VALUES('kms_api_product','tenant_id',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_api_product','name',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_api_product','display_name',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_api_product','description',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_api_product','api_resources',1015,0);
INSERT INTO "_transicator_tables" VALUES('kms_api_product','approval_type',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_api_product','scopes',1015,0);
INSERT INTO "_transicator_tables" VALUES('kms_api_product','proxies',1015,0);
INSERT INTO "_transicator_tables" VALUES('kms_api_product','environments',1015,0);
INSERT INTO "_transicator_tables" VALUES('kms_api_product','quota',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_api_product','quota_time_unit',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_api_product','quota_interval',23,0);
INSERT INTO "_transicator_tables" VALUES('kms_api_product','created_at',1114,1);
INSERT INTO "_transicator_tables" VALUES('kms_api_product','created_by',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_api_product','updated_at',1114,1);
INSERT INTO "_transicator_tables" VALUES('kms_api_product','updated_by',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_api_product','_change_selector',1043,0);
INSERT INTO "_transicator_tables" VALUES('attributes','tenant_id',1043,1);
INSERT INTO "_transicator_tables" VALUES('attributes','entity_id',1043,1);
INSERT INTO "_transicator_tables" VALUES('attributes','cust_id',2950,0);
INSERT INTO "_transicator_tables" VALUES('attributes','org_id',2950,0);
INSERT INTO "_transicator_tables" VALUES('attributes','dev_id',2950,0);
INSERT INTO "_transicator_tables" VALUES('attributes','comp_id',2950,0);
INSERT INTO "_transicator_tables" VALUES('attributes','apiprdt_id',2950,0);
INSERT INTO "_transicator_tables" VALUES('attributes','app_id',2950,0);
INSERT INTO "_transicator_tables" VALUES('attributes','appcred_id',1043,0);
INSERT INTO "_transicator_tables" VALUES('attributes','name',1043,1);
INSERT INTO "_transicator_tables" VALUES('attributes','type',19701,1);
INSERT INTO "_transicator_tables" VALUES('attributes','value',1043,0);
INSERT INTO "_transicator_tables" VALUES('attributes','_change_selector',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_company','id',2950,1);
INSERT INTO "_transicator_tables" VALUES('kms_company','tenant_id',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_company','name',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_company','display_name',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_company','status',19564,0);
INSERT INTO "_transicator_tables" VALUES('kms_company','created_at',1114,1);
INSERT INTO "_transicator_tables" VALUES('kms_company','created_by',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_company','updated_at',1114,1);
INSERT INTO "_transicator_tables" VALUES('kms_company','updated_by',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_company','_change_selector',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_organization','id',2950,1);
INSERT INTO "_transicator_tables" VALUES('kms_organization','name',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_organization','display_name',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_organization','type',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_organization','tenant_id',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_organization','customer_id',2950,1);
INSERT INTO "_transicator_tables" VALUES('kms_organization','description',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_organization','created_at',1114,1);
INSERT INTO "_transicator_tables" VALUES('kms_organization','created_by',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_organization','updated_at',1114,1);
INSERT INTO "_transicator_tables" VALUES('kms_organization','updated_by',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_organization','_change_selector',1043,0);
INSERT INTO "_transicator_tables" VALUES('edgex_apid_cluster','id',1043,1);
INSERT INTO "_transicator_tables" VALUES('edgex_apid_cluster','name',25,0);
INSERT INTO "_transicator_tables" VALUES('edgex_apid_cluster','description',25,0);
INSERT INTO "_transicator_tables" VALUES('edgex_apid_cluster','umbrella_org_app_name',25,0);
INSERT INTO "_transicator_tables" VALUES('edgex_apid_cluster','created',1114,0);
INSERT INTO "_transicator_tables" VALUES('edgex_apid_cluster','created_by',25,1);
INSERT INTO "_transicator_tables" VALUES('edgex_apid_cluster','updated',1114,0);
INSERT INTO "_transicator_tables" VALUES('edgex_apid_cluster','updated_by',25,0);
INSERT INTO "_transicator_tables" VALUES('edgex_apid_cluster','_change_selector',25,1);
INSERT INTO "_transicator_tables" VALUES('kms_deployment_history','id',2950,1);
INSERT INTO "_transicator_tables" VALUES('kms_deployment_history','name',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_deployment_history','ext_ref_id',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_deployment_history','display_name',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_deployment_history','description',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_deployment_history','created_at',1114,1);
INSERT INTO "_transicator_tables" VALUES('kms_deployment_history','created_by',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_deployment_history','updated_at',1114,1);
INSERT INTO "_transicator_tables" VALUES('kms_deployment_history','updated_by',1043,0);
INSERT INTO "_transicator_tables" VALUES('configuration','id',1043,1);
INSERT INTO "_transicator_tables" VALUES('configuration','body',25,0);
INSERT INTO "_transicator_tables" VALUES('configuration','created',1114,0);
INSERT INTO "_transicator_tables" VALUES('configuration','created_by',25,0);
INSERT INTO "_transicator_tables" VALUES('configuration','updated',1114,0);
INSERT INTO "_transicator_tables" VALUES('configuration','updated_by',25,0);
INSERT INTO "_transicator_tables" VALUES('edgex_data_scope','id',1043,1);
INSERT INTO "_transicator_tables" VALUES('edgex_data_scope','apid_cluster_id',1043,1);
INSERT INTO "_transicator_tables" VALUES('edgex_data_scope','scope',25,0);
INSERT INTO "_transicator_tables" VALUES('edgex_data_scope','org',25,1);
INSERT INTO "_transicator_tables" VALUES('edgex_data_scope','env',25,1);
INSERT INTO "_transicator_tables" VALUES('edgex_data_scope','org_scope',1043,0);
INSERT INTO "_transicator_tables" VALUES('edgex_data_scope','env_scope',1043,0);
INSERT INTO "_transicator_tables" VALUES('edgex_data_scope','created',1114,0);
INSERT INTO "_transicator_tables" VALUES('edgex_data_scope','created_by',25,0);
INSERT INTO "_transicator_tables" VALUES('edgex_data_scope','updated',1114,0);
INSERT INTO "_transicator_tables" VALUES('edgex_data_scope','updated_by',25,0);
INSERT INTO "_transicator_tables" VALUES('edgex_data_scope','_change_selector',25,1);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential','id',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential','tenant_id',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential','consumer_secret',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential','app_id',2950,1);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential','method_type',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential','status',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential','issued_at',1114,1);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential','expires_at',1114,1);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential','app_status',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential','scopes',1015,0);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential','created_at',1114,0);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential','created_by',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential','updated_at',1114,0);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential','updated_by',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential','_change_selector',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_company_developer','tenant_id',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_company_developer','company_id',2950,1);
INSERT INTO "_transicator_tables" VALUES('kms_company_developer','developer_id',2950,1);
INSERT INTO "_transicator_tables" VALUES('kms_company_developer','roles',1015,0);
INSERT INTO "_transicator_tables" VALUES('kms_company_developer','created_at',1114,0);
INSERT INTO "_transicator_tables" VALUES('kms_company_developer','created_by',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_company_developer','updated_at',1114,0);
INSERT INTO "_transicator_tables" VALUES('kms_company_developer','updated_by',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_company_developer','_change_selector',1043,0);
INSERT INTO "_transicator_tables" VALUES('edgex_deployment_history','id',1043,1);
INSERT INTO "_transicator_tables" VALUES('edgex_deployment_history','deployment_id',1043,0);
INSERT INTO "_transicator_tables" VALUES('edgex_deployment_history','action',25,0);
INSERT INTO "_transicator_tables" VALUES('edgex_deployment_history','bundle_config_id',1043,0);
INSERT INTO "_transicator_tables" VALUES('edgex_deployment_history','apid_cluster_id',1043,0);
INSERT INTO "_transicator_tables" VALUES('edgex_deployment_history','data_scope_id',1043,0);
INSERT INTO "_transicator_tables" VALUES('edgex_deployment_history','bundle_config_json',25,0);
INSERT INTO "_transicator_tables" VALUES('edgex_deployment_history','config_json',25,0);
INSERT INTO "_transicator_tables" VALUES('edgex_deployment_history','created',1114,0);
INSERT INTO "_transicator_tables" VALUES('edgex_deployment_history','created_by',25,0);
INSERT INTO "_transicator_tables" VALUES('edgex_deployment_history','updated',1114,0);
INSERT INTO "_transicator_tables" VALUES('edgex_deployment_history','updated_by',25,0);
INSERT INTO "_transicator_tables" VALUES('kms_app','id',2950,1);
INSERT INTO "_transicator_tables" VALUES('kms_app','tenant_id',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_app','name',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_app','display_name',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_app','access_type',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_app','callback_url',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_app','status',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_app','app_family',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_app','company_id',2950,0);
INSERT INTO "_transicator_tables" VALUES('kms_app','developer_id',2950,0);
INSERT INTO "_transicator_tables" VALUES('kms_app','parent_id',2950,1);
INSERT INTO "_transicator_tables" VALUES('kms_app','type',19625,0);
INSERT INTO "_transicator_tables" VALUES('kms_app','created_at',1114,1);
INSERT INTO "_transicator_tables" VALUES('kms_app','created_by',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_app','updated_at',1114,1);
INSERT INTO "_transicator_tables" VALUES('kms_app','updated_by',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_app','_change_selector',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential_apiproduct_mapper','tenant_id',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential_apiproduct_mapper','appcred_id',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential_apiproduct_mapper','app_id',2950,1);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential_apiproduct_mapper','apiprdt_id',2950,1);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential_apiproduct_mapper','status',19670,0);
INSERT INTO "_transicator_tables" VALUES('kms_app_credential_apiproduct_mapper','_change_selector',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_developer','id',2950,1);
INSERT INTO "_transicator_tables" VALUES('kms_developer','tenant_id',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_developer','username',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_developer','first_name',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_developer','last_name',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_developer','password',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_developer','email',1043,1);
INSERT INTO "_transicator_tables" VALUES('kms_developer','status',19564,0);
INSERT INTO "_transicator_tables" VALUES('kms_developer','encrypted_password',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_developer','salt',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_developer','created_at',1114,1);
INSERT INTO "_transicator_tables" VALUES('kms_developer','created_by',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_developer','updated_at',1114,1);
INSERT INTO "_transicator_tables" VALUES('kms_developer','updated_by',1043,0);
INSERT INTO "_transicator_tables" VALUES('kms_developer','_change_selector',1043,0);
CREATE TABLE "kms_deployment" (id text,bundle_config_id text,apid_cluster_id text,data_scope_id text,bundle_config_name text,bundle_config_json text,config_json text,created blob,created_by text,updated blob,updated_by text,_change_selector text, primary key (id,bundle_config_id,apid_cluster_id,data_scope_id,_change_selector));
INSERT INTO "kms_deployment" VALUES('321e443b-9db9-4043-b987-1599e0cdd029','1b6a5e15-4bb8-4c8e-ae3d-63e6efb9ba85','bootstrap','dataScope1','gcp-test-bundle','{"id":"1b6a5e15-4bb8-4c8e-ae3d-63e6efb9ba85","created":"2017-02-27T07:40:57.810Z","createdBy":"fierrom@google.com","updated":"2017-02-27T07:40:57.810Z","updatedBy":"fierrom@google.com","name":"gcp-test-bundle","uri":"https://gist.github.com/mdobson/f9d537c5192a660f692affc294266df2/archive/234c7cbf227d769278bee9b06ace51d6062fe96b.zip","checksumType":"md5","checksum":"06fde116f0270b3734a48653d0cfb495"}','{}','2017-02-27 07:41:33.888+00:00','fierrom@google.com','2017-02-27 07:41:33.888+00:00','fierrom@google.com','bootstrap');
CREATE TABLE "kms_api_product" (id text,tenant_id text,name text,display_name text,description text,api_resources text,approval_type text,scopes text,proxies text,environments text,quota text,quota_time_unit text,quota_interval integer,created_at blob,created_by text,updated_at blob,updated_by text,_change_selector text, primary key (id,tenant_id,created_at,updated_at));
INSERT INTO "kms_api_product" VALUES('f5f07319-5104-471c-9df3-64b1842dbe00','43aef41d','test','test','','{/}','AUTO','{""}','{helloworld}','{test}','','',NULL,'2017-02-27 07:32:49.897+00:00','vbhangale@apigee.com','2017-02-27 07:32:49.897+00:00','vbhangale@apigee.com','43aef41d');
INSERT INTO "kms_api_product" VALUES('87a4bfaa-b3c4-47cd-b6c5-378cdb68610c','43aef41d','GregProduct','Greg''s Product','A product for testing Greg','{/**}','AUTO','{""}','{}','{test}','','',NULL,'2017-03-01 22:50:41.75+00:00','greg@google.com','2017-03-01 22:50:41.75+00:00','greg@google.com','43aef41d');
CREATE TABLE attributes (tenant_id text,entity_id text,cust_id text,org_id text,dev_id text,comp_id text,apiprdt_id text,app_id text,appcred_id text,name text,type text,value text,_change_selector text, primary key (tenant_id,tenant_id,entity_id,entity_id,name,type,type));
INSERT INTO "attributes" VALUES('43aef41d','ff0b5496-c674-4531-9443-ace334504f59','','ff0b5496-c674-4531-9443-ace334504f59','','','','','','features.isSmbOrganization','ORGANIZATION','true','43aef41d');
INSERT INTO "attributes" VALUES('43aef41d','ff0b5496-c674-4531-9443-ace334504f59','','ff0b5496-c674-4531-9443-ace334504f59','','','','','','features.mgmtGroup','ORGANIZATION','management-edgex','43aef41d');
INSERT INTO "attributes" VALUES('43aef41d','ff0b5496-c674-4531-9443-ace334504f59','','ff0b5496-c674-4531-9443-ace334504f59','','','','','','features.isEdgexEnabled','ORGANIZATION','true','43aef41d');
INSERT INTO "attributes" VALUES('43aef41d','ff0b5496-c674-4531-9443-ace334504f59','','ff0b5496-c674-4531-9443-ace334504f59','','','','','','features.isCpsEnabled','ORGANIZATION','true','43aef41d');
INSERT INTO "attributes" VALUES('43aef41d','f5f07319-5104-471c-9df3-64b1842dbe00','','','','','f5f07319-5104-471c-9df3-64b1842dbe00','','','access','APIPRODUCT','internal','43aef41d');
INSERT INTO "attributes" VALUES('43aef41d','f5f07319-5104-471c-9df3-64b1842dbe00','','','','','f5f07319-5104-471c-9df3-64b1842dbe00','','','test','APIPRODUCT','v1','43aef41d');
INSERT INTO "attributes" VALUES('43aef41d','8f5c9b86-0783-439c-b8e6-7ab9549e30e8','','','','','','8f5c9b86-0783-439c-b8e6-7ab9549e30e8','','DisplayName','APP','MitchTestApp','43aef41d');
INSERT INTO "attributes" VALUES('43aef41d','8f5c9b86-0783-439c-b8e6-7ab9549e30e8','','','','','','8f5c9b86-0783-439c-b8e6-7ab9549e30e8','','Notes','APP','','43aef41d');
INSERT INTO "attributes" VALUES('43aef41d','87c20a31-a504-4ed5-89a5-700adfbb0142','','','','','','87c20a31-a504-4ed5-89a5-700adfbb0142','','DisplayName','APP','MitchTestApp2','43aef41d');
INSERT INTO "attributes" VALUES('43aef41d','87c20a31-a504-4ed5-89a5-700adfbb0142','','','','','','87c20a31-a504-4ed5-89a5-700adfbb0142','','Notes','APP','','43aef41d');
INSERT INTO "attributes" VALUES('43aef41d','87a4bfaa-b3c4-47cd-b6c5-378cdb68610c','','','','','87a4bfaa-b3c4-47cd-b6c5-378cdb68610c','','','access','APIPRODUCT','public','43aef41d');
INSERT INTO "attributes" VALUES('43aef41d','be902c0c-c54b-4a65-85d6-358ff8639586','','','','','','be902c0c-c54b-4a65-85d6-358ff8639586','','DisplayName','APP','Greg''s Test App','43aef41d');
INSERT INTO "attributes" VALUES('43aef41d','be902c0c-c54b-4a65-85d6-358ff8639586','','','','','','be902c0c-c54b-4a65-85d6-358ff8639586','','Notes','APP','','43aef41d');
CREATE TABLE "kms_company" (id text,tenant_id text,name text,display_name text,status text,created_at blob,created_by text,updated_at blob,updated_by text,_change_selector text, primary key (id,tenant_id,tenant_id,name,created_at,updated_at));
CREATE TABLE "kms_organization" (id text,name text,display_name text,type text,tenant_id text,customer_id text,description text,created_at blob,created_by text,updated_at blob,updated_by text,_change_selector text, primary key (id,tenant_id,tenant_id,customer_id,created_at,updated_at));
INSERT INTO "kms_organization" VALUES('ff0b5496-c674-4531-9443-ace334504f59','edgex_gcp1','edgex_gcp1','paid','43aef41d','307eadd7-c6d7-4ec1-b433-59bcd22cd06d','','2017-02-25 00:17:58.159+00:00','vbhangale@apigee.com','2017-02-25 00:18:14.729+00:00','vbhangale@apigee.com','43aef41d');
CREATE TABLE "edgex_apid_cluster" (id text,name text,description text,umbrella_org_app_name text,created blob,created_by text,updated blob,updated_by text,_change_selector text, primary key (id,created_by,created_by,created_by,created_by,_change_selector));
INSERT INTO "edgex_apid_cluster" VALUES('bootstrap','mitch-gcp-cluster','','X-5NF3iDkQLtQt6uPp4ELYhuOkzL5BbSMgf3Gx','2017-02-27 07:39:22.179+00:00','fierrom@google.com','2017-02-27 07:39:22.179+00:00','fierrom@google.com','bootstrap');
CREATE TABLE "edgex_data_scope" (id text,apid_cluster_id text,scope text,org text,env text,org_scope text,env_scope text,created blob,created_by text,updated blob,updated_by text,_change_selector text, primary key (id,apid_cluster_id,apid_cluster_id,org,env,_change_selector));
INSERT INTO "edgex_data_scope" VALUES('dataScope1','bootstrap','43aef41d','edgex_gcp1','test','org_scope_1','env_scope_1','2017-02-27 07:40:25.094+00:00','fierrom@google.com','2017-02-27 07:40:25.094+00:00','fierrom@google.com','bootstrap');
INSERT INTO "edgex_data_scope" VALUES('dataScope2','bootstrap','43aef41d','edgex_gcp1','test','org_scope_1','env_scope_2','2017-02-27 07:40:25.094+00:00','fierrom@google.com','2017-02-27 07:40:25.094+00:00','sendtofierro@gmail.com','bootstrap');
CREATE TABLE "kms_app_credential" (id text,tenant_id text,consumer_secret text,app_id text,method_type text,status text,issued_at blob,expires_at blob,app_status text,scopes text,created_at blob,created_by text,updated_at blob,updated_by text,_change_selector text, primary key (id,tenant_id,app_id,issued_at,expires_at));
INSERT INTO "kms_app_credential" VALUES('xA9QylNTGQxKGYtHXwvmx8ldDaIJMAEx','43aef41d','lscGO3lfs3zh8iQ','87c20a31-a504-4ed5-89a5-700adfbb0142','','APPROVED','2017-02-27 07:45:22.774+00:00','','','{}','2017-02-27 07:45:22.774+00:00','-NA-','2017-02-27 07:45:22.877+00:00','-NA-','43aef41d');
INSERT INTO "kms_app_credential" VALUES('ds986MejQqoWRSSeC0UTIPSJ3rtaG2xv','43aef41d','5EBOSSQrLOLO9siN','8f5c9b86-0783-439c-b8e6-7ab9549e30e8','','APPROVED','2017-02-27 07:43:23.263+00:00','','','{}','2017-02-27 07:43:23.263+00:00','-NA-','2017-02-27 07:48:16.717+00:00','-NA-','43aef41d');
INSERT INTO "kms_app_credential" VALUES('DMh0uQOPA5rbhl4YTnGvBAzGzOGuMH3A','43aef41d','MTfK8xscShhnops','be902c0c-c54b-4a65-85d6-358ff8639586','','APPROVED','2017-03-01 22:52:28.019+00:00','','','{}','2017-03-01 22:52:28.019+00:00','-NA-','2017-03-01 22:52:28.022+00:00','-NA-','43aef41d');
CREATE TABLE "kms_company_developer" (tenant_id text,company_id text,developer_id text,roles text,created_at blob,created_by text,updated_at blob,updated_by text,_change_selector text, primary key (tenant_id,company_id,developer_id));
CREATE TABLE "kms_app" (id text,tenant_id text,name text,display_name text,access_type text,callback_url text,status text,app_family text,company_id text,developer_id text,parent_id text,type text,created_at blob,created_by text,updated_at blob,updated_by text,_change_selector text, primary key (id,tenant_id,tenant_id,name,name,app_family,parent_id,created_at,updated_at));
INSERT INTO "kms_app" VALUES('87c20a31-a504-4ed5-89a5-700adfbb0142','43aef41d','MitchTestApp2','','','','APPROVED','default','','8a350848-0aba-4dcc-aa60-97903efb42ef','8a350848-0aba-4dcc-aa60-97903efb42ef','DEVELOPER','2017-02-27 07:45:21.586+00:00','fierrom@google.com' ||
 '','2017-02-27 07:45:21.586+00:00','fierrom@google.com' ||
  '','43aef41d');
INSERT INTO "kms_app" VALUES('8f5c9b86-0783-439c-b8e6-7ab9549e30e8','43aef41d','MitchTestApp','','','','APPROVED','default','','8a350848-0aba-4dcc-aa60-97903efb42ef','8a350848-0aba-4dcc-aa60-97903efb42ef','DEVELOPER','2017-02-27 07:43:22.301+00:00','fierrom@google.com' ||
 '','2017-02-27 07:48:18.964+00:00','fierrom@google.com' ||
  '','43aef41d');
INSERT INTO "kms_app" VALUES('be902c0c-c54b-4a65-85d6-358ff8639586','43aef41d','GregTestApp','','','','APPROVED','default','','046974c2-9ae5-4452-a42f-bb6657e6cdbe','046974c2-9ae5-4452-a42f-bb6657e6cdbe','DEVELOPER','2017-03-01 22:52:27.615+00:00','greg@google.com','2017-03-01 22:52:27.615+00:00','greg@google.com','43aef41d');
CREATE TABLE "kms_app_credential_apiproduct_mapper" (tenant_id text,appcred_id text,app_id text,apiprdt_id text,status text,_change_selector text, primary key (tenant_id,appcred_id,app_id,apiprdt_id));
INSERT INTO "kms_app_credential_apiproduct_mapper" VALUES('43aef41d','ds986MejQqoWRSSeC0UTIPSJ3rtaG2xv','8f5c9b86-0783-439c-b8e6-7ab9549e30e8','f5f07319-5104-471c-9df3-64b1842dbe00','APPROVED','43aef41d');
INSERT INTO "kms_app_credential_apiproduct_mapper" VALUES('43aef41d','xA9QylNTGQxKGYtHXwvmx8ldDaIJMAEx','87c20a31-a504-4ed5-89a5-700adfbb0142','f5f07319-5104-471c-9df3-64b1842dbe00','APPROVED','43aef41d');
INSERT INTO "kms_app_credential_apiproduct_mapper" VALUES('43aef41d','DMh0uQOPA5rbhl4YTnGvBAzGzOGuMH3A','be902c0c-c54b-4a65-85d6-358ff8639586','87a4bfaa-b3c4-47cd-b6c5-378cdb68610c','APPROVED','43aef41d');
CREATE TABLE "kms_developer" (id text,tenant_id text,username text,first_name text,last_name text,password text,email text,status text,encrypted_password text,salt text,created_at blob,created_by text,updated_at blob,updated_by text,_change_selector text, primary key (id,tenant_id,tenant_id,username,email,created_at,updated_at));
INSERT INTO "kms_developer" VALUES('8a350848-0aba-4dcc-aa60-97903efb42ef','43aef41d','mitchfierro','Mitch','Fierro','','fierrom@google.com','ACTIVE','','','2017-02-27 07:43:00.281+00:00','fierrom@google.com' ||
 '','2017-02-27 07:43:00.281+00:00','fierrom@google.com' ||
  '','43aef41d');
INSERT INTO "kms_developer" VALUES('6ab21170-6bac-481d-9be1-9fda02bdd1da','43aef41d','adikgcp','gcp','dev','','adikancherla@gcp.com','ACTIVE','','','2017-02-27 23:50:24.426+00:00','akancherla@apigee.com','2017-02-27 23:50:24.426+00:00','akancherla@apigee.com','43aef41d');
INSERT INTO "kms_developer" VALUES('046974c2-9ae5-4452-a42f-bb6657e6cdbe','43aef41d','gregbrail','Greg','Brail','','gregbrail@google.com','ACTIVE','','','2017-03-01 22:51:40.602+00:00','greg@google.com','2017-03-01 22:51:40.602+00:00','greg@google.com','43aef41d');
COMMIT;
