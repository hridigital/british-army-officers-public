
CREATE INDEX IF NOT EXISTS idx_row_idkey ON row(idkey);

UPDATE link SET afile = (SELECT file FROM row WHERE link.aidkey = row.idkey);
UPDATE link SET bfile = (SELECT file FROM row WHERE link.bidkey = row.idkey);

UPDATE link SET asheet = (SELECT sheet FROM row WHERE link.aidkey = row.idkey);
UPDATE link SET bsheet = (SELECT sheet FROM row WHERE link.bidkey = row.idkey);

UPDATE link SET arow = (SELECT row FROM row WHERE link.aidkey = row.idkey);
UPDATE link SET brow = (SELECT row FROM row WHERE link.bidkey = row.idkey);

UPDATE link SET areg_name = (SELECT reg_name FROM row WHERE link.aidkey = row.idkey);
UPDATE link SET breg_name = (SELECT reg_name FROM row WHERE link.bidkey = row.idkey);

UPDATE link SET areg_regiment = (SELECT reg_regiment FROM row WHERE link.aidkey = row.idkey);
UPDATE link SET breg_regiment = (SELECT reg_regiment FROM row WHERE link.bidkey = row.idkey);

UPDATE link SET areg_rank = (SELECT reg_rank FROM row WHERE link.aidkey = row.idkey);
UPDATE link SET breg_rank = (SELECT reg_rank FROM row WHERE link.bidkey = row.idkey);

UPDATE link SET areg_date = (SELECT reg_date FROM row WHERE link.aidkey = row.idkey);
UPDATE link SET breg_date = (SELECT reg_date FROM row WHERE link.bidkey = row.idkey);

UPDATE link SET adate2 = (SELECT date2 FROM row WHERE link.aidkey = row.idkey);
UPDATE link SET bdate2 = (SELECT date2 FROM row WHERE link.bidkey = row.idkey);

UPDATE link SET aannotations = (SELECT annotations FROM row WHERE link.aidkey = row.idkey);
UPDATE link SET bannotations = (SELECT annotations FROM row WHERE link.bidkey = row.idkey);

UPDATE link SET adeleted = (SELECT deleted FROM row WHERE link.aidkey = row.idkey);
UPDATE link SET bdeleted = (SELECT deleted FROM row WHERE link.bidkey = row.idkey);

UPDATE link SET ahandwritten = (SELECT handwritten FROM row WHERE link.aidkey = row.idkey);
UPDATE link SET bhandwritten = (SELECT handwritten FROM row WHERE link.bidkey = row.idkey);

UPDATE link SET afileyear = (SELECT fileyear FROM row WHERE link.aidkey = row.idkey);
UPDATE link SET bfileyear = (SELECT fileyear FROM row WHERE link.bidkey = row.idkey);

UPDATE link SET asurname = (SELECT surname FROM row WHERE link.aidkey = row.idkey);
UPDATE link SET bsurname = (SELECT surname FROM row WHERE link.bidkey = row.idkey);

UPDATE link SET agiven = (SELECT given FROM row WHERE link.aidkey = row.idkey);
UPDATE link SET bgiven = (SELECT given FROM row WHERE link.bidkey = row.idkey);

UPDATE link SET arank_lvl = (SELECT rank_lvl FROM row WHERE link.aidkey = row.idkey);
UPDATE link SET brank_lvl = (SELECT rank_lvl FROM row WHERE link.bidkey = row.idkey);

UPDATE link SET aorig_sheet = (SELECT orig_sheet FROM row WHERE link.aidkey = row.idkey);
UPDATE link SET borig_sheet = (SELECT orig_sheet FROM row WHERE link.bidkey = row.idkey);

UPDATE link SET aorig_idkey = (SELECT orig_idkey FROM row WHERE link.aidkey = row.idkey);
UPDATE link SET borig_idkey = (SELECT orig_idkey FROM row WHERE link.bidkey = row.idkey);

UPDATE link SET apage = (SELECT page FROM row WHERE link.aidkey = row.idkey);
UPDATE link SET bpage = (SELECT page FROM row WHERE link.bidkey = row.idkey);

UPDATE link SET aname = (SELECT name FROM row WHERE link.aidkey = row.idkey);
UPDATE link SET bname = (SELECT name FROM row WHERE link.bidkey = row.idkey);

