DELETE FROM row
WHERE sheet = '99. All'
AND orig_sheet IN (
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

