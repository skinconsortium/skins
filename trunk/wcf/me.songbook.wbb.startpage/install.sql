DROP TABLE IF EXISTS wcf1_startpage;
CREATE TABLE wcf1_startpage
(
pageID		INT( 10 )	unsigned NULL AUTO_INCREMENT ,
packageID	INT( 10 )	unsigned NOT NULL ,
pageName	VARCHAR( 255 )	NOT NULL ,
request		VARCHAR( 255 )	NOT NULL ,
PRIMARY KEY	( pageID )
) ENGINE = MYISAM   DEFAULT CHARSET=utf8;

INSERT INTO wcf1_startpage
(
pageID , packageID , pageName , request 
)
VALUES
(
NULL , '0', 'wcf.acp.startpage.settings.request.status.custom', 'page=Index'
);