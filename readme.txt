
Source code for the British Army Officers project
-------------------------------------------------

More information about this project can be found here: https://www.dhi.ac.uk/projects/british-army-officers/

The code in this repository is intended to run inside a python virtual environment. To create this environment, run the following commands in a UNIX-like shell:

python3 -m venv .venv
source .venv/bin/activate
pip install -U openpyxl
pip install -U tqdm
pip install -U strsimpy
pip install -U nameparser
pip install -U rapidfuzz

The code in this repository can be used to ingest the xlsx files contained in the data/drive folder into an SQLite database (https://www.sqlite.org/), apply regularisation to various fields, and then attempt to deduce which spreadsheet rows might refer to the same historial people, using rules implemented in the file python/match.py.

The database tables resulting from this process can be queried at the project website, accompanied by background material placing them in their historical context:

https://www.georgianarmyofficers.org/

The process of ingesting, regularising and linking the spreadsheet files uses recipes from the accompanying Makefile. It is intended to run in a python virtual environment (see above) in a UNIX-like shell. The following commands and notes provide a step-by-step guide to the full process:

# Enter the python virtual environment (if not already in it, see above).
source ../dhids/.venv/bin/activate

# Ingest all the spreadsheet files.
make sheet-ingest-all

# You can query the database interactively at any point:
sqlite3 british-army-officers.db
SELECT COUNT(*) FROM row;
# Total rows at this point should be 639,099
.quit

# Regularise the data. This script regularises names, regiments, ranks and dates throughout the row table.
python python/reg_cmd.py re-reg

# Calculate the most common names. This information is used to make decisions in the linking process.
python python/reg_cmd.py common

# Ingest the most recent copy of manual links made by the project staff.
sqlite3 british-army-officers.db
.read sql/manual-links-populate.sql
SELECT COUNT(*) FROM manual;
# Total manual links should be 7,084
.quit

# Now we begin the linking process.
# We assume that some sheets will not contain duplicates (the same person twice in a year), we call these "Category A" sheets.
# "Category B" sheets are the opposite: Each person in them should definitely be repeated in a Category A sheet for that year.
# "Category C" sheets are where a person may or may not also be in a Category A sheet.
# Please see the file 'British Army Officers Linking System.pdf' for more information.
# 'sheet 99' is a concept whereby we use this logic to attempt to create a list of historical people for each year without duplications, before we try to link people between years.

python python/sheet.py manual-test pre99-confirm # Applies any manual links which change the initial contents of sheet 99 (i.e. violate the assumption that Category A sheets do not contain duplicates)
python python/sheet.py manual-test pre99-reject
python python/sheet.py manual pre99-confirm
python python/sheet.py manual pre99-reject

sqlite3 british-army-officers.db
DELETE FROM row WHERE sheet = '99. All';
.read sql/sheet-99.sql
SELECT COUNT(*) FROM row;
# Total rows should be 1,132,855
.quit

# Link Category C sheets to Category A sheets.
make sheet-link-internal-stage-one-all

sqlite3 british-army-officers.db
SELECT COUNT(*) FROM link;
# Total links should be 94,720
.quit

python python/sheet.py manual-test stage-one-confirm # Link the Category C sheets to Sheet 99.
python python/sheet.py manual-test stage-one-reject
python python/sheet.py manual stage-one-confirm
python python/sheet.py manual stage-one-reject

sqlite3 british-army-officers.db
SELECT link_category, COUNT(*) FROM link GROUP BY link_category;
# -1   Manually Confirmed   134
# 0    High                 6,959
# 1    Good                 7,771
# 2    Fair                 16,702
# 3    Low                  30,008
# 4    Failed               30,048
# 6    Manually Rejected    84
# 7    Better Link Found    3,014
.read sql/sheet-99-extend-undo.sql
.read sql/sheet-99-extend-count.sql # Preview the number of records which we will be inserting into row as new sheet-99 entries.
# Should be 33,146
.read sql/sheet-99-extend.sql # Avoiding introducing duplicates to sheet-99 depends on good stage one linking.
# Total rows should be 1,166,001
.quit

# Link Category B sheets to sheet 99.
make sheet-link-internal-stage-two-all

sqlite3 british-army-officers.db
SELECT COUNT(*) FROM link;
# Total links should be 111,466
.quit

python python/sheet.py manual-test stage-two-confirm # Links the Category B sheets to Sheet 99.
python python/sheet.py manual-test stage-two-reject # These sheets should *never* be able to get into Sheet 99.
python python/sheet.py manual stage-two-confirm
python python/sheet.py manual stage-two-reject

# Internal links (links within a year) should only point to sheet 99. This can sometimes be violated by the handwritten sheets.
# The following command redirects all internal links to point to the sheet 99 version of the bidkey, or its successor sheet 99 record if it itself is linked.
python python/sheet.py internal-link-redirect

sqlite3 british-army-officers.db
SELECT link_category, COUNT(*) FROM link GROUP BY link_category;
# -1   Manually Confirmed   134
# 0    High                 7,342
# 1    Good                 8,359
# 2    Fair                 17,089
# 3    Low                  33,577
# 4    Failed               41,516
# 6    Manually Rejected    84
# 7    Better Link Found    3,365
SELECT COUNT(*) FROM link WHERE substr(idkey, 1, 2) == '99';
DELETE FROM link WHERE substr(idkey, 1, 2) == '99';
.quit

# We are now finally ready to link between years.
make sheet-link-external-all

sqlite3 british-army-officers.db
SELECT COUNT(*) FROM link;
# Total links should be 628,989
.quit

python python/sheet.py manual-test external-confirm # Creates links between Sheet 99s and Sheet 99s in previous years only. No other type of external link should exist.
python python/sheet.py manual-test external-reject
python python/sheet.py manual external-confirm
python python/sheet.py manual external-reject

sqlite3 british-army-officers.db
# SELECT aidkey, COUNT(*) c FROM link GROUP BY aidkey HAVING c > 1; # Check that no aidkeys have more than one link
.read sql/link-hydrate.sql
.read sql/new-appointments.sql # Uses simple rules to determine if unlinked rows are likely to be newly appointed officers and marks them accordingly.
SELECT link_category, COUNT(*) FROM link GROUP BY link_category;
# -1   Manually Confirmed   6,893
# 0    High                 340,833
# 1    Good                 58,802
# 2    Fair                 55,886
# 3    Low                  38,097
# 4    Failed               79,725
# 5    New Appointment      21,912
# 6    Manually Rejected    114
# 7    Better Link Found    26,727
.quit

# Finally, use the link table to calculate our theoretical historical individuals.
python python/sheet.py person

sqlite3 british-army-officers.db
SELECT COUNT(*) FROM person;
# Total people should be 92,892
.read sql/row-linkinfo.sql # Hydrate the row records with more information about their links, for more convenient analysis.
.quit

