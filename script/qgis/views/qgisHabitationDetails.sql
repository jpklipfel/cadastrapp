-- View: cadastrapp_qgis.deschabitation

drop view #schema_cadastrapp.deschabitation;

create view #schema_cadastrapp.deschabitation as SELECT *
	FROM dblink('host=#DBHost_qgis dbname=#DBName_qgis user=#DBUser_qgis password=#DBpasswd_qgis'::text,
		'select pev.pev,pev.annee,pev.invar,
		pev.dnupev,pev.ccoaff,''Partie principale d''''habitation'' as dnupev_lib,ccoaff.ccoaff_lib,
		pevp.dnudes,pevp.detent,pevp.dsupdc,pevp.dnbniv,pevp.dnbpdc,dnbppr,
		dnbsam,
		dnbcha,
		dnbcu8,
		dnbcu9,
		dnbsea,
		dnbann,
		dnbbai,
		dnbdou,
		dnblav,
		dnbwc,
		geaulc,
		gelelc,
		ggazlc,
		gchclc,
		gteglc,
		gesclc,
		gasclc,
		gvorlc,
		cconad1.cconad_lib as cconad_ga,
		cconad2.cconad_lib as cconav_cv,
		cconad3.cconad_lib as cconad_gr,
		cconad4.cconad_lib as cconav_tr,
		dep1_dsueic  as dsueic_ga,
		dep2_dsueic  as dsueic_cv,dep3_dsueic  
		as dsueic_gr,
		dep4_dsueic  as dsueic_tr
			from pev
		left join pevprincipale pevp on pev.pev=pevp.pev
		left join ccoaff on pev.ccoaff=ccoaff.ccoaff
		left join cconad cconad1 on pevp.dep1_cconad=cconad1.cconad 
		left join cconad cconad2 on pevp.dep2_cconad=cconad2.cconad 
		left join cconad cconad3 on pevp.dep3_cconad=cconad3.cconad 
		left join cconad cconad4 on pevp.dep4_cconad=cconad4.cconad 
		order by annee,invar'::text) 
	deschabitation (
		pev character varying(17),
		annee character varying(4),
		invar character varying(10),
		dnupev character varying(3),
		ccoaff character varying(1),
		dnupev_lib character varying(50),
		ccoaff_lib character varying(150),
		dnudes character varying(3),
		detent character varying(1),
		dsupdc integer,
		dnbniv character varying(2),
		dnbpdc character varying(2),
		dnbppr character varying(2),
		dnbsam character varying(2),
		dnbcha character varying(2),
		dnbcu8 character varying(2),
		dnbcu9 character varying(2),
		dnbsea character varying(2),
		dnbann character varying(2),
		dnbbai character varying(2),
		dnbdou character varying(2),
		dnblav character varying(2),
		dnbwc character varying(2),
		geaulc character varying(1),
		gelelc character varying(1),
		ggazlc character varying(1),
		gchclc character varying(1),
		gteglc character varying(1),
		gesclc character varying(1),
		gasclc character varying(1),
		gvorlc character varying(1),
		cconad_ga  character varying(150),
		cconav_cv  character varying(150),
		cconad_gr character varying(150),
		cconav_tr character varying(150),
		dsueic_ga integer,
		dsueic_cv integer,
		dsueic_gr  integer,
		dsueic_tr  integer
		);

ALTER TABLE #schema_cadastrapp.deschabitation OWNER TO #user_cadastrapp;

-- View: cadastrapp_qgis.descproffessionnel

drop view #schema_cadastrapp.descproffessionnel;

create or replace view  #schema_cadastrapp.descproffessionnel as select *
	FROM dblink('host=#DBHost_qgis dbname=#DBName_qgis user=#DBUser_qgis password=#DBpasswd_qgis'::text,
		'select pev,invar,annee,dnudes,vsurzt 
			from pevprofessionnelle order by annee,invar'::text) 
	descproffessionnel (
		pev character varying(17),
		invar character varying(10),
		annee character varying(4),
		dnudes character varying(3),
		vsurzt integer
	);

ALTER TABLE #schema_cadastrapp.descproffessionnel OWNER TO #user_cadastrapp;


-- View: cadastrapp_qgis.descdependance

drop view #schema_cadastrapp.descdependance;

create or replace view  #schema_cadastrapp.descdependance as select *
	FROM dblink('host=#DBHost_qgis dbname=#DBName_qgis user=#DBUser_qgis password=#DBpasswd_qgis'::text,
		'select pev,invar,annee,dnudes,
		cconad_lib,
		dsudep,
		dnbbai,
		dnbdou,
		dnblav,
		dnbwc,
		geaulc,
		gelelc,
		gchclc
			from pevdependances
		left join cconad on pevdependances.cconad=cconad.cconad
		order by annee,invar'::text)
	descdependance (
		pev character varying(17),
		invar character varying(10),
		annee character varying(4),
		dnudes character varying(3),
		cconad_lib  character varying(150),
		dsudep integer,
		dnbbai character varying(2),
		dnbdou character varying(2),
		dnblav character varying(2) ,
		dnbwc character varying(2),
		geaulc character varying(1),
		gelelc  character varying(1),
		gchclc  character varying(1)
	);

ALTER TABLE #schema_cadastrapp.descdependance OWNER TO #user_cadastrapp;


