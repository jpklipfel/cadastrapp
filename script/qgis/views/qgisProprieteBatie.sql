-- Create view proprietebatie based on Qgis Models

CREATE MATERIALIZED VIEW #schema_cadastrapp.proprietebatie AS 
	SELECT proprietebatie.id_local,
		proprietebatie.comptecommunal,
		proprietebatie.dnupro,
		proprietebatie.cgocommune,
		proprietebatie.ccopre,
		proprietebatie.ccosec,
		proprietebatie.dnupla,
		proprietebatie.jdatat,
		proprietebatie.voie,
		proprietebatie.dnvoiri,
		proprietebatie.dindic,
		proprietebatie.natvoi,
		proprietebatie.ccovoi,
		proprietebatie.dvoilib,
		proprietebatie.ccoriv,
		proprietebatie.dnubat,
		proprietebatie.descr,
		proprietebatie.dniv,
		proprietebatie.dpor,
		proprietebatie.invar,
		proprietebatie.ccoaff,
		proprietebatie.ccoeva,
		proprietebatie.cconlc,
		proprietebatie.dcapec,
		proprietebatie.ccolloc,
		proprietebatie.gnextl,
		proprietebatie.jandeb,
		proprietebatie.janimp,
		proprietebatie.mvltieomx,
		proprietebatie.bateom,
		proprietebatie.jannat,
		proprietebatie.revcad,
		proprietebatie.rcexba2,
		proprietebatie.rcbaia_tse,
		proprietebatie.rcbaia_com,
		proprietebatie.rcbaia_dep,
		proprietebatie.rcbaia_gp,
		proprietebatie.pexb,
		proprietebatie.parcelle
	FROM dblink('host=#DBHost_qgis dbname=#DBName_qgis user=#DBUser_qgis password=#DBpasswd_qgis'::text,  
		'select 
			l.local00 as id_local,
			c.comptecommunal,
			c.dnupro,
			c.ccodep || c.ccodir ||	c.ccocom as cgocommune,
			ltrim(l.ccopre) as ccopre,
			ltrim(l.ccosec) as ccosec,
			ltrim(l.dnupla, ''0'') as dnupla,
			COALESCE(to_char(l.jdatat, ''DD/MM/YYYY''), '''') as jdatat,
			v.voie,
			ltrim(l.dnvoiri, ''0'') as dnvoiri,
			l00.dindic,
			v.natvoi,
			l.ccovoi,
			v.libvoi as dvoilib,
			l00.ccoriv,
			l00.dnubat,
			l00.descr,
			l00.dniv,
			l00.dpor,
			l00.invar,
			pev.ccoaff,
			l.ccoeva,
			cconlc.cconlc_lib as cconlc,
			pev.dcapec,
			pevx.ccolloc,
			pevx.gnextl,
			pevx.jandeb,
			pevx.janimp,
			pevtax.mvltieomx,
			pevtax.bateom,
			l.jannat,
			ROUND(CEIL(CAST(pev.dvlpera AS numeric)/2),2) as revcad,
			ROUND(CAST(pevx.rcexba2 AS numeric),2) as rcexba2,
			ROUND(CAST(pevtax.tse_bipevla AS numeric),2) as rcbaia_tse,
			ROUND(CAST(pevtax.co_bipevla AS numeric),2) as rcbaia_com,
			ROUND(CAST(pevtax.de_bipevla AS numeric),2) as rcbaia_dep,
			ROUND(CAST(pevtax.gp_bipevla AS numeric),2) as rcbaia_gp,
			pevx.pexb,
			l.parcelle
		from #DBSchema_qgis.comptecommunal c
			left join #DBSchema_qgis.local10 as l on c.comptecommunal=l.comptecommunal
			left join #DBSchema_qgis.local00 as l00 on l00.local00=l.local00
			left join #DBSchema_qgis.voie as v on  l.voie=v.voie
			left join #DBSchema_qgis.pev  on pev.local10=l.local10
			left join #DBSchema_qgis.pevexoneration as pevx on pevx.pev=pev.pev
			left join #DBSchema_qgis.pevtaxation as pevtax on pevtax.pev=pev.pev
			left join #DBSchema_qgis.cconlc on cconlc.cconlc = l.cconlc
		order by c.ccodep,c.ccodir,c.ccocom,dnupla,v.voie,v.libvoi,l00.dnubat,l00.descr,l00.dniv,l00.dpor'::text) 
	proprietebatie(
		id_local character varying(14), 
		comptecommunal character varying(15), 
		dnupro character varying(6), 
		cgocommune character varying(6), 
		ccopre character varying(3), 
		ccosec character varying(2), 
		dnupla character varying(4), 
		jdatat character varying(10), 
		voie character varying(19), 
		dnvoiri character varying(4), 
		dindic character varying(1), 
		natvoi character varying(4), 
		ccovoi character varying(5), 
		dvoilib character varying(26),
		ccoriv character varying(4), 
		dnubat character varying(2), 
		descr character varying(2), 
		dniv character varying(2), 
		dpor character varying(5), 
		invar character varying(10),
  		ccoaff character varying(1), 
  		ccoeva character varying(1), 
  		cconlc character varying, 
  		dcapec character varying(2), 
  		ccolloc character varying(2), 
		gnextl character varying(2), 
		jandeb character varying(4), 
		janimp character varying(4),
		mvltieomx integer, 
		bateom integer,
		jannat character varying(4),
		revcad numeric(10,2),
		rcexba2 numeric(10,2),
		rcbaia_tse numeric(10,2),
		rcbaia_com numeric(10,2),
		rcbaia_dep numeric(10,2),
		rcbaia_gp numeric(10,2),
		pexb numeric,
		parcelle  character varying(19));

ALTER TABLE #schema_cadastrapp.proprietebatie OWNER TO #user_cadastrapp;
