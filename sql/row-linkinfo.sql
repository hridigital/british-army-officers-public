/* Now we are back to a system where each row should only have one link, copying some link data to the row table makes sense */

UPDATE row SET link_category = (SELECT link_category FROM link WHERE link.aidkey = row.idkey);
UPDATE row SET linked_to_rowid = (SELECT bidkey FROM link WHERE link.aidkey = row.idkey);
/*UPDATE row SET link_log = (SELECT link_log FROM link WHERE link.aidkey = row.idkey);*/

