SELECT COUNT(*)
FROM row
JOIN link ON row.idkey = link.aidkey
WHERE (link.link_category = 4 OR link.link_category = 6 OR link.link_category = 7)
AND sheet IN (
    '1. General and Field Officers',
    '4. Staff & Miscellaneous',
    '7. Order of the Bath',
    '8. Guelphic Order',
    '13. Garrisons',
    '35. Alterations While Printing',
	'61. General and Field Officers (handwritten)',
	'70. Regiments (handwritten)',
	'71. Independent Companies (handwritten)',
	'72. Invalids (handwritten)',
	'73. Garrisons (handwritten)',
	'74. Royal Artillery etc (handwritten)',
	'76. Officers on Full Pay (handwritten)',
	'82. Reduced Corps (handwritten)',
	'88-91. Officers on Half Pay (handwritten)',
	'92. New Independent Companies (handwritten)'
);

