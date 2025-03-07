
get-manual-links:
	ssh sa_hi1jm@hridb2.shef.ac.uk "mysql -uroot -p dhids -e 'SELECT * FROM manual_link;' > /SANdata/backup/british-army-officers/manual_link.`date +%Y-%m-%d`.tsv"
	scp sa_hi1jm@hric:/SANdata/backup/british-army-officers/manual_link.`date +%Y-%m-%d`.tsv data/manual_link/manual_link.current.tsv

refresh-index:
	# source ../dhids/.venv/bin/activate
	python ../dhids/src/Python/dhidx.py delete $(INDEX); sleep 5
	python ../dhids/src/Python/dhidx.py create $(INDEX); sleep 10
	python ../dhids/src/Python/dhidx.py populate $(INDEX); sleep 5

refresh-index-sf6:
	# source ../data-service-indexer/.venv/bin/activate
	python ../data-service-indexer/src/Python/dhidx.py create $(INDEX); sleep 5
	python ../data-service-indexer/src/Python/dhidx.py populate $(INDEX); sleep 2
	python ../data-service-indexer/src/Python/dhidx.py alias-latest $(INDEX); sleep 2
	python ../data-service-indexer/src/Python/dhidx.py clean $(INDEX); sleep 2

sheet-ingest-file:
	# source .venv/bin/activate
	# make sheet-ingest-file FILE='data/drive/WO65 transcribed data/WO 65-40 Army List 1790.xlsx'
	# python python/sheet.py ingest-test 'data/drive/WO65 transcribed data/WO 65-40 Army List 1790.xlsx' '1. General and Field Officers'
	#
	python python/sheet.py ingest '$(FILE)' '1. General and Field Officers' '$(DBFILE)' '1. General and Field Officers'
	python python/sheet.py ingest '$(FILE)' '2. Aides-de-Camp' '$(DBFILE)' '2. Aides-de-Camp'
	python python/sheet.py ingest '$(FILE)' '3. Local Rank' '$(DBFILE)' '3. Local Rank'
	python python/sheet.py ingest '$(FILE)' '4. Staff & Miscellaneous' '$(DBFILE)' '4. Staff & Miscellaneous'
	python python/sheet.py ingest '$(FILE)' '5. Staff Officers' '$(DBFILE)' '5. Staff Officers'
	python python/sheet.py ingest '$(FILE)' '6. Honorary Distinctions' '$(DBFILE)' '6. Honorary Distinctions'
	python python/sheet.py ingest '$(FILE)' '7. Order of the Bath' '$(DBFILE)' '7. Order of the Bath'
	python python/sheet.py ingest '$(FILE)' '8. Guelphic Order' '$(DBFILE)' '8. Guelphic Order'
	python python/sheet.py ingest '$(FILE)' '9. Foreign Orders' '$(DBFILE)' '9. Foreign Orders'
	python python/sheet.py ingest '$(FILE)' '10. Regiments' '$(DBFILE)' '10. Regiments'
	python python/sheet.py ingest '$(FILE)' '11. Independent Companies' '$(DBFILE)' '11. Independent Companies'
	python python/sheet.py ingest '$(FILE)' '12. Invalids' '$(DBFILE)' '12. Invalids'
	python python/sheet.py ingest '$(FILE)' '13. Garrisons' '$(DBFILE)' '13. Garrisons'
	python python/sheet.py ingest '$(FILE)' '14. Royal Artillery etc' '$(DBFILE)' '14. Royal Artillery etc'
	python python/sheet.py ingest '$(FILE)' '15. Marines' '$(DBFILE)' '15. Marines'
	python python/sheet.py ingest '$(FILE)' '16. Officers on Full Pay' '$(DBFILE)' '16. Officers on Full Pay'
	python python/sheet.py ingest '$(FILE)' '17-21. Military Departments' '$(DBFILE)' '17-21. Military Departments'
	python python/sheet.py ingest '$(FILE)' '22. Reduced Corps' '$(DBFILE)' '22. Reduced Corps'
	python python/sheet.py ingest '$(FILE)' '23. Companies of Foot' '$(DBFILE)' '23. Companies of Foot'
	python python/sheet.py ingest '$(FILE)' '24. Companies of Invalids' '$(DBFILE)' '24. Companies of Invalids'
	python python/sheet.py ingest '$(FILE)' '25. Officers Unattached' '$(DBFILE)' '25. Officers Unattached'
	python python/sheet.py ingest '$(FILE)' '26. Foot Guards' '$(DBFILE)' '26. Foot Guards'
	python python/sheet.py ingest '$(FILE)' '27. Retired & Reduced' '$(DBFILE)' '27. Retired & Reduced'
	python python/sheet.py ingest '$(FILE)' '28-31. Officers on Half Pay' '$(DBFILE)' '28-31. Officers on Half Pay'
	python python/sheet.py ingest '$(FILE)' '32. New Independent Companies' '$(DBFILE)' '32. New Independent Companies'
	python python/sheet.py ingest '$(FILE)' '33. Succession of Colonels' '$(DBFILE)' '33. Succession of Colonels'
	python python/sheet.py ingest '$(FILE)' '34. Casualties' '$(DBFILE)' '34. Casualties'
	python python/sheet.py ingest '$(FILE)' '35. Alterations While Printing' '$(DBFILE)' '35. Alterations While Printing'
	python python/sheet.py ingest '$(FILE)' '36. Errata' '$(DBFILE)' '36. Errata'

sheet-ingest-handwritten:
	# python python/sheet.py ingest-test 'data/drive/WO65 transcribed data/Handwritten Text/WO 65-40 Army List 1790 - HANDWRITTEN v2.xlsx' '1. General and Field Officers' 'WO 65-40 Army List 1790' '61. General and Field Officers (handwritten)'
	# python python/sheet.py ingest-test 'data/drive/WO65 transcribed data/Handwritten Text/WO 65-40 Army List 1790 - HANDWRITTEN v2.xlsx' '10. Regiments' 'WO 65-40 Army List 1790' '70. Regiments (handwritten)'
	# python python/sheet.py ingest-test 'data/drive/WO65 transcribed data/Handwritten Text/WO 65-40 Army List 1790 - HANDWRITTEN v2.xlsx' '12. Invalids' 'WO 65-40 Army List 1790' '72. Invalids (handwritten)'
	# python python/sheet.py ingest-test 'data/drive/WO65 transcribed data/Handwritten Text/WO 65-40 Army List 1790 - HANDWRITTEN v2.xlsx' '13. Garrisons' 'WO 65-40 Army List 1790' '73. Garrisons (handwritten)'
	# python python/sheet.py ingest-test 'data/drive/WO65 transcribed data/Handwritten Text/WO 65-40 Army List 1790 - HANDWRITTEN v2.xlsx' '32. New Independent Companies' 'WO 65-40 Army List 1790' '92. New Independent Companies (handwritten)'
	# python python/sheet.py ingest-test 'data/drive/WO65 transcribed data/Handwritten Text/WO 65-41 Army List 1791 - HANDWRITTEN v2.xlsx' '11. Independent Companies' 'WO 65-41 Army List 1791' '71. Independent Companies (handwritten)'
	# python python/sheet.py ingest-test 'data/drive/WO65 transcribed data/Handwritten Text/WO 65-46 Army List 1796_Handwritten.xlsx' '14. Royal Artillery etc' 'WO 65-46 Army List 1796' '74. Royal Artillery etc (handwritten)'
	# python python/sheet.py ingest-test 'data/drive/WO65 transcribed data/Handwritten Text/WO 65-46 Army List 1796_Handwritten.xlsx' '16. Officers on Full Pay' 'WO 65-46 Army List 1796' '76. Officers on Full Pay (handwritten)'
	# python python/sheet.py ingest-test 'data/drive/WO65 transcribed data/Handwritten Text/WO 65-46 Army List 1796_Handwritten.xlsx' '22. Reduced Corps' 'WO 65-46 Army List 1796' '82. Reduced Corps (handwritten)'
	# python python/sheet.py ingest-test 'data/drive/WO65 transcribed data/Handwritten Text/WO 65-46 Army List 1796_Handwritten.xlsx' '28-31. Officers on Half Pay' 'WO 65-46 Army List 1796' '88-91. Officers on Half Pay (handwritten)'
	# python python/sheet.py ingest-test 'data/drive/WO65 transcribed data/Handwritten Text/WO 65-47 Army List 1797  - HANDWRITTEN v2.xlsx' '3. Local Rank' 'WO 65-47 Army List 1797' '63. Local Rank (handwritten)'
	#
	python python/sheet.py ingest '$(FILE)' '1. General and Field Officers' '$(DBFILE)' '61. General and Field Officers (handwritten)'
	#python python/sheet.py ingest '$(FILE)' '2. Aides-de-Camp' '$(DBFILE)' '62. Aides-de-Camp (handwritten)'
	python python/sheet.py ingest '$(FILE)' '3. Local Rank' '$(DBFILE)' '63. Local Rank (handwritten)'
	#python python/sheet.py ingest '$(FILE)' '4. Staff & Miscellaneous' '$(DBFILE)' '64. Staff & Miscellaneous (handwritten)'
	#python python/sheet.py ingest '$(FILE)' '5. Staff Officers' '$(DBFILE)' '65. Staff Officers (handwritten)'
	#python python/sheet.py ingest '$(FILE)' '6. Honorary Distinctions' '$(DBFILE)' '66. Honorary Distinctions (handwritten)'
	#python python/sheet.py ingest '$(FILE)' '7. Order of the Bath' '$(DBFILE)' '67. Order of the Bath (handwritten)'
	#python python/sheet.py ingest '$(FILE)' '8. Guelphic Order' '$(DBFILE)' '68. Guelphic Order (handwritten)'
	#python python/sheet.py ingest '$(FILE)' '9. Foreign Orders' '$(DBFILE)' '69. Foreign Orders (handwritten)'
	python python/sheet.py ingest '$(FILE)' '10. Regiments' '$(DBFILE)' '70. Regiments (handwritten)'
	python python/sheet.py ingest '$(FILE)' '11. Independent Companies' '$(DBFILE)' '71. Independent Companies (handwritten)'
	python python/sheet.py ingest '$(FILE)' '12. Invalids' '$(DBFILE)' '72. Invalids (handwritten)'
	python python/sheet.py ingest '$(FILE)' '13. Garrisons' '$(DBFILE)' '73. Garrisons (handwritten)'
	python python/sheet.py ingest '$(FILE)' '14. Royal Artillery etc' '$(DBFILE)' '74. Royal Artillery etc (handwritten)'
	#python python/sheet.py ingest '$(FILE)' '15. Marines' '$(DBFILE)' '75. Marines (handwritten)'
	python python/sheet.py ingest '$(FILE)' '16. Officers on Full Pay' '$(DBFILE)' '76. Officers on Full Pay (handwritten)'
	#python python/sheet.py ingest '$(FILE)' '17-21. Military Departments' '$(DBFILE)' '77-81. Military Departments (handwritten)'
	python python/sheet.py ingest '$(FILE)' '22. Reduced Corps' '$(DBFILE)' '82. Reduced Corps (handwritten)'
	#python python/sheet.py ingest '$(FILE)' '23. Companies of Foot' '$(DBFILE)' '83. Companies of Foot (handwritten)'
	#python python/sheet.py ingest '$(FILE)' '24. Companies of Invalids' '$(DBFILE)' '84. Companies of Invalids (handwritten)'
	#python python/sheet.py ingest '$(FILE)' '25. Officers Unattached' '$(DBFILE)' '85. Officers Unattached (handwritten)'
	#python python/sheet.py ingest '$(FILE)' '26. Foot Guards' '$(DBFILE)' '86. Foot Guards (handwritten)'
	#python python/sheet.py ingest '$(FILE)' '27. Retired & Reduced' '$(DBFILE)' '87. Retired & Reduced (handwritten)'
	python python/sheet.py ingest '$(FILE)' '28-31. Officers on Half Pay' '$(DBFILE)' '88-91. Officers on Half Pay (handwritten)'
	python python/sheet.py ingest '$(FILE)' '32. New Independent Companies' '$(DBFILE)' '92. New Independent Companies (handwritten)'
	#python python/sheet.py ingest '$(FILE)' '33. Succession of Colonels' '$(DBFILE)' '93. Succession of Colonels (handwritten)'
	#python python/sheet.py ingest '$(FILE)' '34. Casualties' '$(DBFILE)' '94. Casualties (handwritten)'
	#python python/sheet.py ingest '$(FILE)' '35. Alterations While Printing' '$(DBFILE)' '95. Alterations While Printing (handwritten)'
	#python python/sheet.py ingest '$(FILE)' '36. Errata' '$(DBFILE)' '96. Errata (handwritten)'

#sheet-ingest-handwritten-test:
#	python python/sheet.py ingest-test '$(FILE)' '1. General and Field Officers' '$(DBFILE)' '61. General and Field Officers (handwritten)'
#	python python/sheet.py ingest-test '$(FILE)' '3. Local Rank' '$(DBFILE)' '63. Local Rank (handwritten)'
#	python python/sheet.py ingest-test '$(FILE)' '10. Regiments' '$(DBFILE)' '70. Regiments (handwritten)'
#	python python/sheet.py ingest-test '$(FILE)' '11. Independent Companies' '$(DBFILE)' '71. Independent Companies (handwritten)'
#	python python/sheet.py ingest-test '$(FILE)' '12. Invalids' '$(DBFILE)' '72. Invalids (handwritten)'
#	python python/sheet.py ingest-test '$(FILE)' '13. Garrisons' '$(DBFILE)' '73. Garrisons (handwritten)'
#	python python/sheet.py ingest-test '$(FILE)' '14. Royal Artillery etc' '$(DBFILE)' '74. Royal Artillery etc (handwritten)'
#	python python/sheet.py ingest-test '$(FILE)' '16. Officers on Full Pay' '$(DBFILE)' '76. Officers on Full Pay (handwritten)'
#	python python/sheet.py ingest-test '$(FILE)' '22. Reduced Corps' '$(DBFILE)' '82. Reduced Corps (handwritten)'
#	python python/sheet.py ingest-test '$(FILE)' '28-31. Officers on Half Pay' '$(DBFILE)' '88-91. Officers on Half Pay (handwritten)'
#	python python/sheet.py ingest-test '$(FILE)' '32. New Independent Companies' '$(DBFILE)' '92. New Independent Companies (handwritten)'

sheet-ingest-all:
	# source .venv/bin/activate
	# SELECT COUNT(*) FROM row WHERE file = 'WO 65-50 Army List 1800';
	# DELETE FROM row WHERE file = 'WO 65-50 Army List 1800';
	# make sheet-ingest-file FILE='data/drive/WO65 transcribed data/WO 65-50 Army List 1800.xlsx'
	#
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-40 Army List 1790.xlsx' DBFILE='WO 65-40 Army List 1790' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-41 Army List 1791.xlsx' DBFILE='WO 65-41 Army List 1791' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-42 Army List 1792.xlsx' DBFILE='WO 65-42 Army List 1792' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-43 Army List 1793.xlsx' DBFILE='WO 65-43 Army List 1793' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-44 Army List 1794.xlsx' DBFILE='WO 65-44 Army List 1794' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-45 Army List 1795.xlsx' DBFILE='WO 65-45 Army List 1795'
	#
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-46 Army List 1796.xlsx' DBFILE='WO 65-46 Army List 1796' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-47 Army List 1797.xlsx' DBFILE='WO 65-47 Army List 1797' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-48 Army List 1798.xlsx' DBFILE='WO 65-48 Army List 1798' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-49 Army List 1799.xlsx' DBFILE='WO 65-49 Army List 1799' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-50 Army List 1800.xlsx' DBFILE='WO 65-50 Army List 1800' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-51 Army List 1801.xlsx' DBFILE='WO 65-51 Army List 1801'
	#
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-52 Army List 1802.xlsx' DBFILE='WO 65-52 Army List 1802' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-53 Army List 1803.xlsx' DBFILE='WO 65-53 Army List 1803' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-54 Army List 1804.xlsx' DBFILE='WO 65-54 Army List 1804' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-55 Army List 1805.xlsx' DBFILE='WO 65-55 Army List 1805' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-56 Army List 1806.xlsx' DBFILE='WO 65-56 Army List 1806' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-57 Army List 1807.xlsx' DBFILE='WO 65-57 Army List 1807'
	#
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-58 Army List 1808.xlsx' DBFILE='WO 65-58 Army List 1808' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-59 Army List 1809.xlsx' DBFILE='WO 65-59 Army List 1809' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-60 Army List 1810.xlsx' DBFILE='WO 65-60 Army List 1810' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-61 Army List 1811.xlsx' DBFILE='WO 65-61 Army List 1811' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-62 Army List 1812.xlsx' DBFILE='WO 65-62 Army List 1812' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-63 Army List 1813.xlsx' DBFILE='WO 65-63 Army List 1813'
	#
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-64 Army List 1814.xlsx' DBFILE='WO 65-64 Army List 1814' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-65 Army List 1815.xlsx' DBFILE='WO 65-65 Army List 1815' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-66 Army List 1816.xlsx' DBFILE='WO 65-66 Army List 1816' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-67 Army List 1817.xlsx' DBFILE='WO 65-67 Army List 1817'
	#
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-69 Army List 1818.xlsx' DBFILE='WO 65-69 Army List 1818' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-71 Army List 1819.xlsx' DBFILE='WO 65-71 Army List 1819' &
	$(MAKE) sheet-ingest-file FILE='data/drive/WO65 transcribed data/Printed text/WO 65-73 Army List 1820.xlsx' DBFILE='WO 65-73 Army List 1820'
	#
	python python/sheet.py ingest 'data/drive/WO65 transcribed data/Fencibles Army Lists transcribed data/1793 Fencibles - PRINTED.xlsx' '10. Regiments' 'WO 65-43 Army List 1793' '55. Fencibles' &
	python python/sheet.py ingest 'data/drive/WO65 transcribed data/Fencibles Army Lists transcribed data/1794 Fencibles - PRINTED.xlsx' '10. Regiments' 'WO 65-44 Army List 1794' '55. Fencibles' &
	python python/sheet.py ingest 'data/drive/WO65 transcribed data/Fencibles Army Lists transcribed data/1795 Fencibles - PRINTED.xlsx' '10. Regiments' 'WO 65-45 Army List 1795' '55. Fencibles' &
	python python/sheet.py ingest 'data/drive/WO65 transcribed data/Fencibles Army Lists transcribed data/1796 Fencibles - PRINTED.xlsx' '10. Regiments' 'WO 65-46 Army List 1796' '55. Fencibles'
	#
	python python/sheet.py ingest 'data/drive/WO65 transcribed data/Fencibles Army Lists transcribed data/1797 Fencibles - PRINTED.xlsx' '10. Regiments' 'WO 65-47 Army List 1797' '55. Fencibles' &
	python python/sheet.py ingest 'data/drive/WO65 transcribed data/Fencibles Army Lists transcribed data/1799 Fencibles - PRINTED.xlsx' '10. Regiments' 'WO 65-49 Army List 1799' '55. Fencibles' &
	python python/sheet.py ingest 'data/drive/WO65 transcribed data/Fencibles Army Lists transcribed data/1800 Fencibles - PRINTED.xlsx' '10. Regiments' 'WO 65-50 Army List 1800' '55. Fencibles' &
	python python/sheet.py ingest 'data/drive/WO65 transcribed data/Fencibles Army Lists transcribed data/1801 Fencibles - PRINTED.xlsx' '10. Regiments' 'WO 65-51 Army List 1801' '55. Fencibles'
	#
	$(MAKE) sheet-ingest-handwritten FILE='data/drive/WO65 transcribed data/Handwritten Text/WO 65-40 Army List 1790 - HANDWRITTEN v2.xlsx' DBFILE='WO 65-40 Army List 1790' &
	$(MAKE) sheet-ingest-handwritten FILE='data/drive/WO65 transcribed data/Handwritten Text/WO 65-41 Army List 1791 - HANDWRITTEN v2.xlsx' DBFILE='WO 65-41 Army List 1791' &
	$(MAKE) sheet-ingest-handwritten FILE='data/drive/WO65 transcribed data/Handwritten Text/WO 65-42 Army List 1792 - HANDWRITTEN v2.xlsx' DBFILE='WO 65-42 Army List 1792' &
	$(MAKE) sheet-ingest-handwritten FILE='data/drive/WO65 transcribed data/Handwritten Text/WO 65-43 Army List 1793  - HANDWRITTEN v2.xlsx' DBFILE='WO 65-43 Army List 1793' &
	$(MAKE) sheet-ingest-handwritten FILE='data/drive/WO65 transcribed data/Handwritten Text/WO 65-44 Army List 1794 - HANDWRITTEN v2.xlsx' DBFILE='WO 65-44 Army List 1794' &
	$(MAKE) sheet-ingest-handwritten FILE='data/drive/WO65 transcribed data/Handwritten Text/WO 65-45 Army List 1795_Handwritten.xlsx' DBFILE='WO 65-45 Army List 1795'
	#
	$(MAKE) sheet-ingest-handwritten FILE='data/drive/WO65 transcribed data/Handwritten Text/WO 65-46 Army List 1796_Handwritten.xlsx' DBFILE='WO 65-46 Army List 1796' &
	$(MAKE) sheet-ingest-handwritten FILE='data/drive/WO65 transcribed data/Handwritten Text/WO 65-47 Army List 1797  - HANDWRITTEN v2.xlsx' DBFILE='WO 65-47 Army List 1797' &
	$(MAKE) sheet-ingest-handwritten FILE='data/drive/WO65 transcribed data/Handwritten Text/WO 65-56 Army List 1806_Handwritten.xlsx' DBFILE='WO 65-56 Army List 1806'
	#
	python python/sheet.py ingest 'data/drive/WO65 transcribed data/Fencibles Army Lists transcribed data/1794 Fencible List - HANDWRITTEN.xlsx' '10. Regiments' 'WO 65-44 Army List 1794' '56. Fencibles (handwritten)'

#handwritten-test:
#	$(MAKE) sheet-ingest-handwritten-test FILE='data/drive/WO65 transcribed data/Handwritten Text/WO 65-40 Army List 1790 - HANDWRITTEN v2.xlsx' DBFILE='WO 65-40 Army List 1790'
#	$(MAKE) sheet-ingest-handwritten-test FILE='data/drive/WO65 transcribed data/Handwritten Text/WO 65-41 Army List 1791 - HANDWRITTEN v2.xlsx' DBFILE='WO 65-41 Army List 1791'
#	$(MAKE) sheet-ingest-handwritten-test FILE='data/drive/WO65 transcribed data/Handwritten Text/WO 65-42 Army List 1792 - HANDWRITTEN v2.xlsx' DBFILE='WO 65-42 Army List 1792'
#	$(MAKE) sheet-ingest-handwritten-test FILE='data/drive/WO65 transcribed data/Handwritten Text/WO 65-43 Army List 1793  - HANDWRITTEN v2.xlsx' DBFILE='WO 65-43 Army List 1793'
#	$(MAKE) sheet-ingest-handwritten-test FILE='data/drive/WO65 transcribed data/Handwritten Text/WO 65-44 Army List 1794 - HANDWRITTEN v2.xlsx' DBFILE='WO 65-44 Army List 1794'
#	$(MAKE) sheet-ingest-handwritten-test FILE='data/drive/WO65 transcribed data/Handwritten Text/WO 65-45 Army List 1795_Handwritten.xlsx' DBFILE='WO 65-45 Army List 1795'
#	$(MAKE) sheet-ingest-handwritten-test FILE='data/drive/WO65 transcribed data/Handwritten Text/WO 65-46 Army List 1796_Handwritten.xlsx' DBFILE='WO 65-46 Army List 1796'
#	$(MAKE) sheet-ingest-handwritten-test FILE='data/drive/WO65 transcribed data/Handwritten Text/WO 65-47 Army List 1797  - HANDWRITTEN v2.xlsx' DBFILE='WO 65-47 Army List 1797'
#	$(MAKE) sheet-ingest-handwritten-test FILE='data/drive/WO65 transcribed data/Handwritten Text/WO 65-56 Army List 1806_Handwritten.xlsx' DBFILE='WO 65-56 Army List 1806'

reg:
	# source .venv/bin/activate
	python python/reg_cmd.py regiment
	python python/reg_cmd.py regiment 'Thirds Royal Veteran Battalion'
	python python/reg_cmd.py regiment '25th Light Dragoons' 1802
	python python/reg_cmd.py rank
	python python/reg_cmd.py rank 'Captain of Sandown'
	python python/reg_cmd.py rank-similarity 'Brigadier General' 'Major General'
	python python/reg_cmd.py date
	python python/reg_cmd.py date '20 Feb 1793'
	python python/reg_cmd.py name
	python python/reg_cmd.py name 'His Royal Highness W.D. Of Gloucester, K.G.'
	python python/reg_cmd.py date2
	python python/reg_cmd.py re-reg
	python python/reg_cmd.py common

sheet-99:
	# source .venv/bin/activate
	# sqlite3 british-army-officers.db
	# DELETE FROM row WHERE sheet = '99. All';
	# .read sql/sheet-99.sql

sheet-link-file-internal-stage-one:
	# source .venv/bin/activate
	# make sheet-link-file-internal FILE='data/drive/WO65 transcribed data/WO 65-40 Army List 1790.xlsx'
	#
	# python python/sheet.py link-test 'WO 65-65 Army List 1815' '1. General and Field Officers' 'WO 65-65 Army List 1815' '99. All' C 20
	# python python/sheet.py link-test 'WO 65-65 Army List 1815' '4. Staff & Miscellaneous' 'WO 65-65 Army List 1815' '99. All' B 20
	# python python/sheet.py link-test 'WO 65-65 Army List 1815' '7. Order of the Bath' 'WO 65-65 Army List 1815' '99. All' B 20
	# python python/sheet.py link-test 'WO 65-65 Army List 1815' '8. Guelphic Order' 'WO 65-65 Army List 1815' '99. All' B 20
	# python python/sheet.py link-test 'WO 65-65 Army List 1815' '13. Garrisons' 'WO 65-65 Army List 1815' '99. All' B 20
	# python python/sheet.py link-test 'WO 65-65 Army List 1815' '35. Alterations While Printing' 'WO 65-65 Army List 1815' '99. All' B 20
	#
	# Category C. Might not be in a Category A Sheet.
	python python/sheet.py link '$(FILE)' '1. General and Field Officers' '$(FILE)' '99. All' C	
	python python/sheet.py link '$(FILE)' '4. Staff & Miscellaneous' '$(FILE)' '99. All' B
	python python/sheet.py link '$(FILE)' '7. Order of the Bath' '$(FILE)' '99. All' B
	python python/sheet.py link '$(FILE)' '8. Guelphic Order' '$(FILE)' '99. All' B
	python python/sheet.py link '$(FILE)' '13. Garrisons' '$(FILE)' '99. All' B
	python python/sheet.py link '$(FILE)' '35. Alterations While Printing' '$(FILE)' '99. All' B
	#
	# Handwritten sheets. Might be in their respective printed sheet, but also might not be.
	# python python/sheet.py link-test 'WO 65-40 Army List 1790' '61. General and Field Officers (handwritten)' 'WO 65-40 Army List 1790' '1. General and Field Officers' H 20
	# python python/sheet.py link-test 'WO 65-40 Army List 1790' '70. Regiments (handwritten)' 'WO 65-40 Army List 1790' '10. Regiments' H 20
	# python python/sheet.py link-test 'WO 65-41 Army List 1791' '71. Independent Companies (handwritten)' 'WO 65-41 Army List 1791' '11. Independent Companies' H 20
	# python python/sheet.py link-test 'WO 65-40 Army List 1790' '72. Invalids (handwritten)' 'WO 65-40 Army List 1790' '12. Invalids' H 20
	# python python/sheet.py link-test 'WO 65-40 Army List 1790' '73. Garrisons (handwritten)' 'WO 65-40 Army List 1790' '13. Garrisons' H 20
	# python python/sheet.py link-test 'WO 65-46 Army List 1796' '74. Royal Artillery etc (handwritten)' 'WO 65-46 Army List 1796' '14. Royal Artillery etc' H 20
	# python python/sheet.py link-test 'WO 65-46 Army List 1796' '76. Officers on Full Pay (handwritten)' 'WO 65-46 Army List 1796' '16. Officers on Full Pay' H 20
	# python python/sheet.py link-test 'WO 65-46 Army List 1796' '82. Reduced Corps (handwritten)' 'WO 65-46 Army List 1796' '22. Reduced Corps' H 20
	# python python/sheet.py link-test 'WO 65-46 Army List 1796' '88-91. Officers on Half Pay (handwritten)' 'WO 65-46 Army List 1796' '28-31. Officers on Half Pay' H 20
	# python python/sheet.py link-test 'WO 65-40 Army List 1790' '92. New Independent Companies (handwritten)' 'WO 65-40 Army List 1790' '32. New Independent Companies' H 20
	python python/sheet.py link '$(FILE)' '70. Regiments (handwritten)' '$(FILE)' '10. Regiments' H
	python python/sheet.py link '$(FILE)' '71. Independent Companies (handwritten)' '$(FILE)' '11. Independent Companies' H
	python python/sheet.py link '$(FILE)' '72. Invalids (handwritten)' '$(FILE)' '12. Invalids' H
	python python/sheet.py link '$(FILE)' '74. Royal Artillery etc (handwritten)' '$(FILE)' '14. Royal Artillery etc' H
	python python/sheet.py link '$(FILE)' '76. Officers on Full Pay (handwritten)' '$(FILE)' '16. Officers on Full Pay' H
	python python/sheet.py link '$(FILE)' '82. Reduced Corps (handwritten)' '$(FILE)' '22. Reduced Corps' H
	python python/sheet.py link '$(FILE)' '88-91. Officers on Half Pay (handwritten)' '$(FILE)' '28-31. Officers on Half Pay' H
	python python/sheet.py link '$(FILE)' '92. New Independent Companies (handwritten)' '$(FILE)' '32. New Independent Companies' H
	#
	python python/sheet.py link '$(FILE)' '61. General and Field Officers (handwritten)' '$(FILE)' '1. General and Field Officers' H
	python python/sheet.py link '$(FILE)' '73. Garrisons (handwritten)' '$(FILE)' '13. Garrisons' H
	#
	#python python/sheet.py link '$(FILE)' '1. General and Field Officers' '$(FILE)' '10. Regiments' C
	# python python/sheet.py link-test 'WO 65-50 Army List 1800' '1. General and Field Officers' 'WO 65-50 Army List 1800' '10. Regiments' C 10
	#python python/sheet.py link '$(FILE)' '1. General and Field Officers' '$(FILE)' '14. Royal Artillery etc' D
	# python python/sheet.py link-test 'WO 65-50 Army List 1800' '1. General and Field Officers' 'WO 65-50 Army List 1800' '14. Royal Artillery etc' D 10
	#python python/sheet.py link '$(FILE)' '1. General and Field Officers' '$(FILE)' '15. Marines' D
	# python python/sheet.py link-test 'WO 65-50 Army List 1800' '1. General and Field Officers' 'WO 65-50 Army List 1800' '15. Marines' D 10
	#
	#python python/sheet.py link '$(FILE)' '3. Local Rank' '$(FILE)' '10. Regiments' C
	# python python/sheet.py link-test 'WO 65-50 Army List 1800' '3. Local Rank' 'WO 65-50 Army List 1800' '10. Regiments' C 10
	#python python/sheet.py link '$(FILE)' '3. Local Rank' '$(FILE)' '14. Royal Artillery etc' D
	# python python/sheet.py link-test 'WO 65-50 Army List 1800' '3. Local Rank' 'WO 65-50 Army List 1800' '14. Royal Artillery etc' D 10
	#python python/sheet.py link '$(FILE)' '3. Local Rank' '$(FILE)' '15. Marines' D
	# python python/sheet.py link-test 'WO 65-50 Army List 1800' '3. Local Rank' 'WO 65-50 Army List 1800' '15. Marines' D 10
	#
	#python python/sheet.py link '$(FILE)' '34. Casualties' '$(FILE)' '10. Regiments' E
	# python python/sheet.py link-test 'WO 65-65 Army List 1815' '34. Casualties' 'WO 65-65 Army List 1815' '10. Regiments' E 10
	#python python/sheet.py link '$(FILE)' '34. Casualties' '$(FILE)' '14. Royal Artillery etc' F
	# python python/sheet.py link-test 'WO 65-65 Army List 1815' '34. Casualties' 'WO 65-65 Army List 1815' '14. Royal Artillery etc' F 10
	#python python/sheet.py link '$(FILE)' '34. Casualties' '$(FILE)' '15. Marines' F
	# python python/sheet.py link-test 'WO 65-65 Army List 1815' '34. Casualties' 'WO 65-65 Army List 1815' '15. Marines' F 10
	#
	#python python/sheet.py link '$(FILE)' '13. Garrisons' '$(FILE)' '10. Regiments' B
	# python python/sheet.py link-test 'WO 65-50 Army List 1800' '13. Garrisons' 'WO 65-50 Army List 1800' '10. Regiments' B 10
	#python python/sheet.py link '$(FILE)' '6. Honorary Distinctions' '$(FILE)' '10. Regiments' B
	# python python/sheet.py link-test 'WO 65-65 Army List 1815' '6. Honorary Distinctions' 'WO 65-65 Army List 1815' '10. Regiments' B 10
	#python python/sheet.py link '$(FILE)' '9. Foreign Orders' '$(FILE)' '10. Regiments' B
	# python python/sheet.py link-test 'WO 65-73 Army List 1820' '9. Foreign Orders' 'WO 65-73 Army List 1820' '10. Regiments' B 10
	#python python/sheet.py link '$(FILE)' '7. Order of the Bath' '$(FILE)' '10. Regiments' B
	# python python/sheet.py link-test 'WO 65-73 Army List 1820' '7. Order of the Bath' 'WO 65-73 Army List 1820' '10. Regiments' B 10
	#python python/sheet.py link '$(FILE)' '8. Guelphic Order' '$(FILE)' '10. Regiments' B
	# python python/sheet.py link-test 'WO 65-73 Army List 1820' '8. Guelphic Order' 'WO 65-73 Army List 1820' '10. Regiments' B 10
	#python python/sheet.py link '$(FILE)' '4. Staff & Miscellaneous' '$(FILE)' '10. Regiments' B
	# python python/sheet.py link-test 'WO 65-73 Army List 1820' '4. Staff & Miscellaneous' 'WO 65-73 Army List 1820' '10. Regiments' B 10
	#python python/sheet.py link '$(FILE)' '5. Staff Officers' '$(FILE)' '10. Regiments' B
	# python python/sheet.py link-test 'WO 65-63 Army List 1813' '5. Staff Officers' 'WO 65-63 Army List 1813' '10. Regiments' B 10
	#python python/sheet.py link '$(FILE)' '2. Aides-de-Camp' '$(FILE)' '10. Regiments' B
	# python python/sheet.py link-test 'WO 65-73 Army List 1820' '2. Aides-de-Camp' 'WO 65-73 Army List 1820' '10. Regiments' B 10
	#
	#python python/sheet.py link '$(FILE)' '35. Alterations While Printing' '$(FILE)' '10. Regiments' B
	#python python/sheet.py link '$(FILE)' '36. Errata' '$(FILE)' '10. Regiments' B
	#
	# Additional Information about individuals within an Army List
	# 1. General and Field Officers / Field Marshals, General and Field Officers
	# 2. Aides-de-Camp to the King / Prince Regent
	# 3. Local Rank
	# 4. Staff and Miscellaneous Appointments (held by Commission)
	# 6. Officer to whom His Majesty has granted Honory Distinctions
	# 7. Military Officers of the Most Hononorable Order of the Bath
	# 8. Military Officers of the Guelphic Order
	# 9. British Officers possessing Foreign Titles
	# 13. Garrisons / Military Establishments
	# 34. Casualties
	# 35. Alternations whilst Printing
	# will include new officers (e.g. ensigns, cornets)
	# 36. Errata
	
sheet-99-extend:
	# source .venv/bin/activate
	# sqlite3 british-army-officers.db
	# .read sql/sheet-99-extend-undo.sql
	# .read sql/sheet-99-extend.sql

sheet-link-file-internal-stage-two:
	# source .venv/bin/activate
	# make sheet-link-file-internal FILE='data/drive/WO65 transcribed data/WO 65-40 Army List 1790.xlsx'
	#
	# python python/sheet.py link-test 'WO 65-65 Army List 1815' '2. Aides-de-Camp' 'WO 65-65 Army List 1815' '99. All' B 20
	# python python/sheet.py link-test 'WO 65-65 Army List 1815' '3. Local Rank' 'WO 65-65 Army List 1815' '99. All' C 20
	# python python/sheet.py link-test 'WO 65-65 Army List 1815' '5. Staff Officers' 'WO 65-65 Army List 1815' '99. All' B 20
	# python python/sheet.py link-test 'WO 65-65 Army List 1815' '6. Honorary Distinctions' 'WO 65-65 Army List 1815' '99. All' B 20
	# python python/sheet.py link-test 'WO 65-65 Army List 1815' '9. Foreign Orders' 'WO 65-65 Army List 1815' '99. All' B 20
	# python python/sheet.py link-test 'WO 65-65 Army List 1815' '34. Casualties' 'WO 65-65 Army List 1815' '99. All' E 20
	# python python/sheet.py link-test 'WO 65-65 Army List 1815' '36. Errata' 'WO 65-65 Army List 1815' '99. All' B	20
	#
	# Category B. Definitely also in a Category A Sheet.
	python python/sheet.py link '$(FILE)' '2. Aides-de-Camp' '$(FILE)' '99. All' B
	python python/sheet.py link '$(FILE)' '3. Local Rank' '$(FILE)' '99. All' C
	python python/sheet.py link '$(FILE)' '5. Staff Officers' '$(FILE)' '99. All' B
	python python/sheet.py link '$(FILE)' '6. Honorary Distinctions' '$(FILE)' '99. All' B
	python python/sheet.py link '$(FILE)' '9. Foreign Orders' '$(FILE)' '99. All' B
	python python/sheet.py link '$(FILE)' '34. Casualties' '$(FILE)' '99. All' E
	python python/sheet.py link '$(FILE)' '36. Errata' '$(FILE)' '99. All' B
	# Handwritten sheets. Might be in their respective printed sheet, or might not be, but doesn't matter as much here since no copying to sheet 99 to think about.
	# python python/sheet.py link-test 'WO 65-47 Army List 1797' '63. Local Rank (handwritten)' 'WO 65-47 Army List 1797' '3. Local Rank' H
	python python/sheet.py link '$(FILE)' '63. Local Rank (handwritten)' '$(FILE)' '3. Local Rank' H

sheet-link-files-external:
	# source .venv/bin/activate
	# make sheet-link-files-external FILEA='data/drive/WO65 transcribed data/WO 65-41 Army List 1791.xlsx' FILEB='data/drive/WO65 transcribed data/WO 65-40 Army List 1790.xlsx'
	#
	# python python/sheet.py link-test 'WO 65-65 Army List 1815' '99. All' 'WO 65-64 Army List 1814' '99. All' A 20
	#
	python python/sheet.py link '$(FILEA)' '99. All' '$(FILEB)' '99. All' A
	
sheet-info:
	# Lists of Individuals
	# 10. Regiments: The big one.
	# 5. Staff Officers with Permanent Rank in the Army (not holding Regimental Commissions)
	# 12. Invalids – instead of ‘Regiment Name or Garrison name’ it has two columns: No. of Companies and Place
	# 14. Royal Artillery – follows the structure of sheet 10
	# 15. Marines – follows the structure of sheet 10 but with an additional 2nd Rank column
	# 16. Officers of the Royal Marines retired on Full Pay
	# 17-21. Military Departments – instead of ‘Regiment Name or Garrison name’ it has Department
	# 22. Reduced Corps - follows the structure of sheet 10 but with an additional 2nd Rank column
	# 23. Officers of late Independent Companies of Foot receiving Full Pay
	# 24. Officers of late Independent Companies of Invalids receiving Full Pay
	# 25. Officers unattached receiving Full pay
	# 26. Officers of Foot Guards receiving Full Pay
	# 27. Retired and Reduced – follows the format of sheet 10
	# 28-31. Officers on Half Pay – significantly different from sheet 10. Distinguishing information is:
	# Type of Half-Pay (English / Irish)
	# If disbanded or reduced (this is section heading within the document)
	# The year(s) of the disbandment or reduction (not always present)
	# Regiment name; this is a place for staff officers
	# NB. There are no date for individuals until 1815 when a few start appearing.
	# 32. New Independent Companies – list of names and ranks but no dates

sheet-link-internal-stage-one-all:
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-40 Army List 1790' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-41 Army List 1791' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-42 Army List 1792'
	#
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-43 Army List 1793' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-44 Army List 1794' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-45 Army List 1795' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-46 Army List 1796' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-47 Army List 1797' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-48 Army List 1798' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-49 Army List 1799'
	#
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-50 Army List 1800' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-51 Army List 1801' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-52 Army List 1802' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-53 Army List 1803' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-54 Army List 1804' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-55 Army List 1805' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-56 Army List 1806'
	#
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-57 Army List 1807' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-58 Army List 1808' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-59 Army List 1809' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-60 Army List 1810' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-61 Army List 1811' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-62 Army List 1812' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-63 Army List 1813'
	#
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-64 Army List 1814' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-65 Army List 1815' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-66 Army List 1816' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-67 Army List 1817' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-69 Army List 1818' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-71 Army List 1819' &
	$(MAKE) sheet-link-file-internal-stage-one FILE='WO 65-73 Army List 1820'

sheet-link-internal-stage-two-all:
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-40 Army List 1790' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-41 Army List 1791' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-42 Army List 1792'
	#
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-43 Army List 1793' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-44 Army List 1794' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-45 Army List 1795' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-46 Army List 1796' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-47 Army List 1797' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-48 Army List 1798' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-49 Army List 1799'
	#
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-50 Army List 1800' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-51 Army List 1801' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-52 Army List 1802' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-53 Army List 1803' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-54 Army List 1804' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-55 Army List 1805' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-56 Army List 1806'
	#
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-57 Army List 1807' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-58 Army List 1808' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-59 Army List 1809' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-60 Army List 1810' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-61 Army List 1811' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-62 Army List 1812' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-63 Army List 1813'
	#
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-64 Army List 1814' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-65 Army List 1815' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-66 Army List 1816' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-67 Army List 1817' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-69 Army List 1818' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-71 Army List 1819' &
	$(MAKE) sheet-link-file-internal-stage-two FILE='WO 65-73 Army List 1820'

sheet-link-external-all:
	$(MAKE) sheet-link-files-external FILEA='WO 65-41 Army List 1791' FILEB='WO 65-40 Army List 1790' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-42 Army List 1792' FILEB='WO 65-41 Army List 1791'
	#
	$(MAKE) sheet-link-files-external FILEA='WO 65-43 Army List 1793' FILEB='WO 65-42 Army List 1792' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-44 Army List 1794' FILEB='WO 65-43 Army List 1793' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-45 Army List 1795' FILEB='WO 65-44 Army List 1794' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-46 Army List 1796' FILEB='WO 65-45 Army List 1795' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-47 Army List 1797' FILEB='WO 65-46 Army List 1796' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-48 Army List 1798' FILEB='WO 65-47 Army List 1797' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-49 Army List 1799' FILEB='WO 65-48 Army List 1798'
	#
	$(MAKE) sheet-link-files-external FILEA='WO 65-50 Army List 1800' FILEB='WO 65-49 Army List 1799' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-51 Army List 1801' FILEB='WO 65-50 Army List 1800' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-52 Army List 1802' FILEB='WO 65-51 Army List 1801' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-53 Army List 1803' FILEB='WO 65-52 Army List 1802' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-54 Army List 1804' FILEB='WO 65-53 Army List 1803' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-55 Army List 1805' FILEB='WO 65-54 Army List 1804' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-56 Army List 1806' FILEB='WO 65-55 Army List 1805'
	#
	$(MAKE) sheet-link-files-external FILEA='WO 65-57 Army List 1807' FILEB='WO 65-56 Army List 1806' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-58 Army List 1808' FILEB='WO 65-57 Army List 1807' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-59 Army List 1809' FILEB='WO 65-58 Army List 1808' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-60 Army List 1810' FILEB='WO 65-59 Army List 1809' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-61 Army List 1811' FILEB='WO 65-60 Army List 1810' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-62 Army List 1812' FILEB='WO 65-61 Army List 1811' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-63 Army List 1813' FILEB='WO 65-62 Army List 1812'
	#
	$(MAKE) sheet-link-files-external FILEA='WO 65-64 Army List 1814' FILEB='WO 65-63 Army List 1813' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-65 Army List 1815' FILEB='WO 65-64 Army List 1814' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-66 Army List 1816' FILEB='WO 65-65 Army List 1815' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-67 Army List 1817' FILEB='WO 65-66 Army List 1816' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-69 Army List 1818' FILEB='WO 65-67 Army List 1817' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-71 Army List 1819' FILEB='WO 65-69 Army List 1818' &
	$(MAKE) sheet-link-files-external FILEA='WO 65-73 Army List 1820' FILEB='WO 65-71 Army List 1819'

new-appointments:
	# source .venv/bin/activate
	# sqlite3 british-army-officers.db
	# .read sql/new-appointments.sql

link-hydrate:
	# source .venv/bin/activate
	# sqlite3 british-army-officers.db
	# .read sql/link-hydrate.sql

row-linkinfo:
	# source .venv/bin/activate
	# sqlite3 british-army-officers.db
	# .read sql/row-linkinfo.sql

sheet-99-links:
	# source .venv/bin/activate
	# sqlite3 british-army-officers.db
	# DELETE FROM link WHERE link_category = -1;
	# .read sql/sheet-99-links.sql

person:
	# source .venv/bin/activate
	# python python/sheet.py person-test
	python python/sheet.py person

data-service:
	# source .venv/bin/activate
	# sqlite3 british-army-officers.db
	# .read sql/data-service.sql

