000100230227**Free
000101230227
000102230227// **********************************************************************************************
000103230227// The current code works with the CIS270P6 DSPF file.                                          *
000104230310// Within the code there are errors that will display depending on Actions chosen.              *
000105231001// With this program, the user can ADD, UPDATE or DELETE records from the MYINSTP file.          *
000106230310// Data validation is used in order for a record to not be duplicated and also                  *
000107230310// for the user to not to be allowed to enter the wrong data into certain fields.               *
000108230310//                                                                                              *
000109230310// Programmer: Steven Conyer Date: 2/20/2023    Date Revised:  3/10/2023                        *
000110230227//                                                                                              *
000111230227// **********************************************************************************************
000112230227
000113230301
000123230301// ------Control Statement-----------------------------------
000124230301Ctl-opt option(*srcStmt: *nodebugio);
000125230301
000126230301DCL-S Action Char(1);
000127230301
000128230301// ------Declare Files---------------------------------------
000129230301DCL-F MYINSTP Usage(*Update:*Output:*Delete) Keyed;
000130230301
000131230301DCL-F CIS270P6  Workstn INDDS(Indicators);
000132230306
000137230301// ------Data Structure for Errors and Exits-----------------
000138230301DCL-DS Indicators Len(99);
000139230307  Exit      Ind Pos(3);  // Exit program
000140230301  F10key    Ind Pos(10); // Used to delete
000141230307  Cancel    Ind Pos(12); // Cancel
000142230301  Fkey      Ind Pos(25); // Vldcmdkey
000143230301  Adderror  Ind Pos(30); // Instructor already exists
000144230301  Chgerror  Ind Pos(31); // Instructor not found
000145230301  Dlterror  Ind Pos(32); // Customer not found for deletion
000146230301  Addmode   Ind Pos(41); // Add record
000147230301  Chgmode   Ind Pos(42); // Change record
000148230301  Dltmode   Ind Pos(43); // Delete record
000149230303  Inputerr  Ind Pos(90); // Invalid input error
000150230307  INVALRANK Ind Pos(91); // Invalid input error
000151230307  INVALSEX  Ind Pos(92); // Invalid input error
000152230307  INVALMARS Ind Pos(93); // Invalid input error
000153230307  INVALTEN  Ind Pos(94); // Invalid input error
000154230307  INVALTTL  Ind Pos(95); // Invalid input error
000155230301END-DS;
000156230301
000157230301// ------Main Procedure--------------------------------------
000158230301Dow Not Exit;
000159230301  Exfmt SCRN1;
000160230303
000161230303  If Action <> 'A' and Action <> 'C' and Action <> 'D';
000162230303    Inputerr = *On;
000163230303  ENDIF;
000168230306
000195230303  Select;
000196230301  When Exit;
000197230301    Leave;
000198230301  When Action = 'A';
000199230301    Exsr Addrecord;
000200230301  When Action = 'C';
000201230301    Exsr Chgrecord;
000202230301  When Action = 'D';
000203230301    Exsr Dltrecord;
000204230301  ENDSL;
000205230306
000211230301ENDDO;
000212230301
000213230301*Inlr = *On;
000214230301Return;
000215230301
000216230301// ------Add Record------------------------------------------
000237230301Begsr Addrecord;
000241230305  Exsr Setmode;
000242230301  Chain(n) INSTNO MYINSTP;
000243230301  Adderror = %found(MYINSTP);
000244230306
000245230309  DATEIN = *Loval; //sets date to USA format
000251230306
000252230301  If Not Adderror;
000253230301    Exsr ResetData;
000254230301    Exfmt SCRN2;
000255230307
000266230309    If Not Fkey;
000267230309      DOW (RANK <> '1' and RANK <> '2' and RANK <> '3' and RANK <> '4' and Not Fkey);
000268230309        INVALRANK = *On;
000269230309        exfmt SCRN2;
000270230309      ENDDO;
000271230309
000272230309      DOW (SEX <> 'M' and SEX <> 'F' and Not Fkey);
000273230309        INVALSEX = *On;
000274230309        exfmt SCRN2;
000275230309      ENDDO;
000276230309
000277230309      DOW (MARSTS <> 'M' and MARSTS <> 'S' and Not Fkey);
000278230309        INVALMARS = *On;
000279230309        exfmt SCRN2;
000280230309      ENDDO;
000281230309
000282230309      DOW (TENURE <> 'Y' and TENURE <> 'N' and Not Fkey);
000283230309        INVALTEN = *On;
000284230309        exfmt SCRN2;
000285230309      ENDDO;
000286230309      DOW (TITLE <> '1' and TITLE <> '2' and TITLE <> '3' and TITLE <> '4' and Not Fkey);
000287230309        INVALTTL = *On;
000288230309        exfmt SCRN2;
000289230309      ENDDO;
000291230309
000292230309      HIRDAT = %DEC(DATEIN); // converts USA date format to legacy format
000293230308
000294230308      If Not Fkey;
000295230308        Write INSTREC;
000296230308        Reset Action;
000297230308        Reset INSTNO;
000298230308      ENDIF;
000299230308
000300230308    ENDIF;
000301230308  ENDIF;
000302230301ENDSR;
000303230301
000304230301// ------Change Record---------------------------------------
000305230301Begsr Chgrecord;
000306230301  Exsr Setmode;
000308230301  Chain INSTNO MYINSTP;
000309230301  Chgerror = Not %Found(MYINSTP);
000310230309
000311230309  DATEIN = %DATE(HIRDAT); //convert legacy date to USA date format
000312230306
000313230305  If Not Chgerror;
000314230306    Exfmt SCRN2;
000315230309
000316230309    If Not Fkey;
000317230309      DOW (RANK <> '1' and RANK <> '2' and RANK <> '3' and RANK <> '4' and Not Fkey);
000318230309        INVALRANK = *On;
000319230309        exfmt SCRN2;
000320230309      ENDDO;
000321230309
000322230309      DOW (SEX <> 'M' and SEX <> 'F' and Not Fkey);
000323230309        INVALSEX = *On;
000324230309        exfmt SCRN2;
000325230309      ENDDO;
000326230309
000327230309      DOW (MARSTS <> 'M' and MARSTS <> 'S' and Not Fkey);
000328230309        INVALMARS = *On;
000329230309        exfmt SCRN2;
000330230309      ENDDO;
000331230309
000332230309      DOW (TENURE <> 'Y' and TENURE <> 'N' and Not Fkey);
000333230309        INVALTEN = *On;
000334230309        exfmt SCRN2;
000335230309      ENDDO;
000336230309      DOW (TITLE <> '1' and TITLE <> '2' and TITLE <> '3' and TITLE <> '4' and Not Fkey);
000338230309        INVALTTL = *On;
000339230309        exfmt SCRN2;
000340230309      ENDDO;
000345230309
000346230309      HIRDAT = %DEC(DATEIN); // converts USA date format to legacy format
000347230308
000348230308      If Not Fkey;
000349230308        Update INSTREC;
000350230308        Reset Action;
000351230308        Reset INSTNO;
000352230309      ENDIF;
000353230309
000354230309    ENDIF;
000355230309  ENDIF;
000357230301ENDSR;
000358230301
000359230301// ------Delete Record---------------------------------------
000360230301Begsr Dltrecord;
000361230301  Exsr Setmode;
000362230301  Chain INSTNO MYINSTP;
000363230301  Dlterror = Not %found(MYINSTP);
000364230309
000365230309  DATEIN = %DATE(HIRDAT); //convert legacy date to USA date format
000366230301
000367230301  If Not Dlterror;
000368230306    Exfmt SCRN2;
000369230301
000370230301    If F10key;
000371230301      Reset Action;
000372230301      Delete INSTREC;
000373230301      Reset INSTNO;
000374230301    ENDIF;
000375230304
000376230301  ENDIF;
000377230301ENDSR;
000378230301
000379230301// ------Reset Input-----------------------------------------
000380230301Begsr Resetdata;
000381230301  Reset IFNAME;
000382230301  Reset ILNAME;
000383230301  Reset DEPT;
000384230301  Reset SALARY;
000385230301  Reset RANK;
000386230301  Reset SEX;
000387230301  Reset HIRDAT;
000388230301  Reset MARSTS;
000389230301  Reset DEPEND;
000390230301  Reset TENURE;
000391230301  Reset TITLE;
000392230301ENDSR;
000393230301
000394230301// ------Mode Set--------------------------------------------
000395230301Begsr Setmode;
000396230301  Addmode = (Action = 'A');
000397230301  Chgmode = (Action = 'C');
000398230301  Dltmode = (Action = 'D');
000399230301ENDSR;
