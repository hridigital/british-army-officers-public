
DROP TABLE IF EXISTS manual;
.mode tabs
.import data/manual_link/manual_link.current.tsv manual

/* Set existing links which have been manually rejected to link_category 6 */
UPDATE link SET link_category = 6 WHERE EXISTS (SELECT decision FROM manual WHERE link.idkey = manual.linkkey AND manual.decision = 'reject');

/* Set existing links which have been manually confirmed to link_category -1 */
UPDATE link SET link_category = -1 WHERE EXISTS (SELECT decision FROM manual WHERE link.idkey = manual.linkkey AND manual.decision = 'confirm');

/* Add new links which have been manually confirmed */
INSERT INTO link
SELECT
linkkey, /* idkey */
aidkey, /* aidkey */
bidkey, /* bidkey */
-1, /* link_category */
null, /* link_score */
null, /* link_log */
null, /* afile */
null, /* bfile */
null, /* asheet */
null, /* bsheet */
null, /* arow */
null, /* brow */
null, /* areg_name */
null, /* breg_name */
null, /* areg_regiment */
null, /* breg_regiment */
null, /* areg_rank */
null, /* breg_rank */
null, /* areg_date */
null, /* breg_date */
null, /* adate2 */
null, /* bdate2 */
null, /* aannotations */
null, /* bannotations */
null, /* adeleted */
null, /* bdeleted */
null, /* ahandwritten */
null, /* bhandwritten */
null, /* afileyear */
null, /* bfileyear */
null, /* asurname */
null, /* bsurname */
null, /* agiven */
null, /* bgiven */
null, /* arank_lvl */
null, /* brank_lvl */
null, /* aorig_sheet */
null, /* borig_sheet */
null, /* aorig_idkey */
null, /* borig_idkey */
null, /* apage */
null, /* bpage */
null, /* aname */
null /* bname */
FROM manual WHERE decision = 'confirm' AND NOT EXISTS (SELECT link.idkey FROM link WHERE manual.linkkey = link.idkey);

