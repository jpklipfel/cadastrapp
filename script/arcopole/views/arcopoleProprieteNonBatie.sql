-- Create view proprietenonbatie based on Arcopole Models

CREATE OR REPLACE VIEW #schema_cadastrapp.proprietenonbatie AS 
	SELECT 
		proprietenonbatie.id_local, 
		proprietenonbatie.parcelle,
		proprietenonbatie.comptecommunal, 
		proprietenonbatie.dnupro, 
		proprietenonbatie.cgocommune,
		proprietenonbatie.ccopre, 
		proprietenonbatie.ccosec, 
		proprietenonbatie.dnupla, 
		proprietenonbatie.jdatat, 
		proprietenonbatie.dnvoiri, 
		proprietenonbatie.dindic, 
		proprietenonbatie.natvoi, 
		proprietenonbatie.dvoilib, 
		proprietenonbatie.ccoriv, 
		proprietenonbatie.dparpi, 
		proprietenonbatie.gpafpd, 
		proprietenonbatie.ccostn, 
		proprietenonbatie.ccosub, 
		proprietenonbatie.cgrnum, 
		proprietenonbatie.dsgrpf, 
		proprietenonbatie.dclssf, 
		proprietenonbatie.cnatsp, 
		proprietenonbatie.dcntsf, 
		proprietenonbatie.drcsuba, 
		proprietenonbatie.pdl, 
		proprietenonbatie.dnulot, 
		proprietenonbatie.ccolloc, 
		proprietenonbatie.gnextl, 
		proprietenonbatie.jandeb, 
		proprietenonbatie.janimp, 
		proprietenonbatie.fcexb, 
		proprietenonbatie.pexb, 
		proprietenonbatie.dreflf
	FROM dblink('host=#DBHost_arcopole dbname=#DBName_arcopole user=#DBUser_arcopole password=#DBpasswd_arcopole'::text, 
		'select 
			l.id_local,
			p.codparc as parcelle,
			l.dnupro as comptecommunal , 
			l.dnupro,
			p.codcomm as cgocommune,
			substr(p.codparc,7,3) as ccopre,
			substr(p.codparc,10,2) ccosec ,
			p.dnupla,
			l.jdatat,
			inv.dnvoiri,inv.dindic,
			v.nature as natvoi,
			inv.dvoilib,
			inv.ccoriv,
			p.dparpi,
			p.GPARNF gpafpd,
			suf.ccostn,
			suf.ccosub,
			suf.cgrnum,
			suf.dsgrpf,
			suf.dclssf,
			suf.cnatsp,
			suf.dcntsf,
			suf.drcsuba,
			p.DNUPDL as pdl,
			suf.DNulot,
			sufex.ccolloc,
			pevx.gnextl,
			pevx.jandeb,
			pevx.janimp,
			pevx.FCEXBA2 as fcexb,
			pevx.pexb,
			p.dreflf
		from #DBSchema_arcopole.dgi_local l
			left join #DBSchema_arcopole.dgi_invar inv on l.id_local=inv.invar
			left join #DBSchema_arcopole.dgi_nbati p on inv.codparc=p.codparc
			left join #DBSchema_arcopole.dgi_voie v on v.id_voie=inv.id_voie
			left join #DBSchema_arcopole.dgi_suf suf on suf.codlot=l.codlot and suf.CODPARC=p.CODPARC
			left join #DBSchema_arcopole.dgi_pev pev on pev.codlot=inv.codlot and pev.invar=inv.invar
			left join #DBSchema_arcopole.dgi_exosuf sufex on sufex.id_suf=suf.id_suf and sufex.CODPARC=suf.CODPARC
			left join #DBSchema_arcopole.dgi_exopev pevx on pevx.id_pev=pev.id_pev'::text) 
	proprietenonbatie(
		id_local character varying(16), 
		parcelle character varying(19), 
		comptecommunal character varying(12), 
		dnupro character varying(12), 
		cgocommune character varying(6), 
		ccopre text, 
		ccosec text, 
		dnupla integer, 
		jdatat character varying(8), 
		dnvoiri character varying(4), 
		dindic character varying(1), 
		natvoi character varying(4), 
		dvoilib character varying(30), 
		ccoriv character varying(4), 
		dparpi character varying(4), 
		gpafpd character varying(1), 
		ccostn character varying(1), 
		ccosub character varying(2), 
		cgrnum character varying(2), 
		dsgrpf character varying(2), 
		dclssf character varying(2), 
		cnatsp character varying(5), 
		dcntsf character varying(9), 
		drcsuba character varying(10), 
		pdl character varying(3), 
		dnulot character varying(7), 
		ccolloc character varying(2), 
		gnextl character varying(2), 
		jandeb character varying(4), 
		janimp character varying(4), 
		fcexb character varying(9), 
		pexb character varying(5), 
		dreflf character varying(9));

ALTER TABLE #schema_cadastrapp.proprietenonbatie OWNER TO #user_cadastrapp;
