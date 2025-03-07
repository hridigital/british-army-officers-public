
.headers on
.mode csv
.output data/data-service/row.csv
SELECT idkey, file, sheet, row, regiment, rank, name, person, page, deleted, handwritten, date, date2, annotations, reg_regiment, reg_rank, rank_lvl, surname, given, middlenames, title, namesuffix, nickname, fileyear, reg_date, link_category, link_score, link_log, row_count, reg_name, linked_to_file, linked_to_sheet, linked_to_row, linked_to_rowid, orig_sheet, orig_idkey FROM row;
.output data/data-service/person.csv
SELECT idkey, reg_name, given, surname, row_count FROM person;
.output stdout
