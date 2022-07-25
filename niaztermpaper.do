use "\\files\users\mdniazc\Desktop\758 term paper\incomeTaxSaved.dta" 


*********** Drop Missing and zero taxable Income**************

drop if taxableIncome==.

/* should i have to drop o taxable income */ 
drop if taxableIncome==0

sort year
summarize year
summarize i.year
tabulate year, generate (y)
order year y1 y2 

gen v98=taxableIncome if year==1998
gen v2001=taxableIncome if year==2001

gen TaxLi98=taxAfterAdjustments if year==1998
gen TaxLi2001=taxAfterAdjustments if year==2001

gen v98N=v98
replace v98N=0 if v98==. 

gen v2001N=v2001
replace v2001N=0 if v2001==. 

........../***********generate Marginal Tax Rate 1998**************/...........


generate income12DM=0
replace income12DM= v98N if v98N<12365
replace income12DM= 12365 if v98N>=12365
replace income12DM=0 if v98N==.
replace income12DM=0 if income12DM==.

generate income58DM=0
replace income58DM= (v98N-12365) if (v98N >12365 & v98N <58643)
replace income58DM= (58643-12365) if v98N>58643
replace income58DM=0  if v98N==.

egen Y2E= rowtotal(income12DM income58DM)

gen Y2E1=Y2E if (Y2E >12365)
replace Y2E1=0 if Y2E==.
replace Y2E1=0 if Y2E1==.

gen INC=(Y2E1-12365)/10000
replace INC=0 if INC==.

gen inc1= (91.19*INC+2590)*INC
replace inc1=0 if inc1==.

generate income120DM=0
replace income120DM= v98N-58643 if (v98N >58643 & v98N  <120041)
replace income120DM= 61398 if v98N >120041
replace income120DM=0  if v98N==.

egen Y3E= rowtotal(Y2E income120DM)
replace Y3E=0 if Y3E==.

gen Y3E1=Y3E if (Y3E >58643)

gen INC1=(Y3E1-58643)/10000
replace INC1=0 if INC1==.

gen inc2= (151.96*INC1+3434)*INC1
replace inc2=0 if inc2==.

generate income120above=0
replace income120above= v98N-120041 if (v98N >120041)
replace income120above=0  if v98N==.

gen inc3=0.53*income120above-22843 
replace inc3=0 if (0.53*income120above)<22843

gen taxL = inc1 + inc2 +inc3
egen taxL1= rowtotal( inc1 inc2 inc3)

gen inc3N=inc3 
replace inc3N=0 if inc3==.

gen MTR98 = (taxL/v98N)*100

replace MTR98=0 if MTR98==.

gen MTR98N=MTR98 
replace MTR98N=0 if MTR98==.


************************ Marginal Tax Rate 2001***********************************

generate income14DM=0
replace income14DM= v2001N if v2001N<14093
replace income14DM= 14093  if v2001N>=14093

drop income18DM

generate income18DM=0
replace income18DM= (v2001-14093) if (v2001N >14093 & v2001N <18089)
replace income18DM= (18089-14093) if v2001N>18089


gen T2E= income14DM+ income18DM


gen T2E1=T2E if (T2E >14093)

gen TINC=(T2E1-14093)/10000
gen Tinc1= (387.89*TINC+1990)*TINC

generate income107DM=0
replace income107DM= v2001N-18089 if (v2001N >18089 & v2001N  <107567)
replace income107DM= 89474 if v2001N >107567

egen T3E= rowtotal(T2E income107DM)
gen T3E1=T3E if (T3E >18089)
gen TINC1=(T3E1-18089)/10000


gen Tinc2= (142.49*TINC1+2300)*TINC1+857
replace inc2=0 if inc2==.

generate income107above=0
replace income107above= v2001N-107568 if (v2001N >107568)


gen Tinc3=0.485*income107above-19299
replace Tinc3=0 if (0.485*income107above)<19299

gen MtaxL = Tinc1 + Tinc2 +Tinc3
egen MtaxL1= rowtotal( Tinc1 Tinc2 Tinc3)

gen MTR2001 = (MtaxL1/v2001N)*100
replace MTR2001=0 if MTR2001==.

gen MTR2001N=MTR2001
replace MTR2001N=0 if MTR2001==.

*************************************Add Marginal tax Rate 1998+2001****************************

egen addMTR = rowtotal(MTR98N MTR2001N)

*********************************************************************************
*********************************************************************************

*****************************************************Term paper Analysis***************************************************
*******************************************************************************************************************
********************************************************************************************************************


*********************SummarY Statistics ********************************
bysort children alter_a: sum taxableIncome
tab alter_a, sum (taxableIncome)
tab alter_b, sum (taxableIncome)
bysort female alter_a: sum taxableIncome
tab female
bysort female year: sum taxAfterAdjustments
bysort female year: sum taxBeforeAdjustments

desc taxableIncome taxBeforeAdjustments
summarize taxableIncome taxBeforeAdjustments

tabulate MTRcat year, summarize (taxAfterAdjustments)
tabulate MTRcat year, summarize (taxBeforeAdjustments)

**************** tax before and after Adjustments***************************
bysort year: sum taxAfterAdjustments taxBeforeAdjustments
sum taxAfterAdjustments taxBeforeAdjustments 
tab children alter_a alter_b , summarize (taxableIncome)

tabulate MTRcat year, summarize (taxableIncome)
tabulate MTRcat1 year, summarize (taxableIncome)
tabulate MTRcat1 year, summarize (taxAfterAdjustments)
tabulate MTRcat1 year, summarize (taxBeforeAdjustments)

tab addMTR if qaddMTR==

sum addMTR if qaddMTR==1
sum addMTR if qaddMTR==2
sum addMTR if qaddMTR==3
sum addMTR if qaddMTR==4
sum addMTR if qaddMTR==5

sum taxableIncome if qaddMTR==1
sum taxableIncome if qaddMTR==2
sum taxableIncome if qaddMTR==3
sum taxableIncome if qaddMTR==4
sum taxableIncome if qaddMTR==5 & year==2001


************* Quintile Marginal Tax Rate*************************
xtile qaddMTR = addMTR, n(5)

xtile qATR = ATR, n(5)

xtile ptileMTR= addMTR, nq(100)
xtile ptileMTR1= addMTR, nq(50)

egen obs=rank(addMTR), unique

*****************Creaet Post Period Varible*****************************

gen postperiod =1 if year ==2001
replace postperiod =0 if year==1998

************ experiments with Different treatments ***************
********/* I have used only quitle based on Marginal tax rate */**********

generate treatment=1 if taxableIncome >= 55000
replace treatment =0 if taxableIncome<55000

generate treatment1=0 if (taxableIncome >= 47432)
replace treatment1=1 if (taxableIncome<47432 & taxableIncome>=15799)
replace treatment1=2 if (taxableIncome>=1 & taxableIncome<15799)

generate treatment2=1 if (taxableIncome >= 47432)
replace treatment2=0 if (taxableIncome<47432)

generate treatment3=1 if qaddMTR == 5
replace treatment3 =0 if qaddMTR <5



************************DID regression********************************************
gen did5= qaddMTR*postperiod
bysort qaddMTR postperiod: sum taxableIncome
bysort qaddMTR postperiod: sum addMTR

bysort qaddMTR postperiod: sum taxableIncome if incomeSplitting==2
bysort qaddMTR postperiod: sum addMTR if incomeSplitting==2


*********** used in Paper**********
reg addMTR qaddMTR postperiod did5, r 
reg addMTR qaddMTR postperiod did5 if incomeSplitting==2

reg addMTR postperiod##qaddMTR, r
********** end***********************


gen did=treatment*postperiod
gen did4=treatment1*postperiod
gen did6=treatment1*postperiod

bysort treatment postperiod: sum addMTR 
bysort treatment postperiod: sum taxableIncome
bysort treatment1 postperiod: sum taxableIncome
bysort treatment2 postperiod: sum taxableIncome
bysort treatment3 postperiod: sum taxableIncome

reg addMTR postperiod##treatment1, r
reg addMTR postperiod##treatment3, r
reg addMTR postperiod##treatment1, r
reg addMTR postperiod##treatment2, r

reg addMTR qaddMTR postperiod did, r
reg addMTR treatment3 postperiod did, r
reg addMTR treatment1 postperiod did4, r
reg addMTR treatment2 postperiod did, r

 
******************tabulate*****************************************************
tabulate qaddMTR year, summarize (addMTR)
tabulate qaddMTR year, summarize (taxableIncome)

tabulate qaddMTR postperiod, summarize (taxableIncome)
tabulate qaddMTR year, summarize (obs1)

tabulate qaddMTR postperiod, sum (taxableIncome)

tabulate ptileMTR year, summarize (addMTR)
tabulate ptileMTR year, summarize (taxableIncome)

tabulate ptileMTR1 year, summarize (addMTR)
tabulate ptileMTR1 year, summarize (addMTR taxableIncome)


*********** Experimental Work**********************************************
gen did7=MTRcat4*postperiod

reg addMTR MTRcat4 postperiod did7, r
reg addMTR postperiod##MTRcat4, r
********** end***********************


****** experimetal differnt TAx credit random, not used this paper, **********
*****/*removed them from analysis */ *********************************
generate byte MTRcat=0 if addMTR==0
replace MTRcat=30 if addMTR>0 & addMTR<=30
replace MTRcat=34 if addMTR>30 & addMTR<=38
replace MTRcat=45 if addMTR>38 & addMTR <=45
replace MTRcat=53 if addMTR>45 & addMTR <=53

tabulate MTRcat year, summarize (addMTR)
tabulate MTRcat year, summarize (taxableIncome)

generate byte MTRcat1=0 if addMTR==0
replace MTRcat1=30 if addMTR>0 & addMTR<=30
replace MTRcat1=34 if addMTR>30 & addMTR<=38
replace MTRcat1=45 if addMTR>38 & addMTR <=53

generate byte MTRcat1=0 if addMTR==0
replace MTRcat1=30 if addMTR>0 & addMTR<=30
replace MTRcat1=34 if addMTR>30 & addMTR<=38
replace MTRcat1=45 if addMTR>38 & addMTR <=53

generate byte MTRcat3=0 if addMTR==0
replace MTRcat3=20 if addMTR>9 & addMTR<=20
replace MTRcat3=31 if addMTR>20 & addMTR<=31
replace MTRcat3=53 if addMTR>31 & addMTR <=53


generate byte MTRcat4=. 
replace MTRcat4=20 if addMTR>9 & addMTR<=20
replace MTRcat4=31 if addMTR>20 & addMTR<=31
replace MTRcat4=53 if addMTR>31 & addMTR <=53

tabulate MTRcat1 year, summarize (addMTR)
tabulate MTRcat1 year, summarize (taxableIncome)

bysort postperiod: sum addMTR if qaddMTR==5
by postperiod: sum addMTR if qaddMTR>=3 & qaddMTR<5

bysort postperiod: sum ATR if qATR==5
by postperiod: sum ATR if qATR>=3 & qATR<5


bysort postperiod: sum addMTR if qaddMTR==4
by postperiod: sum addMTR if qaddMTR>=4

bysort year: sum addMTR if qaddMTR==4
by year: sum addMTR if qaddMTR>=4
bysort qaddMTR postperiod: sum addMTR
bysort qaddMTR: sum addMTR taxableIncome

bysort MTRcat3 year: sum addMTR taxableIncome
bysort MTRcat4 year: sum addMTR taxableIncome
bysort qaddMTR year: sum addMTR taxableIncome






******************************** End **************************************************
***********************************************************************************
************************************************************************************

******* started Experiemntal Part****************************
*****************/* generate Averge Tax Rate */***********************************

gen ATR = (taxAfterAdjustments/taxableIncome)*100

egen Observations=rank(ATR), unique

egen obs1=rank (addMTR), unique

gen ATR98= (TaxLi98/v98)*100
gen ATR2001=(TaxLi2001/v2001)*100

****** tax credit 98************
generate byte ATRcat98=0 if ATR98==0
replace ATRcat98=25 if ATR98>0 & ATR98<=25.9
replace ATRcat98=34 if ATR98>25.9 & ATR98<=34.34
replace ATRcat98=34 if ATR98>34.34 & ATR98<=53
replace ATRcat98=53 if ATR98>53 & ATR98 <.

****** differnt TAx credit random 98************
generate byte ATRcat98N=0 if ATR98==0
replace ATRcat98N=34 if ATR98>30 & ATR98<=38
replace ATRcat98N=45 if ATR98>38 & ATR98 <=45
replace ATRcat98N=53 if ATR98>45 & ATR98 <53

preserve
collapse ATRcat98 v98 Observations, by (qATR98)
list


preserve
collapse ATRcat98 v98 Observations, by (ATRcat98N)
list

preserve
collapse ATR98 v98 Observations, by (ATRcat98N)
list


generate byte ATRcat2001=0 if ATR2001==0
replace ATRcat2001=25 if ATR2001>0 & ATR2001<=19.9
replace ATRcat2001=34 if ATR2001>19.9 & ATR2001<=23
replace ATRcat2001=34 if ATR2001>23 & ATR2001<=48.5
replace ATRcat2001=53 if ATR2001>48.5 & ATR2001 <. 



generate byte ATRcat2001N=0 if ATR2001==0
replace ATRcat2001N=34 if ATR2001>19.9 & ATR2001<=23
replace ATRcat2001N=45 if ATR2001>23 & ATR2001 <=34
replace ATRcat2001N=53 if ATR2001>34 & ATR2001 <48.5


generate byte ATRcat2001N1=0 if ATR2001==0
replace ATRcat2001N1=34 if ATR2001>30 & ATR2001<=38
replace ATRcat2001N1=45 if ATR2001>38 & ATR2001 <=45
replace ATRcat2001N1=53 if ATR2001>45 & ATR2001<53



preserve
collapse ATR2001 v2001 Observations, by (ATRcat2001N)
list


preserve
collapse ATR98 v98 Observations, by (qATR98 ATRcat98N)
list

preserve
collapse ATR2001 v2001 Observations, by (qATR2001 ATRcat2001N1)
list


preserve
collapse ATR taxableIncome Observations, by (qATR year)
list


xtile qATR1=ATR, n(10)



preserve
collapse ATR taxableIncome Observations, by (qATR1 year)
list


xtile qATR2=ATR, n(20)

preserve
collapse ATR taxableIncome Observations, by (qATR2 year)
list

................../* Quintile average Tax Rate */.........

drop if ATR==.
xtile qATR = ATR, n(5)
tab qATR
bysort qATR : gen w=1/_N
tabstat w, by(qATR) s (n sum)


tab qATR, sum(ATR)

xtile bin5=ATR, nq(5)
gen negATR=-ATR

xtile bin5_2=negATR, nq(5)

tab bin5

tab bin5_2

tab bin5, sum(ATR)


xtile qATR98=ATR98, n(5)
xtile qATR2001=ATR2001, n(5)



preserve
collapse ATR taxableIncome, by (year qATR)
list
************* Quintile Marginal Tax Rate************


xtile qaddMTR = addMTR, n(5)

................../* Percentile average Tax Rate */.........


xtile ptile = int(100*(_n-1)/_N)+1
replace ptile=ptile-1 if ATR==ATR(-1)

xtile ptile100= ATR, nq(100)
xtile ptile5= ATR, nq(5)

sort ATR
gen ptile1=int(100*(_n-1)/_N)+1
replace ptile1=ptile1(-1) if ATR==ATR(-1)


............/* net of tax rate */........

tab ATR98 v98 if ATR==25

............... /* DID regression New*/.........................................


gen postperiod =1 if year ==2001
replace postperiod =0 if year==1998

gen did=qATR*postperiod

reg ATR postperiod##qATR, r
reg ATR qATR postperiod did, r



........../* total extra code */......................................................


.............../* generate Marginal tax Rate */..............................................
generate income0=0
replace income0= taxableIncome if taxableIncome<9000
replace income0= 9000 if taxableIncome>=9000

generate income15=0
replace income15= (taxableIncome-9000) if (taxableIncome >9000 & taxableIncome  <54950)
replace income15= (54950-9000) if taxableIncome>54950

generate income43=0
replace income43= taxableIncome-54949 if (taxableIncome >54949 & taxableIncome  <260533)
replace income43= 205582 if taxableIncome >260533

generate income46=0
replace income46= taxableIncome-260532 if (taxableIncome >260532)


generate totaltax=income0*0+income15*.14+income43*.42+income46*.45


generate MTaxR= (totaltax/taxableIncome)*100

sort MTaxR


sort taxableIncome


.................. /* generate variable */.....................................
egen rank=rank(ATR), unique

egen group5=cut(rank), group (5)


............... /* DID regression */.........................................


gen postperiod =1 if year ==2001
replace postperiod =0 if year==1998

gen did=group5*postperiod
 
reg MTaxR postperiod##group5, r
reg MTaxR group5 postperiod did, r
 
reg MTaxR postperiod##MTRcat, r
reg MTaxR MTRcat postperiod did, r


generate treatment=1 if group5 >=4
replace treatment =0 if group5<=3 & group5<.

gen did1=treatment*postperiod
 
 
reg MTaxR postperiod##treatment, r
reg MTaxR group5 postperiod did1, r
 
 
 ............./*Collapse */...................................................
preserve
collapse MTaxR taxableIncome (count) rank, by (group5)
list 


preserve
collapse MTaxR taxableIncome (count) rank, by (year)
list 


preserve
collapse MTaxR taxableIncome (count) rank, by (year group5)
list 


preserve
collapse MTaxR taxBeforeAdjustments taxAfterAdjustments (count)rank, by (year group5)
list 

generate byte MTRcat=0 if MTaxR==0
replace MTRcat=14 if MTaxR>0 & MTaxR<=14
replace MTRcat=30 if MTaxR>14 & MTaxR<=30
replace MTRcat=42 if MTaxR>30 & MTaxR<=42
replace MTRcat=45 if MTaxR>42 & MTaxR<.

tabulate MTRcat, summarize (postperiod)

preserve
collapse MTRcat taxBeforeAdjustments taxAfterAdjustments (count)rank, by (year group5)
list 


preserve
collapse MTRcat taxableIncome (count) rank, by (year group5)
list 

preserve
collapse taxableIncome (count) rank, by (MTRcat year)
list 

preserve
collapse MTaxR taxableIncome (count) rank, by (MTRcat year)
list

generate byte MTRcat1=0 if MTaxR==0
replace MTRcat1=14 if MTaxR>0 & MTaxR<=14
replace MTRcat1=42 if MTaxR>14 & MTaxR<=42
replace MTRcat1=45 if MTaxR>42 & MTaxR<.

preserve
collapse taxBeforeAdjustments taxAfterAdjustments (count)rank, by (MTRcat1 year)
list 

......extra code start...................
generate income9000=0
replace income9000= taxableIncome if taxableIncome<9000

generate income14=0
replace income14= taxableIncome if (taxableIncome >9000 & taxableIncome  <54950)

generate income42=0
replace income42= taxableIncome if (taxableIncome >54949 & taxableIncome  <260533)

generate income45=0
replace income45= taxableIncome if (taxableIncome >260532)

drop income0to14

generate income0to14= income14-9000
replace income0to14 =0 if income0to14==-9000

generate income14to42= income14-9000
replace income0to14 =0 if income0to14==-9000

............extra code end..............................

 .........extra code start.........
gen id= _n

egen newid =group(id)

sort id
by id: gen neewid=1 if _n==1
replace newid=sum(newid)
replace newid=.if missing (id)

drop group2

egen group2= cut(MTaxR), group (5)
egen group4=cut(id), group (5)
...... extracode end.................................
....................extra code start...............
preserve

collapse MTaxR, by (group5)
collapse (mean) average= MTaxR, by (group5)

preserve
collapse MTaxR taxableIncome, by (year)
graph twoway (line MTaxR year),
ylevel (,angle (horizontal))
list 

preserve
collapse MTaxR taxableIncome, by (year)
list 

preserve
collapse MTaxR taxableIncome, by (group5)
list 
*****************************extra code*********************************
************* extra start****************************
gen inc1N=inc1 
replace inc1N=0 if inc1==.

gen inc2N=inc2
replace inc2N=0 if inc2==.

gen inc3N=inc3 
replace inc3N=0 if inc3==.

************* extra start****************************
gen inc1N=inc1 
replace inc1N=0 if inc1==.

gen inc2N=inc2
replace inc2N=0 if inc2==.

gen inc3N=inc3 
replace inc3N=0 if inc3==.

generate taxliabi98= income12DM*0+ (91.19*income58DM+2590)*income58DM+(151.96*income120DM+3434)*income120DM+13938+(0.53*income120above-19299)

generate taxlibility98one= income12DM*0
 
generate taxlibility98two=(91.19*income58DM+2590)*income58DM

generate taxlibility98three= (151.96*income120DM+3434)*income120DM+13938

generate taxlibility98four= (0.53*income120above-19299)

generate taxLIBILITY98= (taxlibility98one+taxlibility98two*income58DM+ taxlibility98three*income120DM+taxlibility98four*income120above)

generate income1= (v98-12312)/10000
generate income2= (v98-58590)/10000

generate taxli98= income12DM*0+ (91.19*income1+2590)*income1+(151.96*income2+3434)*income2+13938+(0.53*v98-19299)

*******************************************************************************************
********************************************************************************************
**************************************************************************************************



 ****** tax credit 98************
generate byte ATRcat98=0 if ATR98==0
replace ATRcat98=25 if ATR98>0 & ATR98<=25.9
replace ATRcat98=34 if ATR98>25.9 & ATR98<=34.34
replace ATRcat98=34 if ATR98>34.34 & ATR98<=53
replace ATRcat98=53 if ATR98>53 & ATR98 <.

****** differnt TAx credit random 98************
generate byte ATRcat98N=0 if ATR98==0
replace ATRcat98N=34 if ATR98>30 & ATR98<=38
replace ATRcat98N=45 if ATR98>38 & ATR98 <=45
replace ATRcat98N=53 if ATR98>45 & ATR98 <53


preserve
collapse ATRcat98 v98 Observations, by (qATR98)
list


preserve
collapse ATRcat98 v98 Observations, by (ATRcat98N)
list

preserve
collapse ATR98 v98 Observations, by (ATRcat98N)
list


generate byte ATRcat2001=0 if ATR2001==0
replace ATRcat2001=25 if ATR2001>0 & ATR2001<=19.9
replace ATRcat2001=34 if ATR2001>19.9 & ATR2001<=23
replace ATRcat2001=34 if ATR2001>23 & ATR2001<=48.5
replace ATRcat2001=53 if ATR2001>48.5 & ATR2001 <. 



generate byte ATRcat2001N=0 if ATR2001==0
replace ATRcat2001N=34 if ATR2001>19.9 & ATR2001<=23
replace ATRcat2001N=45 if ATR2001>23 & ATR2001 <=34
replace ATRcat2001N=53 if ATR2001>34 & ATR2001 <48.5


generate byte ATRcat2001N1=0 if ATR2001==0
replace ATRcat2001N1=34 if ATR2001>30 & ATR2001<=38
replace ATRcat2001N1=45 if ATR2001>38 & ATR2001 <=45
replace ATRcat2001N1=53 if ATR2001>45 & ATR2001<53



preserve
collapse ATR2001 v2001 Observations, by (ATRcat2001N)
list


preserve
collapse ATR98 v98 Observations, by (qATR98 ATRcat98N)
list

preserve
collapse ATR2001 v2001 Observations, by (qATR2001 ATRcat2001N1)
list


preserve
collapse ATR taxableIncome Observations, by (qATR year)
list


xtile qATR1=ATR, n(10)



preserve
collapse ATR taxableIncome Observations, by (qATR1 year)
list


xtile qATR2=ATR, n(20)

preserve
collapse ATR taxableIncome Observations, by (qATR2 year)
list


........../* generate Averge Tax Rate */...............

gen ATR = (taxAfterAdjustments/taxableIncome)*100

egen Observations=rank(ATR), unique



gen ATR98= (TaxLi98/v98)*100

gen ATR2001=(TaxLi2001/v2001)*100


*******************************for average Tax Rate*****************
tab qATR
bysort qATR year: sum taxableIncome
bysort qATR year: sum ATR


**************** extra Code************************************
sum taxBeforeAdjustments if (year==1998) & (taxableIncome>=0 & taxableIncome<=12365)
sum taxBeforeAdjustments if (year==1998) & (taxableIncome>12365 & taxableIncome<=58643)
sum taxBeforeAdjustments if (year==1998) & (taxableIncome>58643 & taxableIncome<=120041)
sum taxBeforeAdjustments if (year==1998) & (taxableIncome>120041)

sum taxBeforeAdjustments if (year==2001) & (taxableIncome>=0 & taxableIncome<=12365)
sum taxBeforeAdjustments if (year==2001) & (taxableIncome>12365& taxableIncome<=58643)
sum taxBeforeAdjustments if (year==2001) & (taxableIncome>58643 & taxableIncome<=120041)
sum taxBeforeAdjustments if (year==2001) & (taxableIncome>120041)


sum taxAfterAdjustments if (year==1998) & (taxableIncome<=14093)
sum taxAfterAdjustments if (year==1998) & (taxableIncome>14093 & taxableIncome<=18089)
sum taxAfterAdjustments if (year==1998) & (taxableIncome>18089 & taxableIncome<=107567)
sum taxAfterAdjustments if (year==1998) & (taxableIncome>107567)

sum taxAfterAdjustments if (year==2001) & (taxableIncome<=14093)
sum taxAfterAdjustments if (year==2001) & (taxableIncome>14093 & taxableIncome<=18089)
sum taxAfterAdjustments if (year==2001) & (taxableIncome>18089 & taxableIncome<=107567)
sum taxAfterAdjustments if (year==2001) & (taxableIncome>107567)************** extra****************





********************** End *****************************************************
*********************************************************************************
********************************************************************************















