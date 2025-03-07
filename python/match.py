#!/usr/bin/python3

from datetime import datetime

from strsimpy.jaro_winkler import JaroWinkler

jarowinkler = JaroWinkler()

import rapidfuzz
import re

def cleanpage(pagefield):

  if pagefield != None:

    pagefield = re.sub(r'[^0-9]', r'', pagefield).strip()

    if len(pagefield) > 0: return pagefield

  return None

def rank_similarity(areg_rank, breg_rank, arank_lvl, brank_lvl, afileyear, bfileyear):

  if areg_rank == None or breg_rank == None or len(areg_rank) == 0 or len(breg_rank) == 0: return 0.0 # If either reg_rank is None or empty we have a quick reject

  if areg_rank == breg_rank: return 1.0 # Ranks match

  if arank_lvl != None and brank_lvl != None:

    if arank_lvl == brank_lvl: return 0.999 # Ranks are equivalent

    # Assume File B proceeds File A. This would be normal now we are linking backwards.
    startrank = brank_lvl
    endrank = arank_lvl

    if bfileyear > afileyear: # File A proceeds File B
        startrank = arank_lvl
        endrank = brank_lvl


    # Allowed promotions:
    
    if startrank == 5 and endrank == 6: return 0.998 # 'Cornet' to 'Lieutenant'
    if startrank == 6 and endrank == 7: return 0.998 # 'Lieutenant' to 'Captain Lieutenant'
    if startrank == 6 and endrank == 9: return 0.998 # 'Lieutenant' to 'Captain'
    if startrank == 7 and endrank == 9: return 0.998 # 'Captain Lieutenant' to 'Captain'
    if startrank == 9 and endrank == 12: return 0.998 # 'Captain' to 'Major'
    if startrank == 12 and endrank == 15: return 0.998 # 'Major' to 'Lieutenant-Colonel'
    if startrank == 21 and endrank == 22: return 0.998 # 'Major-General' to 'Lieutenant-General'
    if startrank == 19 and endrank == 17: return 0.998 # 'Colonel-Commandant' to 'Colonel'
    if startrank == 20 and endrank == 21: return 0.998 # Brigadier-General > Major-General
    if startrank == 9 and endrank == 11: return 0.998 # Captain and Lieutenant-Colonel > Second Major
    if startrank == 9 and endrank == 10: return 0.998 # Captain and Lieutenant-Colonel > Third Major
    if startrank == -5 and endrank == -3: return 0.998 # Assistant Surgeon > Surgeon
    if startrank == 17 and endrank == 19: return 0.998 # Colonel > Colonel Commandant
    if startrank == 8 and endrank == 9: return 0.998 # Second Captain > Captain
    if startrank == 6 and endrank == 8: return 0.998 # First Lieutenant > Second Captain
    if startrank == 15  and endrank == 17: return 0.998 # Lieutenant-Colonel >  Colonel
    if startrank == 15 and endrank == 19: return 0.998 # Lieutenant-Colonel > Colonel Commandant En Second
    if startrank == 22 and endrank == 23: return 0.998 # Lieutenant-General > General
    if startrank == 17 and endrank == 21: return 0.998 # Colonel > Major-General
    if startrank == -23 and endrank == -28: return 0.998 # Deputy Inspector > Inspector
    if startrank == -40 and endrank == -28: return 0.998 # Inspector (Local Rank) > Inspector
    if startrank == -3 and endrank == -28: return 0.998 # Surgeon > Inspector
    if startrank == -3 and endrank == -40: return 0.998 # Surgeon > Inspector (Local Rank)
    if startrank == -35 and endrank == -3: return 0.998 # Surgeon (Local Rank) > Surgeon
    if startrank == 16 and endrank == 17: return 0.998 # Lieutenant-Colonel Commandant > Colonel

  return 0.0







def match_a(rowa, rowsb): # Sheet 99 to Sheet 99 (previous year) logic

  #arowid = rowa[0]
  #afile = rowa[1]
  #asheet = rowa[2]
  #arow = rowa[3]
  #aregiment = rowa[4]
  #arank = rowa[5]
  #aname = rowa[6]
  #aperson = rowa[7]
  #apage = rowa[8]
  #adeleted = rowa[9]
  #ahandwritten = rowa[10]
  #adate = rowa[11]
  #adate2 = rowa[12]
  #aannotations = rowa[13]
  areg_regiment = rowa[14]
  areg_rank = rowa[15]
  arank_lvl = rowa[16]
  asurname = rowa[17]
  agiven = rowa[18]
  #amiddlenames = rowa[19]
  #atitle = rowa[20]
  #anamesuffix = rowa[21]
  #anickname = rowa[22]
  afileyear = rowa[23]
  areg_date = rowa[24]
  #alink_category = rowa[25]
  #alink_score = rowa[26]
  #alink_log = rowa[27]
  #arow_count = rowa[28]
  areg_name = rowa[29]

  matches = []      

  for i, rowb in enumerate(rowsb):

    log = ''
    score = 0
    category = 4 # For review

    bsurname = rowb[17]

    if abs(len(asurname) - len(bsurname)) < 4:

        #surname_score = jarowinkler.similarity(asurname, bsurname)
        #surname_score = rapidfuzz.fuzz.ratio(asurname, bsurname) / 100
        surname_score = rapidfuzz.distance.JaroWinkler.similarity(asurname, bsurname)

        breg_date = rowb[24]

        if surname_score > 0.85 or (surname_score > 0.5 and areg_date == breg_date):

            #browid = rowb[0]
            #bfile = rowb[1]
            #bsheet = rowb[2]
            #brow = rowb[3]
            #bregiment = rowb[4]
            #brank = rowb[5]
            #bname = rowb[6]
            #bperson = rowb[7]
            #bpage = rowb[8]
            #bdeleted = rowb[9]
            #bhandwritten = rowb[10]
            #bdate = rowb[11]
            #bdate2 = rowb[12]
            #bannotations = rowb[13]
            breg_regiment = rowb[14]
            breg_rank = rowb[15]
            brank_lvl = rowb[16]
            #bsurname = rowb[17]
            bgiven = rowb[18]
            #bmiddlenames = rowb[19]
            #btitle = rowb[20]
            #bnamesuffix = rowb[21]
            #bnickname = rowb[22]
            bfileyear = rowb[23]
            #breg_date = rowb[24]
            #blink_category = rowb[25]
            #blink_score = rowb[26]
            #blink_log = rowb[27]
            #brow_count = rowb[28]
            breg_name = rowb[29]

            initial_match = False

            if (len(agiven) == 2 and agiven[1] == '.') or (len(bgiven) == 2 and bgiven[1] == '.'):
                log += 'INITIAL MATCH. '
                initial_match = True

            if initial_match:
                if agiven[:1] == bgiven[:1]:
                    given_score = 0.99
                else:
                    given_score = 0
            else:
                
                #given_score = jarowinkler.similarity(agiven, bgiven)
                given_score = rapidfuzz.distance.JaroWinkler.similarity(agiven, bgiven)

            #name_score = jarowinkler.similarity(areg_name, breg_name)
            name_score = rapidfuzz.distance.JaroWinkler.similarity(areg_name, breg_name)

            #rank_score = rank_similarity(areg_rank, breg_rank, arank_lvl, brank_lvl, afileyear, bfileyear)
            rank_score = eval_ranks(rowa, rowb)

            if areg_regiment == breg_regiment:

              score += 1.5 # Bonus for being in the same regiment
              score += (surname_score * 4.0) # Favour surname score
              score += given_score
              score += name_score

              if surname_score > 0.85 and given_score > 0.85:
         
                score += rank_score

                if rank_score != 0.0:

                  if areg_date == breg_date:

                    score += 3.0

                    category = 0 # Very confident

                  else:

                    log += 'DATE CHANGED. '

                    category = 1 # Rank changed

                elif rank_score == 0.0:

                  log += 'IMPLAUSIBLE RANK CHANGE: ' + str(arank_lvl) + ' -> ' + str(brank_lvl) + '. '

            else:

              log += 'CROSS-REGIMENT MATCH. '

              score += (surname_score * 4.0) # Favour surname score
              score += given_score
              score += name_score

              if surname_score > 0.85 and given_score > 0.85:

                score += rank_score

                if rank_score != 0: # Cross regiment matches still need to have a plausible rank change.

                  category = 2 # Regiment changed

                elif rank_score == 0.0:

                  log += 'IMPLAUSIBLE RANK CHANGE: ' + str(arank_lvl) + ' -> ' + str(brank_lvl) + '. '


            if category == 4: # Why did we fail to get out of category 3 for this match?

              log += 'SURNAME SCORE: ' + '{:.3f}'.format(surname_score) + '. '
              log += 'GIVEN SCORE: ' + '{:.3f}'.format(given_score) + '. '

              if areg_date == breg_date and rank_score == 1.0 and surname_score > 0.5 and given_score > 0.5:

                category = 3 # Rank and date match so we will accept a lower surname and given score

        else:

            score += surname_score
            log += 'SURNAME SCORE: ' + '{:.3f}'.format(surname_score) + '. '

    else:

        log += 'SURNAME LEN: ' + str(abs(len(asurname) - len(bsurname)));

    matches.append((rowb, i, score, category, log))

  return matches




def eval_ranks(rowa, rowb):

    arank = rowa[5]
    areg_rank = rowa[15]
    arank_lvl = rowa[16]
    afileyear = rowa[23]
    areg_date2rank = rowa[31]
    areg_date2lvl = rowa[32]
    areg_rank2 = rowa[33]
    arank2_lvl = rowa[34]
    aname_rank = rowa[38]
    aname_rank_lvl = rowa[39]
    arank2 = rowa[40]

    brank = rowb[5]
    breg_rank = rowb[15]
    brank_lvl = rowb[16]
    bfileyear = rowb[23]
    breg_date2rank = rowb[31]
    breg_date2lvl = rowb[32]
    breg_rank2 = rowb[33]
    brank2_lvl = rowb[34]
    bname_rank = rowb[38]
    bname_rank_lvl = rowb[39]
    brank2 = rowb[40]

    #if (arank_lvl != None and 
    #(arank_lvl == brank_lvl or arank_lvl == breg_date2lvl)) or 
    #(areg_date2lvl != None and (areg_date2lvl == breg_date2lvl or areg_date2lvl == brank_lvl)):

    # a = rank
    # b = rank2
    # c = date2 rank
    # d = date rank

    comp_aa = rank_similarity(areg_rank, breg_rank, arank_lvl, brank_lvl, afileyear, bfileyear)
    comp_ab = rank_similarity(areg_rank, breg_rank2, arank_lvl, brank2_lvl, afileyear, bfileyear)
    comp_ac = rank_similarity(areg_rank, breg_date2rank, arank_lvl, breg_date2lvl, afileyear, bfileyear)
    comp_ad = rank_similarity(areg_rank, bname_rank, arank_lvl, bname_rank_lvl, afileyear, bfileyear)

    comp_ba = rank_similarity(areg_rank2, breg_rank, arank2_lvl, brank_lvl, afileyear, bfileyear)
    comp_bb = rank_similarity(areg_rank2, breg_rank2, arank2_lvl, brank2_lvl, afileyear, bfileyear)
    comp_bc = rank_similarity(areg_rank2, breg_date2rank, arank2_lvl, breg_date2lvl, afileyear, bfileyear)
    comp_bd = rank_similarity(areg_rank2, bname_rank, arank2_lvl, bname_rank_lvl, afileyear, bfileyear)

    comp_ca = rank_similarity(areg_date2rank, breg_rank, areg_date2lvl, brank_lvl, afileyear, bfileyear)
    comp_cb = rank_similarity(areg_date2rank, breg_rank2, areg_date2lvl, brank2_lvl, afileyear, bfileyear)
    comp_cc = rank_similarity(areg_date2rank, breg_date2rank, areg_date2lvl, breg_date2lvl, afileyear, bfileyear)
    comp_cd = rank_similarity(areg_date2rank, bname_rank, areg_date2lvl, bname_rank_lvl, afileyear, bfileyear)

    comp_da = rank_similarity(aname_rank, breg_rank, aname_rank_lvl, brank_lvl, afileyear, bfileyear)
    comp_db = rank_similarity(aname_rank, breg_rank2, aname_rank_lvl, brank2_lvl, afileyear, bfileyear)
    comp_dc = rank_similarity(aname_rank, breg_date2rank, aname_rank_lvl, breg_date2lvl, afileyear, bfileyear)
    comp_dd = rank_similarity(aname_rank, bname_rank, aname_rank_lvl, bname_rank_lvl, afileyear, bfileyear)

    final = max(comp_aa, comp_ab, comp_ac, comp_ad, comp_ba, comp_bb, comp_bc, comp_bd, comp_ca, comp_cb, comp_cc, comp_cd, comp_da, comp_db, comp_dc, comp_dd)

#    print()
#    print('---------------------------------------------------------------------------')
#    print('         YEAR: ' + '{:40.40}'.format(str(afileyear)) + ' | ' + '{:40.40}'.format(str(bfileyear)))
#    print('         RANK: ' + '{:40.40}'.format(str(arank)) + ' | ' + '{:40.40}'.format(str(brank)))
#    print('     RANK_REG: ' + '{:40.40}'.format(str(areg_rank)) + ' | ' + '{:40.40}'.format(str(breg_rank)))
#    print(' RANK_REG_LVL: ' + '{:40.40}'.format(str(arank_lvl)) + ' | ' + '{:40.40}'.format(str(brank_lvl)))
#    print('        RANK2: ' + '{:40.40}'.format(str(arank2)) + ' | ' + '{:40.40}'.format(str(brank2)))
#    print('    RANK2_REG: ' + '{:40.40}'.format(str(areg_rank2)) + ' | ' + '{:40.40}'.format(str(breg_rank2)))
#    print('RANK2_REG_LVL: ' + '{:40.40}'.format(str(arank2_lvl)) + ' | ' + '{:40.40}'.format(str(brank2_lvl)))
#    print('       D2RANK: ' + '{:40.40}'.format(str(areg_date2rank)) + ' | ' + '{:40.40}'.format(str(breg_date2rank)))
#    print('   D2RANK_LVL: ' + '{:40.40}'.format(str(areg_date2lvl)) + ' | ' + '{:40.40}'.format(str(breg_date2lvl)))
#    print('        NRANK: ' + '{:40.40}'.format(str(aname_rank)) + ' | ' + '{:40.40}'.format(str(bname_rank)))
#    print('    NRANK_LVL: ' + '{:40.40}'.format(str(aname_rank_lvl)) + ' | ' + '{:40.40}'.format(str(bname_rank_lvl)))
#    print()
#    print('      COMP_AA:' + str(comp_aa))
#    print('      COMP_AB:' + str(comp_ab))
#    print('      COMP_AC:' + str(comp_ac))
#    print('      COMP_AD:' + str(comp_ad))
#    print()
#    print('      COMP_BA:' + str(comp_ba))
#    print('      COMP_BB:' + str(comp_bb))
#    print('      COMP_BC:' + str(comp_bc))
#    print('      COMP_BD:' + str(comp_bd))
#    print()
#    print('      COMP_CA:' + str(comp_ca))
#    print('      COMP_CB:' + str(comp_cb))
#    print('      COMP_CC:' + str(comp_cc))
#    print('      COMP_CD:' + str(comp_cd))
#    print()
#    print('      COMP_DA:' + str(comp_da))
#    print('      COMP_DB:' + str(comp_db))
#    print('      COMP_DC:' + str(comp_dc))
#    print('      COMP_DD:' + str(comp_dd))
#    print()
#    print('        FINAL:' + str(final))
#    print('---------------------------------------------------------------------------')
#    #exit()

    return final



def eval_dates(rowa, rowb):

    areg_date = rowa[24]
    areg_date2 = rowa[30]

    breg_date = rowb[24]
    breg_date2 = rowb[30]  

#    print()
#    print('---------------------------------------------------------------------------')
#    print('         DATE: ' + '{:40.40}'.format(str(areg_date)) + ' | ' + '{:40.40}'.format(str(breg_date)))
#    print('        DATE2: ' + '{:40.40}'.format(str(areg_date2)) + ' | ' + '{:40.40}'.format(str(breg_date2)))
#    print('---------------------------------------------------------------------------')

    if areg_date != None and breg_date != None and areg_date == breg_date: return True
    if areg_date != None and breg_date2 != None and areg_date == breg_date2: return True
    if areg_date2 != None and breg_date != None and areg_date2 == breg_date: return True
    if areg_date2 != None and breg_date2 != None and areg_date2 == breg_date2: return True

    return False



def match_b(rowa, rowsb): # General Purpose

  #arowid = rowa[0]
  #afile = rowa[1]
  #asheet = rowa[2]
  #arow = rowa[3]
  #aregiment = rowa[4]
  #arank = rowa[5]
  #aname = rowa[6]
  #aperson = rowa[7]
  #apage = rowa[8]
  #adeleted = rowa[9]
  #ahandwritten = rowa[10]
  #adate = rowa[11]
  #adate2 = rowa[12]
  #aannotations = rowa[13]
  areg_regiment = rowa[14]
  areg_rank = rowa[15]
  arank_lvl = rowa[16]
  asurname = rowa[17]
  agiven = rowa[18]
  #amiddlenames = rowa[19]
  #atitle = rowa[20]
  #anamesuffix = rowa[21]
  #anickname = rowa[22]
  #afileyear = rowa[23]
  areg_date = rowa[24]
  #alink_category = rowa[25]
  #alink_score = rowa[26]
  #alink_log = rowa[27]
  #arow_count = rowa[28]
  areg_name = rowa[29]
  areg_date2 = rowa[30]
  #areg_date2rank = rowa[31]
  areg_date2lvl = rowa[32]
  #areg_rank2 = rowa[33]
  #arank2_lvl = rowa[34]
  #adatealt = rowa[35]
  #aorig_sheet = rowa[36]
  #aorig_idkey = rowa[37]
  #aname_rank = rowa[38]
  #aname_rank_lvl = rowa[39]


  matches = []      

  for i, rowb in enumerate(rowsb):

    log = ''
    score = 0
    category = 4 # For review

    bsurname = rowb[17]

    #surname_score = jarowinkler.similarity(asurname, bsurname)
    surname_score = rapidfuzz.distance.JaroWinkler.similarity(asurname, bsurname)

    log += 'S ' + '{:.2f}'.format(surname_score) + '. '

    if surname_score >= 0.95:

        #browid = rowb[0]
        #bfile = rowb[1]
        #bsheet = rowb[2]
        #brow = rowb[3]
        #bregiment = rowb[4]
        #brank = rowb[5]
        #bname = rowb[6]
        #bperson = rowb[7]
        #bpage = rowb[8]
        #bdeleted = rowb[9]
        #bhandwritten = rowb[10]
        #bdate = rowb[11]
        #bdate2 = rowb[12]
        #bannotations = rowb[13]
        breg_regiment = rowb[14]
        breg_rank = rowb[15]
        brank_lvl = rowb[16]
        #bsurname = rowb[17]
        bgiven = rowb[18]
        #bmiddlenames = rowb[19]
        #btitle = rowb[20]
        #bnamesuffix = rowb[21]
        #bnickname = rowb[22]
        #bfileyear = rowb[23]
        breg_date = rowb[24]
        #blink_category = rowb[25]
        #blink_score = rowb[26]
        #blink_log = rowb[27]
        #brow_count = rowb[28]
        breg_name = rowb[29]
        breg_date2 = rowb[30]
        #breg_date2rank = rowb[31]
        breg_date2lvl = rowb[32]

        initial_match = False

        if (len(agiven) == 2 and agiven[1] == '.') or (len(bgiven) == 2 and bgiven[1] == '.'):
            log += 'INIT '
            initial_match = True

        if initial_match:
            if agiven[:1] == bgiven[:1]:
                given_score = 0.99
            else:
                given_score = 0
        else:
            
            #given_score = jarowinkler.similarity(agiven, bgiven)
            given_score = rapidfuzz.distance.JaroWinkler.similarity(agiven, bgiven)

        #name_score = jarowinkler.similarity(areg_name, breg_name)
        name_score = rapidfuzz.distance.JaroWinkler.similarity(areg_name, breg_name)

        score += (surname_score * 4.0) # Favour surname score
        score += given_score
        score += name_score

        log += 'G ' + '{:.2f}'.format(given_score) + '. '

        if surname_score > 0.95 and given_score > 0.95:

          if areg_regiment != None and areg_regiment == breg_regiment:

            score += 2.0 # Bonus for being in the same regiment

            log += 'UNIT '

            #if (arank_lvl != None and (arank_lvl == brank_lvl or arank_lvl == breg_date2lvl)) or (areg_date2lvl != None and (areg_date2lvl == breg_date2lvl or areg_date2lvl == brank_lvl)):
            rank_eval = eval_ranks(rowa, rowb)
            if (rank_eval > 0.0):

                score += (rank_eval * 2) # Bonus for rank match

                log += 'RANK '

                category = 0 # Matching rank and regiment

                if eval_dates(rowa, rowb):

                    score += 0.5 # Further Bonus for date match

                    log += 'DATE '

            else:

                category = 1

          #elif (arank_lvl != None and (arank_lvl == brank_lvl or arank_lvl == breg_date2lvl)) or (areg_date2lvl != None and (areg_date2lvl == breg_date2lvl or areg_date2lvl == brank_lvl)):
          rank_eval = eval_ranks(rowa, rowb)
          if (rank_eval > 0.0):

                score += (rank_eval * 2) # Bonus for rank match

                log += 'RANK '

                category = 2 # Matching rank, but not regiment.

                if eval_dates(rowa, rowb):

                    score += 0.5 # Further Bonus for date match

                    log += 'DATE '

                # breg_date
                # breg_date2

          else:

            category = 3 # Just name match

#          if (areg_date != None and (areg_date == breg_date or areg_date == breg_date2)) or (areg_date2 != None and (areg_date2 == breg_date or areg_date2 == breg_date2)):
#
#            score += 1.0 # Bonus for any matching dates  
#
#            log += 'DATE '

    else:

        score += surname_score

    matches.append((rowb, i, score, category, log))

  return matches








def match_cd(rowa, rowsb): # Sheet 1 to Sheet 10, Sheet 1 to Sheet 14 and Sheet 1 to Sheet 15 (all same year) logic

  #arowid = rowa[0]
  #afile = rowa[1]
  #asheet = rowa[2]
  #arow = rowa[3]
  #aregiment = rowa[4]
  #arank = rowa[5]
  #aname = rowa[6]
  #aperson = rowa[7]
  #apage = rowa[8]
  #adeleted = rowa[9]
  #ahandwritten = rowa[10]
  #adate = rowa[11]
  #adate2 = rowa[12]
  #aannotations = rowa[13]
  #areg_regiment = rowa[14]
  #areg_rank = rowa[15]
  arank_lvl = rowa[16]
  asurname = rowa[17]
  agiven = rowa[18]
  #amiddlenames = rowa[19]
  #atitle = rowa[20]
  #anamesuffix = rowa[21]
  #anickname = rowa[22]
  #afileyear = rowa[23]
  areg_date = rowa[24]
  #alink_category = rowa[25]
  #alink_score = rowa[26]
  #alink_log = rowa[27]
  #arow_count = rowa[28]
  areg_name = rowa[29]
  areg_date2 = rowa[30]
  areg_date2rank = rowa[31]
  areg_date2lvl = rowa[32]

  matches = []      

  for i, rowb in enumerate(rowsb):

    log = ''
    score = 0
    category = 4 # For review

    #brank_lvl = rowb[16]

    #if (brank_lvl and brank_lvl >= 7): # Sheet 10.current rank should be captain or higher in our list of ranks

    bsurname = rowb[17]

    #surname_score = jarowinkler.similarity(asurname, bsurname)
    surname_score = rapidfuzz.distance.JaroWinkler.similarity(asurname, bsurname)

    if surname_score >= 0.85:

        #browid = rowb[0]
        #bfile = rowb[1]
        #bsheet = rowb[2]
        #brow = rowb[3]
        #bregiment = rowb[4]
        #brank = rowb[5]
        #bname = rowb[6]
        #bperson = rowb[7]
        #bpage = rowb[8]
        #bdeleted = rowb[9]
        #bhandwritten = rowb[10]
        #bdate = rowb[11]
        #bdate2 = rowb[12]
        #bannotations = rowb[13]
        #breg_regiment = rowb[14]
        #breg_rank = rowb[15]
        brank_lvl = rowb[16]
        #bsurname = rowb[17]
        bgiven = rowb[18]
        #bmiddlenames = rowb[19]
        #btitle = rowb[20]
        #bnamesuffix = rowb[21]
        #bnickname = rowb[22]
        #bfileyear = rowb[23]
        #breg_date = rowb[24]
        #blink_category = rowb[25]
        #blink_score = rowb[26]
        #blink_log = rowb[27]
        #brow_count = rowb[28]
        breg_name = rowb[29]
        breg_date2 = rowb[30]
        breg_date2rank = rowb[31]
        breg_date2lvl = rowb[32]
        #b_reg_rank2 = rowb[33]
        brank2_lvl = rowb[34]

        initial_match = False

        if (len(agiven) == 2 and agiven[1] == '.') or (len(bgiven) == 2 and bgiven[1] == '.'):
            log += 'INITIAL MATCH. '
            initial_match = True

        if initial_match:
            if agiven[:1] == bgiven[:1]:
                given_score = 0.99
            else:
                given_score = 0
        else:
            #given_score = jarowinkler.similarity(agiven, bgiven)
            given_score = rapidfuzz.distance.JaroWinkler.similarity(agiven, bgiven)


        #name_score = jarowinkler.similarity(areg_name, breg_name)
        name_score = rapidfuzz.distance.JaroWinkler.similarity(areg_name, breg_name)

        score += (surname_score * 4.0) # Favour surname score
        score += given_score
        score += name_score

        if areg_date != None and areg_date == breg_date2: # For those with a higher rank in the army than their regimental rank (in sheet 10) the 2nd date in sheet 10 should match on the 1st date in sheet 1
            
            score += 1.0
            log += 'ARMY DATE MATCH. '

            if (arank_lvl != None and arank_lvl == breg_date2lvl) or (arank_lvl != None and arank_lvl == brank2_lvl): # Sheet 10’s second date often also has a second rank too, in an abbreviated form. If we could separate this out (not sure why we didn’t in the data entry?) then we’ll have a link to the right rank too.

                score += 1.0
                log += 'ARMY RANK MATCH. '

                if given_score > 0.85:

                    category = 0 # A match on army date, army rank and name.

                else:

                    log += 'GIVEN SCORE: ' + '{:.3f}'.format(given_score) + '. '

            else:

                if given_score > 0.85:

                    category = 1 # A match on army date and name.

                else:

                    log += 'GIVEN SCORE: ' + '{:.3f}'.format(given_score) + '. '

        elif (areg_date is None or breg_date2 is None) and arank_lvl != None and arank_lvl == breg_date2lvl:

            score += 0.1
            log += 'ARMY RANK MATCH BUT NO DATE. '

            if given_score > 0.85:

                category = 2 # A match on army rank, but army date is absent on one or both records.

        else:

            if given_score > 0.85:

                category = 3 # A match on name only.

            else:

                log += 'GIVEN SCORE: ' + '{:.3f}'.format(given_score) + '. '

    else:

        score += surname_score
        log += 'SURNAME SCORE: ' + '{:.3f}'.format(surname_score) + '. '

    matches.append((rowb, i, score, category, log))

  return matches









def match_ef(rowa, rowsb): # Sheet 34 to Sheet 10

  #arowid = rowa[0]
  #afile = rowa[1]
  #asheet = rowa[2]
  #arow = rowa[3]
  #aregiment = rowa[4]
  #arank = rowa[5]
  #aname = rowa[6]
  #aperson = rowa[7]
  #apage = rowa[8]
  #adeleted = rowa[9]
  #ahandwritten = rowa[10]
  #adate = rowa[11]
  #adate2 = rowa[12]
  #aannotations = rowa[13]
  areg_regiment = rowa[14]
  #areg_rank = rowa[15]
  arank_lvl = rowa[16]
  asurname = rowa[17]
  agiven = rowa[18]
  #amiddlenames = rowa[19]
  #atitle = rowa[20]
  #anamesuffix = rowa[21]
  #anickname = rowa[22]
  #afileyear = rowa[23]
  #areg_date = rowa[24]
  #alink_category = rowa[25]
  #alink_score = rowa[26]
  #alink_log = rowa[27]
  #arow_count = rowa[28]
  #areg_name = rowa[29]

  matches = []      

  for i, rowb in enumerate(rowsb):

    log = ''
    score = 0
    category = 4 # For review

    #browid = rowb[0]
    #bfile = rowb[1]
    #bsheet = rowb[2]
    #brow = rowb[3]
    #bregiment = rowb[4]
    #brank = rowb[5]
    #bname = rowb[6]
    #bperson = rowb[7]
    #bpage = rowb[8]
    #bdeleted = rowb[9]
    #bhandwritten = rowb[10]
    #bdate = rowb[11]
    #bdate2 = rowb[12]
    #bannotations = rowb[13]
    breg_regiment = rowb[14]
    #breg_rank = rowb[15]
    brank_lvl = rowb[16]
    bsurname = rowb[17]
    bgiven = rowb[18]
    #bmiddlenames = rowb[19]
    #btitle = rowb[20]
    #bnamesuffix = rowb[21]
    #bnickname = rowb[22]
    #bfileyear = rowb[23]
    #breg_date = rowb[24]
    #blink_category = rowb[25]
    #blink_score = rowb[26]
    #blink_log = rowb[27]
    #brow_count = rowb[28]
    #breg_name = rowb[29]

    if areg_regiment == breg_regiment:

      score += 4.0

      #surname_score = jarowinkler.similarity(asurname, bsurname)
      surname_score = rapidfuzz.distance.JaroWinkler.similarity(asurname, bsurname)

      log += 'S ' + '{:.2f}'.format(surname_score) + '. '
      score += (surname_score * 4.0) # Favour surname score

      if surname_score > 0.95:

        if (len(agiven) > 0): # If a given name is present, it cannot be wrong.

          initial_match = False

          if (len(agiven) == 2 and agiven[1] == '.') or (len(bgiven) == 2 and bgiven[1] == '.'):
              #log += 'INITIAL MATCH. '
              initial_match = True

          if initial_match:
              if agiven[:1] == bgiven[:1]:
                  given_score = 0.99
              else:
                  given_score = 0
          else:
              
              #given_score = jarowinkler.similarity(agiven, bgiven)
              given_score = rapidfuzz.distance.JaroWinkler.similarity(agiven, bgiven)

          log += 'G *' + agiven + '* *' + bgiven + '* '
          log += 'G ' + '{:.2f}'.format(given_score) + '. '

          if given_score > 0.95:

            score += (given_score * 2.0)
            category = 1

          else:

            score -= 2.0

        else:

          category = 1

        #if arank_lvl != None and arank_lvl == brank_lvl:
        rank_eval = eval_ranks(rowa, rowb)
        if (rank_eval == 1.0):

          score += 4.0
          category = 0

    matches.append((rowb, i, score, category, log))

  return matches

def match_g(rowa, rowsb, common_given, common_surname): # Sheet 28 to Sheet 10 (previous year) logic

  #arowid = rowa[0]
  #afile = rowa[1]
  #asheet = rowa[2]
  #arow = rowa[3]
  #aregiment = rowa[4]
  #arank = rowa[5]
  #aname = rowa[6]
  #aperson = rowa[7]
  #apage = rowa[8]
  #adeleted = rowa[9]
  #ahandwritten = rowa[10]
  #adate = rowa[11]
  #adate2 = rowa[12]
  #aannotations = rowa[13]
  areg_regiment = rowa[14]
  areg_rank = rowa[15]
  arank_lvl = rowa[16]
  asurname = rowa[17]
  agiven = rowa[18]
  #amiddlenames = rowa[19]
  #atitle = rowa[20]
  #anamesuffix = rowa[21]
  #anickname = rowa[22]
  afileyear = rowa[23]
  areg_date = rowa[24]
  #alink_category = rowa[25]
  #alink_score = rowa[26]
  #alink_log = rowa[27]
  #arow_count = rowa[28]
  areg_name = rowa[29]

  matches = []      

  if common_given > 0.05 and common_surname > 0.02:

      # matches.append((rowb, i, score, category, log))
      msg = 'TOO COMMON ' + "{:.3f}".format(common_given) + ' ' + "{:.3f}".format(common_surname)
      matches.append((rowsb[0], None, 0, 4, msg))
      matches.append((rowsb[0], None, 0, 4, msg))
      matches.append((rowsb[0], None, 0, 4, msg))

      return matches


  for i, rowb in enumerate(rowsb):

    log = ''
    score = 0
    category = 4 # For review

    #log = log + "{:.3f}".format(common_given) + ' ' + "{:.3f}".format(common_surname);
    #if common_given > 0.05 and common_surname > 0.02:
    #    log = log + 'TOO COMMON ' + "{:.3f}".format(common_given) + ' ' + "{:.3f}".format(common_surname)

    brank_lvl = rowb[16]

    if arank_lvl != None and brank_lvl != None and arank_lvl == brank_lvl: # Super strict with ranks here

        bsurname = rowb[17]

        #surname_score = jarowinkler.similarity(asurname, bsurname)
        surname_score = rapidfuzz.distance.JaroWinkler.similarity(asurname, bsurname)

        #breg_date = rowb[24]


        if surname_score > 0.97:

            #browid = rowb[0]
            #bfile = rowb[1]
            #bsheet = rowb[2]
            #brow = rowb[3]
            #bregiment = rowb[4]
            #brank = rowb[5]
            #bname = rowb[6]
            #bperson = rowb[7]
            #bpage = rowb[8]
            #bdeleted = rowb[9]
            #bhandwritten = rowb[10]
            #bdate = rowb[11]
            #bdate2 = rowb[12]
            #bannotations = rowb[13]
            #breg_regiment = rowb[14]
            breg_rank = rowb[15]
            #brank_lvl = rowb[16]
            #bsurname = rowb[17]
            bgiven = rowb[18]
            #bmiddlenames = rowb[19]
            #btitle = rowb[20]
            #bnamesuffix = rowb[21]
            #bnickname = rowb[22]
            bfileyear = rowb[23]
            #breg_date = rowb[24]
            #blink_category = rowb[25]
            #blink_score = rowb[26]
            #blink_log = rowb[27]
            #brow_count = rowb[28]
            breg_name = rowb[29]

            # Initial matches are disabled here because we have to be stric.

            #initial_match = False

            #if (len(agiven) == 2 and agiven[1] == '.') or (len(bgiven) == 2 and bgiven[1] == '.'):
            #    log += 'INITIAL MATCH. '
            #    initial_match = True

            #if initial_match:
            #    if agiven[:1] == bgiven[:1]:
            #        given_score = 0.99
            #    else:
            #        given_score = 0
            #else:
            #    given_score = jarowinkler.similarity(agiven, bgiven)

            # given_score = jarowinkler.similarity(agiven, bgiven)
            given_score = rapidfuzz.distance.JaroWinkler.similarity(agiven, bgiven)

            # name_score = jarowinkler.similarity(areg_name, breg_name)
            name_score = rapidfuzz.distance.JaroWinkler.similarity(areg_name, breg_name)

            #rank_score = rank_similarity(areg_rank, breg_rank, arank_lvl, brank_lvl, afileyear, bfileyear)

            #if areg_regiment == breg_regiment: # We do not expect links between Sheet 10 and Sheet 28 to have the same regiment

            #  score += 1.5 # Bonus for being in the same regiment
            score += (surname_score * 4.0) # Favour surname score
            score += given_score
            score += name_score

            if given_score > 0.96 and name_score > 0.97:
            
                #score += rank_score
                #
                #if rank_score != 0:
                #
                #      if areg_date == breg_date:
                #
                #        score += 3.0
                #
                category = 0 # As confident as we can be with this kind of link
                #
                #      else:
                #
                #        log += 'DATE CHANGED. '
                #
                #        category = 1 # Rank changed
                #
                #    elif rank_score == 0.0:
                #
                #      log += 'IMPLAUSIBLE RANK CHANGE: ' + str(arank_lvl) + ' -> ' + str(brank_lvl) + '. '

                #else:

                #  log += 'CROSS-REGIMENT MATCH. '

                #  score += (surname_score * 4.0) # Favour surname score
                #  score += given_score
                #  score += name_score

                #  if surname_score > 0.85 and given_score > 0.85:

                #    score += rank_score

                #    if rank_score != 0: # Cross regiment matches still need to have a plausible rank change.

                #    category = 4 # Rank doesn't match. We have to be strict here so we reject.

                #    elif rank_score == 0.0:

                #      log += 'IMPLAUSIBLE RANK CHANGE: ' + str(arank_lvl) + ' -> ' + str(brank_lvl) + '. '


                #if category == 4: # Why did we fail to get out of category 3 for this match?

                #  log += 'SURNAME SCORE: ' + '{:.3f}'.format(surname_score) + '. '
                #  log += 'GIVEN SCORE: ' + '{:.3f}'.format(given_score) + '. '

                #  if areg_date == breg_date and areg_rank == breg_rank and surname_score > 0.5 and given_score > 0.5:

                #    category = 3 # Rank and date match so we will accept a lower surname and given score

        else:

            score += surname_score
            log += 'SURNAME SCORE: ' + '{:.3f}'.format(surname_score) + '. '

    matches.append((rowb, i, score, category, log))

  return matches

def match_h(rowa, rowsb): # Handwritten to printed

  #arowid = rowa[0]
  #afile = rowa[1]
  #asheet = rowa[2]
  #arow = rowa[3]
  #aregiment = rowa[4]
  #arank = rowa[5]
  #aname = rowa[6]
  #aperson = rowa[7]
  apage = rowa[8]
  #adeleted = rowa[9]
  #ahandwritten = rowa[10]
  #adate = rowa[11]
  #adate2 = rowa[12]
  #aannotations = rowa[13]
  areg_regiment = rowa[14]
  areg_rank = rowa[15]
  arank_lvl = rowa[16]
  asurname = rowa[17]
  agiven = rowa[18]
  #amiddlenames = rowa[19]
  #atitle = rowa[20]
  #anamesuffix = rowa[21]
  #anickname = rowa[22]
  #afileyear = rowa[23]
  areg_date = rowa[24]
  #alink_category = rowa[25]
  #alink_score = rowa[26]
  #alink_log = rowa[27]
  #arow_count = rowa[28]
  areg_name = rowa[29]
  areg_date2 = rowa[30]
  #areg_date2rank = rowa[31]
  areg_date2lvl = rowa[32]
  #areg_rank2 = rowa[33]
  #arank2_lvl = rowa[34]
  #adatealt = rowa[35]
  #aorig_sheet = rowa[36]
  #aorig_idkey = rowa[37]
  #aname_rank = rowa[38]
  #aname_rank_lvl = rowa[39]

  apage_clean = cleanpage(apage)

  matches = []      

  for i, rowb in enumerate(rowsb):

    log = ''
    score = 0
    category = 4 # For review

    bpage = rowb[8]
    bpage_clean = cleanpage(bpage)

    log += str(apage_clean) + '|' + str(bpage_clean) + ' ';

    if apage_clean != None and bpage_clean != None and apage_clean == bpage_clean:
        
        bsurname = rowb[17]

        #surname_score = jarowinkler.similarity(asurname, bsurname)
        surname_score = rapidfuzz.distance.JaroWinkler.similarity(asurname, bsurname)

        log += 'S ' + '{:.2f}'.format(surname_score) + '. '

        if surname_score >= 0.95:

            #browid = rowb[0]
            #bfile = rowb[1]
            #bsheet = rowb[2]
            #brow = rowb[3]
            #bregiment = rowb[4]
            #brank = rowb[5]
            #bname = rowb[6]
            #bperson = rowb[7]
            #bdeleted = rowb[9]
            #bhandwritten = rowb[10]
            #bdate = rowb[11]
            #bdate2 = rowb[12]
            #bannotations = rowb[13]
            breg_regiment = rowb[14]
            breg_rank = rowb[15]
            brank_lvl = rowb[16]
            #bsurname = rowb[17]
            bgiven = rowb[18]
            #bmiddlenames = rowb[19]
            #btitle = rowb[20]
            #bnamesuffix = rowb[21]
            #bnickname = rowb[22]
            #bfileyear = rowb[23]
            breg_date = rowb[24]
            #blink_category = rowb[25]
            #blink_score = rowb[26]
            #blink_log = rowb[27]
            #brow_count = rowb[28]
            breg_name = rowb[29]
            breg_date2 = rowb[30]
            #breg_date2rank = rowb[31]
            breg_date2lvl = rowb[32]

            initial_match = False

            if (len(agiven) == 2 and agiven[1] == '.') or (len(bgiven) == 2 and bgiven[1] == '.'):
                log += 'INIT '
                initial_match = True

            if initial_match:
                if agiven[:1] == bgiven[:1]:
                    given_score = 0.99
                else:
                    given_score = 0
            else:
                
                #given_score = jarowinkler.similarity(agiven, bgiven)
                given_score = rapidfuzz.distance.JaroWinkler.similarity(agiven, bgiven)

            #name_score = jarowinkler.similarity(areg_name, breg_name)
            name_score = rapidfuzz.distance.JaroWinkler.similarity(areg_name, breg_name)

            score += (surname_score * 4.0) # Favour surname score
            score += given_score
            score += name_score

            log += 'G ' + '{:.2f}'.format(given_score) + '. '

            if surname_score > 0.95 and given_score > 0.95:

              if areg_regiment != None and areg_regiment == breg_regiment:

                score += 2.0 # Bonus for being in the same regiment

                log += 'UNIT '

                #if (arank_lvl != None and (arank_lvl == brank_lvl or arank_lvl == breg_date2lvl)) or (areg_date2lvl != None and (areg_date2lvl == breg_date2lvl or areg_date2lvl == brank_lvl)):
                rank_eval = eval_ranks(rowa, rowb)
                if (rank_eval > 0.0):

                    score += (rank_eval * 2) # Bonus for rank match

                    log += 'RANK '

                    category = 0 # Matching rank and regiment

                    if eval_dates(rowa, rowb):

                        score += 0.5 # Further Bonus for date match

                        log += 'DATE '

                else:

                    category = 1

              #elif (arank_lvl != None and (arank_lvl == brank_lvl or arank_lvl == breg_date2lvl)) or (areg_date2lvl != None and (areg_date2lvl == breg_date2lvl or areg_date2lvl == brank_lvl)):
              rank_eval = eval_ranks(rowa, rowb)
              if (rank_eval > 0.0):

                    score += (rank_eval * 2) # Bonus for rank match

                    log += 'RANK '

                    category = 2 # Matching rank, but not regiment.

                    if eval_dates(rowa, rowb):

                        score += 0.5 # Further Bonus for date match

                        log += 'DATE '

                    # breg_date
                    # breg_date2

              else:

                category = 3 # Just name match

    #          if (areg_date != None and (areg_date == breg_date or areg_date == breg_date2)) or (areg_date2 != None and (areg_date2 == breg_date or areg_date2 == breg_date2)):
    #
    #            score += 1.0 # Bonus for any matching dates  
    #
    #            log += 'DATE '

        else:

            score += surname_score

    matches.append((rowb, i, score, category, log))

  return matches



