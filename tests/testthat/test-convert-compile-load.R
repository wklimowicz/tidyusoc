test_that("Converting and compiling runs succesfully", {

  # df <- haven::read_sav(...)
  # datapasta::dmdclip(df)

  test_data <- tibble::tribble(
    ~pidp, ~a_hidp, ~a_pno, ~a_hhorig,
    ~a_memorig, ~a_psu, ~a_strata, ~a_sampst, ~a_month, ~a_ivfio,
    ~a_ioutcome, ~a_sex, ~a_dvage, ~a_birthy, ~a_istrtdatd,
    ~a_istrtdatm, ~a_istrtdaty, ~a_mvever, ~a_mvmnth, ~a_mvyr,
    ~a_lkmove, ~a_xpmove, ~a_jbstat, ~a_mlstatchk, ~a_mlstat,
    ~a_ukborn, ~a_plbornc, ~a_yr2uk4, ~a_citzn1, ~a_citzn2,
    ~a_citzn3, ~a_qfhigh, ~a_qualoc, ~a_qfvoc1, ~a_qfvoc2, ~a_qfvoc3,
    ~a_qfvoc4, ~a_qfvoc5, ~a_qfvoc6, ~a_qfvoc7, ~a_qfvoc8, ~a_qfvoc9,
    ~a_qfvoc10, ~a_qfvoc11, ~a_qfvoc12, ~a_qfvoc13, ~a_qfvoc14,
    ~a_qfvoc15, ~a_qfvoc96, ~a_school, ~a_scend, ~a_schlloc,
    ~a_fenow, ~a_feend, ~a_edtype, ~a_edasp, ~a_fedlik, ~a_fednt,
    ~a_wlsh1, ~a_wlsh2, ~a_wlsh3, ~a_wlsh4, ~a_wlsh96, ~a_wlshua,
    ~a_wlshub, ~a_wlshuc, ~a_wlshud, ~a_wlshue, ~a_paju, ~a_maju,
    ~a_pacob, ~a_payruk, ~a_payruk1, ~a_macob, ~a_mayruk, ~a_mayruk1,
    ~a_pgprob, ~a_pgmrob, ~a_mgprob, ~a_mgmrob, ~a_paedqf, ~a_maedqf,
    ~a_lvag16, ~a_agelh, ~a_lvag14, ~a_ynlp14, ~a_natid1, ~a_natid2,
    ~a_natid3, ~a_natid4, ~a_natid5, ~a_natid6, ~a_natid97, ~a_racel,
    ~a_racelo_code, ~a_paid, ~a_spaid, ~a_maid, ~a_smaid, ~a_britid,
    ~a_englang, ~a_engspk, ~a_spkdif, ~a_engtel, ~a_teldif,
    ~a_engread, ~a_readdif, ~a_engform, ~a_formdif, ~a_oprlg,
    ~a_oprlg0, ~a_oprlg0ni, ~a_oprlg1, ~a_nirel, ~a_niact, ~a_oprlg2,
    ~a_oprlg3, ~a_mabroad, ~a_mnabroad, ~a_mindirect, ~a_mnotherc,
    ~a_mreturned, ~a_mlived, ~a_mnlived, ~a_moveage, ~a_mnmoves,
    ~a_mlivedist, ~a_mlivedist5, ~a_mlivedistf, ~a_lcmarm,
    ~a_lcmary4, ~a_mpno, ~a_lcmcoh, ~a_lcmcbm, ~a_lcmcby4, ~a_lcmspm,
    ~a_lcmspy4, ~a_nmar, ~a_lcoh, ~a_lncoh, ~a_ladopt, ~a_lnadopt,
    ~a_lprnt, ~a_lnprnt, ~a_lchmor, ~a_lchmorn, ~a_sf1, ~a_sf2a,
    ~a_sf2b, ~a_sf3a, ~a_sf3b, ~a_sf4a, ~a_sf4b, ~a_sf5, ~a_sf6a,
    ~a_sf6b, ~a_sf6c, ~a_sf7, ~a_hlht, ~a_hlhtf, ~a_hlhti, ~a_hlhtc,
    ~a_hlwt, ~a_hlwts, ~a_hlwtp, ~a_hlwtk, ~a_hlwte, ~a_hlwtl,
    ~a_health, ~a_disdif1, ~a_disdif2, ~a_disdif3, ~a_disdif4,
    ~a_disdif5, ~a_disdif6, ~a_disdif7, ~a_disdif8, ~a_disdif9,
    ~a_disdif10, ~a_disdif11, ~a_disdif12, ~a_disdif96, ~a_hcond1,
    ~a_hcond2, ~a_hcond3, ~a_hcond4, ~a_hcond5, ~a_hcond6, ~a_hcond7,
    ~a_hcond8, ~a_hcond9, ~a_hcond10, ~a_hcond11, ~a_hcond12,
    ~a_hcond13, ~a_hcond14, ~a_hcond15, ~a_hcond16, ~a_hcond17,
    ~a_hcond96, ~a_hconds01, ~a_hconds02, ~a_hconds03, ~a_hconds04,
    ~a_hconds05, ~a_hconds06, ~a_hconds07, ~a_hconds08, ~a_hconds09,
    ~a_hconds10, ~a_hconds11, ~a_hconds12, ~a_hconds13, ~a_hconds14,
    ~a_hconds15, ~a_hconds16, ~a_hconds17, ~a_hconda01, ~a_hconda02,
    ~a_hconda03, ~a_hconda04, ~a_hconda05, ~a_hconda06, ~a_hconda07,
    ~a_hconda08, ~a_hconda09, ~a_hconda10, ~a_hconda11, ~a_hconda12,
    ~a_hconda13, ~a_hconda14, ~a_hconda15, ~a_hconda16, ~a_hconda17,
    ~a_aidhh, ~a_aidhua1, ~a_aidhua2, ~a_aidhua3, ~a_aidhua4,
    ~a_aidhua5, ~a_aidhua6, ~a_aidhua7, ~a_aidhua8, ~a_aidhua9,
    ~a_aidhua10, ~a_aidhua11, ~a_aidhua12, ~a_aidhua13, ~a_aidhua14,
    ~a_aidhua15, ~a_aidhua16, ~a_aidxhh, ~a_naidxhh, ~a_aidhu1,
    ~a_aidhu2, ~a_aidhrs, ~a_aideft, ~a_lgaped, ~a_jbhas, ~a_jboff,
    ~a_jboffy, ~a_jbterm1, ~a_jbterm2, ~a_jbsemp, ~a_jbbgd, ~a_jbbgm,
    ~a_jbbgy, ~a_jbmngr, ~a_jbsize, ~a_jbsect, ~a_jbsectpub,
    ~a_jbhrs, ~a_jbot, ~a_jbotpd, ~a_jbpl, ~a_jbttwt, ~a_workdis,
    ~a_worktrav, ~a_paygwc, ~a_paynwc, ~a_payusl, ~a_payu, ~a_payuwc,
    ~a_payug, ~a_paytyp, ~a_ovtpay, ~a_extnsa, ~a_extrate,
    ~a_extrest, ~a_basnsa, ~a_basrate, ~a_basrest, ~a_ovtnsa,
    ~a_ovtrate, ~a_ovtrest, ~a_jbpen, ~a_jbpenm, ~a_jsboss,
    ~a_jssize, ~a_jshrs, ~a_jstypeb, ~a_jsaccs, ~a_jspart, ~a_jsprbm,
    ~a_jsprby4, ~a_jsprem, ~a_jsprey4, ~a_jsprls, ~a_jsprtx,
    ~a_jsprni, ~a_jspayu, ~a_jspayw, ~a_jspytx, ~a_jspyni, ~a_jspl,
    ~a_jsttwt, ~a_jsttwtb, ~a_jsworkdis, ~a_jsworktrav, ~a_jbsat,
    ~a_julk4wk, ~a_julk4x1, ~a_julk4x2, ~a_julk4x3, ~a_julk4x4,
    ~a_julk4x5, ~a_julk4x6, ~a_julk4x96, ~a_julkjb, ~a_jubgn,
    ~a_jbhad, ~a_retdatey, ~a_retdatem, ~a_jlendy, ~a_jlendm,
    ~a_jlsemp, ~a_jlboss, ~a_jlmngr, ~a_jlsize, ~a_j2has, ~a_j2semp,
    ~a_j2hrs, ~a_j2pay, ~a_joblook, ~a_jobdeny, ~a_resjobdeny1,
    ~a_resjobdeny2, ~a_resjobdeny3, ~a_resjobdeny4, ~a_resjobdeny5,
    ~a_resjobdeny6, ~a_resjobdeny7, ~a_resjobdeny8, ~a_resjobdeny9,
    ~a_resjobdeny96, ~a_resjobdeny97, ~a_eed12, ~a_promodeny,
    ~a_respromodeny1, ~a_respromodeny2, ~a_respromodeny3,
    ~a_respromodeny4, ~a_respromodeny5, ~a_respromodeny6,
    ~a_respromodeny7, ~a_respromodeny8, ~a_respromodeny9,
    ~a_respromodeny96, ~a_respromodeny97, ~a_traindeny,
    ~a_restraindeny1, ~a_restraindeny2, ~a_restraindeny3,
    ~a_restraindeny4, ~a_restraindeny5, ~a_restraindeny6,
    ~a_restraindeny7, ~a_restraindeny8, ~a_restraindeny9,
    ~a_restraindeny96, ~a_restraindeny97, ~a_ccare, ~a_ccwork,
    ~a_hlphmwk, ~a_levelimp, ~a_samsch, ~a_socialkid, ~a_dinner,
    ~a_quarrel, ~a_talkmatter, ~a_praisekid, ~a_ruleskid, ~a_slapkid,
    ~a_cuddlekid, ~a_yellkid, ~a_lvrel1, ~a_lvrel2, ~a_lvrel3,
    ~a_lvrel4, ~a_lvrel5, ~a_lvrel6, ~a_lvrel7, ~a_lvrel8,
    ~a_lvrel96, ~a_maage, ~a_paage, ~a_nrelsw11, ~a_nrelsw12,
    ~a_nrelsw13, ~a_nrelsw14, ~a_nrelsw15, ~a_nrelsw16, ~a_parmar,
    ~a_ohch16, ~a_seekid, ~a_wekid, ~a_farkid, ~a_relkid, ~a_masee,
    ~a_macon, ~a_mafar, ~a_pasee, ~a_pacon, ~a_pafar, ~a_chsee,
    ~a_chcon, ~a_chfar, ~a_kidspt, ~a_ftexv, ~a_ftexw, ~a_remit1,
    ~a_remit2, ~a_remit3, ~a_remit4, ~a_remit5, ~a_remitfreq1,
    ~a_remitreg1, ~a_remitamt1, ~a_remcntry1, ~a_remitusual1,
    ~a_remusamt1, ~a_remitfreq2, ~a_remitreg2, ~a_remitamt2,
    ~a_remcntry2, ~a_remitusual2, ~a_remusamt2, ~a_remitfreq3,
    ~a_remitreg3, ~a_remitamt3, ~a_remcntry3, ~a_remitusual3,
    ~a_remusamt3, ~a_remitfreq4, ~a_remitreg4, ~a_remitamt4,
    ~a_remcntry4, ~a_remitusual4, ~a_remusamt4, ~a_btype1, ~a_btype2,
    ~a_btype3, ~a_btype4, ~a_btype5, ~a_btype6, ~a_btype7, ~a_btype8,
    ~a_btype9, ~a_btype96, ~a_benunemp1, ~a_benunemp2, ~a_benunemp96,
    ~a_bendis1, ~a_bendis2, ~a_bendis3, ~a_bendis4, ~a_bendis5,
    ~a_bendis6, ~a_bendis7, ~a_bendis8, ~a_bendis9, ~a_bendis10,
    ~a_bendis11, ~a_bendis96, ~a_benpen1, ~a_benpen2, ~a_benpen3,
    ~a_benpen4, ~a_benpen5, ~a_benpen6, ~a_benpen7, ~a_benpen8,
    ~a_benpen96, ~a_niserps, ~a_bencb, ~a_benctc, ~a_benfam1,
    ~a_benfam2, ~a_benfam3, ~a_benfam4, ~a_benfam5, ~a_benfam96,
    ~a_bentax1, ~a_bentax2, ~a_bentax3, ~a_bentax4, ~a_bentax5,
    ~a_bentax96, ~a_benhou1, ~a_benhou2, ~a_benhou3, ~a_benhou4,
    ~a_benhou96, ~a_bensta1, ~a_bensta2, ~a_bensta3, ~a_bensta4,
    ~a_bensta5, ~a_bensta6, ~a_bensta7, ~a_bensta8, ~a_bensta96,
    ~a_fiyrdia, ~a_fiyrdb1, ~a_fiyrdb2, ~a_fiyrdb3, ~a_fiyrdb4,
    ~a_fiyrdb5, ~a_fiyrdb6, ~a_finnow, ~a_finfut, ~a_vote1, ~a_vote2,
    ~a_vote3, ~a_vote4, ~a_vote5, ~a_vote6, ~a_unsafew11,
    ~a_unsafew12, ~a_unsafew13, ~a_unsafew14, ~a_unsafew15,
    ~a_unsafew16, ~a_unsafew17, ~a_unsafew196, ~a_unsafew197,
    ~a_resunsafew1_1_1, ~a_resunsafew1_1_2, ~a_resunsafew1_1_3,
    ~a_resunsafew1_1_4, ~a_resunsafew1_1_5, ~a_resunsafew1_1_6,
    ~a_resunsafew1_1_7, ~a_resunsafew1_1_8, ~a_resunsafew1_1_9,
    ~a_resunsafew1_1_96, ~a_resunsafew1_1_97, ~a_resunsafew1_2_1,
    ~a_resunsafew1_2_2, ~a_resunsafew1_2_3, ~a_resunsafew1_2_4,
    ~a_resunsafew1_2_5, ~a_resunsafew1_2_6, ~a_resunsafew1_2_7,
    ~a_resunsafew1_2_8, ~a_resunsafew1_2_9, ~a_resunsafew1_2_96,
    ~a_resunsafew1_2_97, ~a_resunsafew1_3_1, ~a_resunsafew1_3_2,
    ~a_resunsafew1_3_3, ~a_resunsafew1_3_4, ~a_resunsafew1_3_5,
    ~a_resunsafew1_3_6, ~a_resunsafew1_3_7, ~a_resunsafew1_3_8,
    ~a_resunsafew1_3_9, ~a_resunsafew1_3_96, ~a_resunsafew1_3_97,
    ~a_resunsafew1_4_1, ~a_resunsafew1_4_2, ~a_resunsafew1_4_3,
    ~a_resunsafew1_4_4, ~a_resunsafew1_4_5, ~a_resunsafew1_4_6,
    ~a_resunsafew1_4_7, ~a_resunsafew1_4_8, ~a_resunsafew1_4_9,
    ~a_resunsafew1_4_96, ~a_resunsafew1_4_97, ~a_resunsafew1_5_1,
    ~a_resunsafew1_5_2, ~a_resunsafew1_5_3, ~a_resunsafew1_5_4,
    ~a_resunsafew1_5_5, ~a_resunsafew1_5_6, ~a_resunsafew1_5_7,
    ~a_resunsafew1_5_8, ~a_resunsafew1_5_9, ~a_resunsafew1_5_96,
    ~a_resunsafew1_5_97, ~a_resunsafew1_6_1, ~a_resunsafew1_6_2,
    ~a_resunsafew1_6_3, ~a_resunsafew1_6_4, ~a_resunsafew1_6_5,
    ~a_resunsafew1_6_6, ~a_resunsafew1_6_7, ~a_resunsafew1_6_8,
    ~a_resunsafew1_6_9, ~a_resunsafew1_6_96, ~a_resunsafew1_6_97,
    ~a_resunsafew1_7_1, ~a_resunsafew1_7_2, ~a_resunsafew1_7_3,
    ~a_resunsafew1_7_4, ~a_resunsafew1_7_5, ~a_resunsafew1_7_6,
    ~a_resunsafew1_7_7, ~a_resunsafew1_7_8, ~a_resunsafew1_7_9,
    ~a_resunsafew1_7_96, ~a_resunsafew1_7_97, ~a_resunsafew1_97_1,
    ~a_resunsafew1_97_2, ~a_resunsafew1_97_3, ~a_resunsafew1_97_4,
    ~a_resunsafew1_97_5, ~a_resunsafew1_97_6, ~a_resunsafew1_97_7,
    ~a_resunsafew1_97_8, ~a_resunsafew1_97_9, ~a_resunsafew1_97_96,
    ~a_resunsafew1_97_97, ~a_avoidancew11, ~a_avoidancew12,
    ~a_avoidancew13, ~a_avoidancew14, ~a_avoidancew15,
    ~a_avoidancew16, ~a_avoidancew17, ~a_avoidancew196,
    ~a_avoidancew197, ~a_resavoidw1_1_1, ~a_resavoidw1_1_2,
    ~a_resavoidw1_1_3, ~a_resavoidw1_1_4, ~a_resavoidw1_1_5,
    ~a_resavoidw1_1_6, ~a_resavoidw1_1_7, ~a_resavoidw1_1_8,
    ~a_resavoidw1_1_9, ~a_resavoidw1_1_96, ~a_resavoidw1_1_97,
    ~a_resavoidw1_2_1, ~a_resavoidw1_2_2, ~a_resavoidw1_2_3,
    ~a_resavoidw1_2_4, ~a_resavoidw1_2_5, ~a_resavoidw1_2_6,
    ~a_resavoidw1_2_7, ~a_resavoidw1_2_8, ~a_resavoidw1_2_9,
    ~a_resavoidw1_2_96, ~a_resavoidw1_2_97, ~a_resavoidw1_3_1,
    ~a_resavoidw1_3_2, ~a_resavoidw1_3_3, ~a_resavoidw1_3_4,
    ~a_resavoidw1_3_5, ~a_resavoidw1_3_6, ~a_resavoidw1_3_7,
    ~a_resavoidw1_3_8, ~a_resavoidw1_3_9, ~a_resavoidw1_3_96,
    ~a_resavoidw1_3_97, ~a_resavoidw1_4_1, ~a_resavoidw1_4_2,
    ~a_resavoidw1_4_3, ~a_resavoidw1_4_4, ~a_resavoidw1_4_5,
    ~a_resavoidw1_4_6, ~a_resavoidw1_4_7, ~a_resavoidw1_4_8,
    ~a_resavoidw1_4_9, ~a_resavoidw1_4_96, ~a_resavoidw1_4_97,
    ~a_resavoidw1_5_1, ~a_resavoidw1_5_2, ~a_resavoidw1_5_3,
    ~a_resavoidw1_5_4, ~a_resavoidw1_5_5, ~a_resavoidw1_5_6,
    ~a_resavoidw1_5_7, ~a_resavoidw1_5_8, ~a_resavoidw1_5_9,
    ~a_resavoidw1_5_96, ~a_resavoidw1_5_97, ~a_resavoidw1_6_1,
    ~a_resavoidw1_6_2, ~a_resavoidw1_6_3, ~a_resavoidw1_6_4,
    ~a_resavoidw1_6_5, ~a_resavoidw1_6_6, ~a_resavoidw1_6_7,
    ~a_resavoidw1_6_8, ~a_resavoidw1_6_9, ~a_resavoidw1_6_96,
    ~a_resavoidw1_6_97, ~a_resavoidw1_7_1, ~a_resavoidw1_7_2,
    ~a_resavoidw1_7_3, ~a_resavoidw1_7_4, ~a_resavoidw1_7_5,
    ~a_resavoidw1_7_6, ~a_resavoidw1_7_7, ~a_resavoidw1_7_8,
    ~a_resavoidw1_7_9, ~a_resavoidw1_7_96, ~a_resavoidw1_7_97,
    ~a_resavoidw1_97_1, ~a_resavoidw1_97_2, ~a_resavoidw1_97_3,
    ~a_resavoidw1_97_4, ~a_resavoidw1_97_5, ~a_resavoidw1_97_6,
    ~a_resavoidw1_97_7, ~a_resavoidw1_97_8, ~a_resavoidw1_97_9,
    ~a_resavoidw1_97_96, ~a_resavoidw1_97_97, ~a_insultedw11,
    ~a_insultedw12, ~a_insultedw13, ~a_insultedw14, ~a_insultedw15,
    ~a_insultedw16, ~a_insultedw17, ~a_insultedw196, ~a_insultedw197,
    ~a_resinsultedw1_1_1, ~a_resinsultedw1_1_2, ~a_resinsultedw1_1_3,
    ~a_resinsultedw1_1_4, ~a_resinsultedw1_1_5, ~a_resinsultedw1_1_6,
    ~a_resinsultedw1_1_7, ~a_resinsultedw1_1_8, ~a_resinsultedw1_1_9,
    ~a_resinsultedw1_1_96, ~a_resinsultedw1_1_97,
    ~a_resinsultedw1_2_1, ~a_resinsultedw1_2_2, ~a_resinsultedw1_2_3,
    ~a_resinsultedw1_2_4, ~a_resinsultedw1_2_5, ~a_resinsultedw1_2_6,
    ~a_resinsultedw1_2_7, ~a_resinsultedw1_2_8, ~a_resinsultedw1_2_9,
    ~a_resinsultedw1_2_96, ~a_resinsultedw1_2_97,
    ~a_resinsultedw1_3_1, ~a_resinsultedw1_3_2, ~a_resinsultedw1_3_3,
    ~a_resinsultedw1_3_4, ~a_resinsultedw1_3_5, ~a_resinsultedw1_3_6,
    ~a_resinsultedw1_3_7, ~a_resinsultedw1_3_8, ~a_resinsultedw1_3_9,
    ~a_resinsultedw1_3_96, ~a_resinsultedw1_3_97,
    ~a_resinsultedw1_4_1, ~a_resinsultedw1_4_2, ~a_resinsultedw1_4_3,
    ~a_resinsultedw1_4_4, ~a_resinsultedw1_4_5, ~a_resinsultedw1_4_6,
    ~a_resinsultedw1_4_7, ~a_resinsultedw1_4_8, ~a_resinsultedw1_4_9,
    ~a_resinsultedw1_4_96, ~a_resinsultedw1_4_97,
    ~a_resinsultedw1_5_1, ~a_resinsultedw1_5_2, ~a_resinsultedw1_5_3,
    ~a_resinsultedw1_5_4, ~a_resinsultedw1_5_5, ~a_resinsultedw1_5_6,
    ~a_resinsultedw1_5_7, ~a_resinsultedw1_5_8, ~a_resinsultedw1_5_9,
    ~a_resinsultedw1_5_96, ~a_resinsultedw1_5_97,
    ~a_resinsultedw1_6_1, ~a_resinsultedw1_6_2, ~a_resinsultedw1_6_3,
    ~a_resinsultedw1_6_4, ~a_resinsultedw1_6_5, ~a_resinsultedw1_6_6,
    ~a_resinsultedw1_6_7, ~a_resinsultedw1_6_8, ~a_resinsultedw1_6_9,
    ~a_resinsultedw1_6_96, ~a_resinsultedw1_6_97,
    ~a_resinsultedw1_7_1, ~a_resinsultedw1_7_2, ~a_resinsultedw1_7_3,
    ~a_resinsultedw1_7_4, ~a_resinsultedw1_7_5, ~a_resinsultedw1_7_6,
    ~a_resinsultedw1_7_7, ~a_resinsultedw1_7_8, ~a_resinsultedw1_7_9,
    ~a_resinsultedw1_7_96, ~a_resinsultedw1_7_97,
    ~a_resinsultedw1_97_1, ~a_resinsultedw1_97_2,
    ~a_resinsultedw1_97_3, ~a_resinsultedw1_97_4,
    ~a_resinsultedw1_97_5, ~a_resinsultedw1_97_6,
    ~a_resinsultedw1_97_7, ~a_resinsultedw1_97_8,
    ~a_resinsultedw1_97_9, ~a_resinsultedw1_97_96,
    ~a_resinsultedw1_97_97, ~a_attackedw11, ~a_attackedw12,
    ~a_attackedw13, ~a_attackedw14, ~a_attackedw15, ~a_attackedw16,
    ~a_attackedw17, ~a_attackedw196, ~a_attackedw197,
    ~a_resattackedw1_1_1, ~a_resattackedw1_1_2, ~a_resattackedw1_1_3,
    ~a_resattackedw1_1_4, ~a_resattackedw1_1_5, ~a_resattackedw1_1_6,
    ~a_resattackedw1_1_7, ~a_resattackedw1_1_8, ~a_resattackedw1_1_9,
    ~a_resattackedw1_1_96, ~a_resattackedw1_1_97,
    ~a_resattackedw1_2_1, ~a_resattackedw1_2_2, ~a_resattackedw1_2_3,
    ~a_resattackedw1_2_4, ~a_resattackedw1_2_5, ~a_resattackedw1_2_6,
    ~a_resattackedw1_2_7, ~a_resattackedw1_2_8, ~a_resattackedw1_2_9,
    ~a_resattackedw1_2_96, ~a_resattackedw1_2_97,
    ~a_resattackedw1_3_1, ~a_resattackedw1_3_2, ~a_resattackedw1_3_3,
    ~a_resattackedw1_3_4, ~a_resattackedw1_3_5, ~a_resattackedw1_3_6,
    ~a_resattackedw1_3_7, ~a_resattackedw1_3_8, ~a_resattackedw1_3_9,
    ~a_resattackedw1_3_96, ~a_resattackedw1_3_97,
    ~a_resattackedw1_4_1, ~a_resattackedw1_4_2, ~a_resattackedw1_4_3,
    ~a_resattackedw1_4_4, ~a_resattackedw1_4_5, ~a_resattackedw1_4_6,
    ~a_resattackedw1_4_7, ~a_resattackedw1_4_8, ~a_resattackedw1_4_9,
    ~a_resattackedw1_4_96, ~a_resattackedw1_4_97,
    ~a_resattackedw1_5_1, ~a_resattackedw1_5_2, ~a_resattackedw1_5_3,
    ~a_resattackedw1_5_4, ~a_resattackedw1_5_5, ~a_resattackedw1_5_6,
    ~a_resattackedw1_5_7, ~a_resattackedw1_5_8, ~a_resattackedw1_5_9,
    ~a_resattackedw1_5_96, ~a_resattackedw1_5_97,
    ~a_resattackedw1_6_1, ~a_resattackedw1_6_2, ~a_resattackedw1_6_3,
    ~a_resattackedw1_6_4, ~a_resattackedw1_6_5, ~a_resattackedw1_6_6,
    ~a_resattackedw1_6_7, ~a_resattackedw1_6_8, ~a_resattackedw1_6_9,
    ~a_resattackedw1_6_96, ~a_resattackedw1_6_97,
    ~a_resattackedw1_7_1, ~a_resattackedw1_7_2, ~a_resattackedw1_7_3,
    ~a_resattackedw1_7_4, ~a_resattackedw1_7_5, ~a_resattackedw1_7_6,
    ~a_resattackedw1_7_7, ~a_resattackedw1_7_8, ~a_resattackedw1_7_9,
    ~a_resattackedw1_7_96, ~a_resattackedw1_7_97,
    ~a_resattackedw1_97_1, ~a_resattackedw1_97_2,
    ~a_resattackedw1_97_3, ~a_resattackedw1_97_4,
    ~a_resattackedw1_97_5, ~a_resattackedw1_97_6,
    ~a_resattackedw1_97_7, ~a_resattackedw1_97_8,
    ~a_resattackedw1_97_9, ~a_resattackedw1_97_96,
    ~a_resattackedw1_97_97, ~a_envhabit1, ~a_envhabit2, ~a_envhabit3,
    ~a_envhabit4, ~a_envhabit5, ~a_envhabit6, ~a_envhabit7,
    ~a_envhabit8, ~a_envhabit9, ~a_envhabit10, ~a_envhabit11,
    ~a_drive, ~a_carmiles, ~a_mobuse, ~a_netuse, ~a_howlng,
    ~a_healthlink, ~a_flaglink, ~a_edlinkb, ~a_nch14resp,
    ~a_nch415resp, ~a_nchresp, ~a_nchund18resp, ~a_natch01,
    ~a_natch02, ~a_natch03, ~a_natch04, ~a_natch05, ~a_natch06,
    ~a_natch07, ~a_natch08, ~a_natch09, ~a_natch10, ~a_natch11,
    ~a_natch12, ~a_natch13, ~a_natch14, ~a_natch15, ~a_natch16,
    ~a_nnatch, ~a_nadoptch, ~a_adoptch01, ~a_adoptch02, ~a_adoptch03,
    ~a_adoptch04, ~a_adoptch05, ~a_adoptch06, ~a_adoptch07,
    ~a_adoptch08, ~a_adoptch09, ~a_adoptch10, ~a_adoptch11,
    ~a_adoptch12, ~a_adoptch13, ~a_adoptch14, ~a_adoptch15,
    ~a_adoptch16, ~a_nchunder16, ~a_nch5to15, ~a_nch10to15,
    ~a_allch01, ~a_allch02, ~a_allch03, ~a_allch04, ~a_allch05,
    ~a_allch06, ~a_allch07, ~a_allch08, ~a_allch09, ~a_allch10,
    ~a_allch11, ~a_allch12, ~a_allch13, ~a_allch14, ~a_allch15,
    ~a_allch16, ~a_privpen, ~a_maintalim, ~a_payfam, ~a_lenindintv,
    ~a_kid2uni1, ~a_k2ucpn1, ~a_kid2uni2, ~a_k2ucpn2, ~a_kid2uni3,
    ~a_k2ucpn3, ~a_kid2uni4, ~a_k2ucpn4, ~a_kid2uni5, ~a_k2ucpn5,
    ~a_scdoby4, ~a_scsex, ~a_scghqa, ~a_scghqb, ~a_scghqc, ~a_scghqd,
    ~a_scghqe, ~a_scghqf, ~a_scghqg, ~a_scghqh, ~a_scghqi, ~a_scghqj,
    ~a_scghqk, ~a_scghql, ~a_schrs_slph, ~a_schrs_slpm,
    ~a_sctslp_30m, ~a_sctslp_wak, ~a_sctslp_cgh, ~a_scmed_slp,
    ~a_sctsta_awk, ~a_scslp_qual, ~a_scenv_ftst, ~a_scenv_crlf,
    ~a_scenv_grn, ~a_scenv_ccls, ~a_scenv_pmre, ~a_scenv_dstr,
    ~a_scenv_exag, ~a_scenv_bcon, ~a_scenv_futr, ~a_scenv_cfit,
    ~a_scenv_chwo, ~a_scenv_brit, ~a_scopecl30, ~a_scopecl200,
    ~a_scopngbha, ~a_scopngbhb, ~a_scopngbhc, ~a_scopngbhd,
    ~a_scopngbhe, ~a_scopngbhf, ~a_scopngbhg, ~a_scopngbhh,
    ~a_sctrust, ~a_sclfsat1, ~a_sclfsat2, ~a_sclfsat7, ~a_sclfsato,
    ~a_scwemwba, ~a_scwemwbb, ~a_scwemwbc, ~a_scwemwbd, ~a_scwemwbe,
    ~a_scwemwbf, ~a_scwemwbg, ~a_scriska, ~a_scriskb, ~a_scmolwp,
    ~a_screlparei, ~a_screlparcd, ~a_screlparwt, ~a_screlpards,
    ~a_screlparrg, ~a_screlparar, ~a_screlparir, ~a_screlparks,
    ~a_scparoutint, ~a_screlhappy, ~a_ivprsnt, ~a_ivinfnce,
    ~a_ivaffct11, ~a_ivaffct12, ~a_ivaffct13, ~a_ivaffct14,
    ~a_ivaffct15, ~a_ivaffct17, ~a_ivaffct21, ~a_ivaffct22,
    ~a_ivaffct23, ~a_ivaffct27, ~a_ivaffct30, ~a_ivaffct97,
    ~a_ivcoop, ~a_susp, ~a_undqus, ~a_ivtrans, ~a_prsex, ~a_prel,
    ~a_preason, ~a_pripn, ~a_ch1by4, ~a_pjulk4wk, ~a_pjbptft,
    ~a_pjsptft, ~a_prearn, ~a_prearnw_w1, ~a_prearna_w1, ~a_pbnft1,
    ~a_pbnft2, ~a_pbnft3, ~a_pbnft4, ~a_pbnft5, ~a_pbnft6, ~a_pbnft7,
    ~a_pbnft8, ~a_pbnft9, ~a_pbnft10, ~a_pbnft11, ~a_pbnft12,
    ~a_pbnft96, ~a_caruse, ~a_prfitb, ~a_prfitbw_w1, ~a_prfitba_w1,
    ~a_emboost, ~a_gpcomp, ~a_lda, ~a_ageest, ~a_marstat, ~a_livesp,
    ~a_livewith, ~a_employ, ~a_hgbiom, ~a_hgbiof, ~a_hgadoptm,
    ~a_hgadoptf, ~a_hgpart, ~a_respf16, ~a_respm16, ~a_adresp17,
    ~a_ethnic1, ~a_ethnic2, ~a_ethnic3, ~a_ethnic4, ~a_ethnic5,
    ~a_ethnic6, ~a_ethnic7, ~a_ethnic8, ~a_ethnic9, ~a_ethnic10,
    ~a_ethnic11, ~a_ethnic12, ~a_ethnic13, ~a_ethnic14, ~a_ethnic96,
    ~a_lingua, ~a_reasref, ~a_ivintlang, ~a_ivwhoint, ~a_ldaflag,
    ~a_hhsttime_tm, ~a_qsignin_tm, ~a_hhgrid_tm, ~a_relationships_tm,
    ~a_hhqre_tm, ~a_proxy_tm, ~a_demog_tm, ~a_initial_tm,
    ~a_family_tm, ~a_ethnic_tm, ~a_religion_tm, ~a_migration_tm,
    ~a_partner_tm, ~a_fertility_tm, ~a_health_tm, ~a_caring_tm,
    ~a_empstat_tm, ~a_employment_tm, ~a_selfemp_tm, ~a_job_tm,
    ~a_nonemp_tm, ~a_secjob_tm, ~a_discrimination_tm,
    ~a_childcare_tm, ~a_parchild_tm, ~a_networks_tm,
    ~a_remittance_tm, ~a_benefit_tm, ~a_finances_tm, ~a_political_tm,
    ~a_harassment_tm, ~a_environ_tm, ~a_consent_tm, ~a_phone_tm,
    ~a_stable_tm, ~a_finint_tm, ~a_observe_tm, ~a_impevent1,
    ~a_impevent1s, ~a_impevent2, ~a_impevent2s, ~a_impevent3,
    ~a_impevent3s, ~a_impevent4, ~a_impevent4s, ~a_rhland_code,
    ~a_rphmob_code, ~a_rphwrk_code, ~a_remail_code, ~a_ctadd1_code,
    ~a_ctadd2_code, ~a_cttown_code, ~a_ctcnty_code, ~a_ctpcode_code,
    ~a_cttel1_code, ~a_cttel2_code, ~a_ctemail_code, ~a_intdatd_if,
    ~a_intdatm_if, ~a_intdaty_if, ~a_doby_if, ~a_age_if, ~a_ppsex,
    ~a_fnpid, ~a_mnpid, ~a_pn1pid, ~a_pn1pno, ~a_pn1sex, ~a_pn2pid,
    ~a_pn2pno, ~a_pn2sex, ~a_pns1pid, ~a_pns1pno, ~a_pns1sex,
    ~a_pns2pid, ~a_pns2pno, ~a_pns2sex, ~a_grfpid, ~a_grmpid,
    ~a_istrtdathh, ~a_istrtdatmm, ~a_istrtdatss, ~a_ienddathh,
    ~a_ienddatmm, ~a_ienddatss, ~a_j2pay_if, ~a_fimngrs_tc,
    ~a_fimngrs_dv, ~a_fimnlabgrs_tc, ~a_fimnlabgrs_dv,
    ~a_fimnlabnet_tc, ~a_fimnlabnet_dv, ~a_fiyrinvinc_tc,
    ~a_fiyrinvinc_dv, ~a_fibenothr_tc, ~a_fibenothr_dv, ~a_paygl,
    ~a_paynl, ~a_jsprf, ~a_paygu_dv, ~a_payg_dv, ~a_paynu_dv,
    ~a_payn_dv, ~a_seearngrs_dv, ~a_seearnnet_dv, ~a_j2pay_dv,
    ~a_j2paynet_dv, ~a_sex_dv, ~a_age_dv, ~a_intdatd_dv,
    ~a_intdatm_dv, ~a_intdaty_dv, ~a_doby_dv, ~a_pensioner_dv,
    ~a_marstat_dv, ~a_npn_dv, ~a_npns_dv, ~a_ngrp_dv, ~a_nnsib_dv,
    ~a_nnssib_dv, ~a_npensioner_dv, ~a_j1nssec8_dv, ~a_panssec8_dv,
    ~a_manssec8_dv, ~a_j2nssec8_dv, ~a_nbrsnci_dv, ~a_scdassat_dv,
    ~a_scdascoh_dv, ~a_ethn_dv, ~a_fimnmisc_dv, ~a_fimnprben_dv,
    ~a_fimninvnet_dv, ~a_fimnpen_dv, ~a_fimnsben_dv, ~a_fimnnet_dv,
    ~a_country, ~a_gor_dv, ~a_urban_dv, ~a_hhresp_dv, ~a_xtra5min_dv,
    ~a_agegr5_dv, ~a_agegr10_dv, ~a_agegr13_dv, ~a_livesp_dv,
    ~a_cohab_dv, ~a_single_dv, ~a_mastat_dv, ~a_hhtype_dv,
    ~a_buno_dv, ~a_depchl_dv, ~a_nchild_dv, ~a_ndepchl_dv,
    ~a_adresp15_dv, ~a_respm16_dv, ~a_respf16_dv, ~a_rach16_dv,
    ~a_hrpid, ~a_hrpno, ~a_ppid, ~a_ppno, ~a_sppid, ~a_sppno,
    ~a_fnpno, ~a_fnspid, ~a_fnspno, ~a_mnpno, ~a_mnspid, ~a_mnspno,
    ~a_grfpno, ~a_grmpno, ~a_qfhigh_dv, ~a_qfhighfl_dv, ~a_hiqual_dv,
    ~a_jbft_dv, ~a_jbsoc00_cc, ~a_jbsoc10_cc, ~a_jbsic07_cc,
    ~a_jbiindb_dv, ~a_jbes2000, ~a_jbseg_dv, ~a_jbrgsc_dv,
    ~a_jbnssec_dv, ~a_jbnssec8_dv, ~a_jbnssec5_dv, ~a_jbisco88_cc,
    ~a_jlsoc00_cc, ~a_jlsoc10_cc, ~a_jlsic07_cc, ~a_jliindb_dv,
    ~a_jles2000, ~a_jlseg_dv, ~a_jlrgsc_dv, ~a_jlnssec_dv,
    ~a_jlnssec8_dv, ~a_jlnssec5_dv, ~a_jlisco88_cc, ~a_pasoc90_cc,
    ~a_pasoc00_cc, ~a_pasoc10_cc, ~a_masoc90_cc, ~a_masoc00_cc,
    ~a_masoc10_cc, ~a_j1soc90_cc, ~a_j1soc00_cc, ~a_j1soc10_cc,
    ~a_j2soc90_cc, ~a_j2soc00_cc, ~a_j2soc10_cc, ~a_scghq1_dv,
    ~a_scghq2_dv, ~a_sf12pcs_dv, ~a_sf12mcs_dv, ~a_swemwbs_dv,
    ~a_bmi_dv, ~a_scflag_dv, ~a_attacked_dv, ~a_avoided_dv,
    ~a_insulted_dv, ~a_unsafe_dv, ~a_payu_dv, ~a_paygu_if,
    ~a_paynu_if, ~a_seearngrs_if, ~a_fiyrinvinc_if, ~a_fibenothr_if,
    ~a_fimnlabgrs_if, ~a_fimngrs_if, ~a_indpxus_xw, ~a_indinus_xw,
    ~a_indscus_xw, ~a_ind5mus_xw, ~a_jbnssec3_dv, ~a_jlnssec3_dv,
    ~a_racel_dv, 1, "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    0, "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8",
    "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", "-8", 1, 1, 1, 0,
    "-8", "-8", "1"
  )




  test_convert_compile <- function() {

    withr::local_envvar(DATA_DIRECTORY = ".")

    usoc_convert("test", "test_rds_data/")

    usoc_compile("test_rds_data", save_to_folder = TRUE)

    usoc_load()
  }


  withr::with_file(list(fs::dir_create("test"),
    fs::dir_create("test/bhps"),
    fs::dir_create("test/ukhls"),
    fs::dir_create("test_rds_data"),
    fs::dir_create("test_rds_data/ukhls"),
    fs::dir_create("test_rds_data/bhps"),
    "test/bhps/ba_indresp.sav" = haven::write_sav(test_data, "test/bhps/ba_indresp.sav"),
    "test/ukhls/a_indresp.sav" = haven::write_sav(test_data, "test/ukhls/a_indresp.sav"),
    "usoc_indresp_data.fst",
    "usoc_indresp_variables_report.csv"
  ), {
    expect_error(suppressMessages(test_convert_compile()), NA)
  })
})
