
use "\\files\users\mdniazc\Desktop\758 term paper\addMTR.dta" 

*****************************************************Term paper***************************************************
*******************************************************************************************************************
********************************************************************************************************************



************* Quintile Marginal Tax Rate************

egen obs1=rank (addMTR), unique
xtile qaddMTR = addMTR, n(5)


gen postperiod =1 if year ==2001
replace postperiod =0 if year==1998


generate treatment=1 if taxableIncome >= 55000
replace treatment =0 if taxableIncome<55000


************************DID regression********************************************

gen did=treatment*postperiod
 

bysort treatment postperiod: sum taxableIncome

bysort treatment postperiod: sum addMTR

reg addMTR postperiod##treatment, r

reg addMTR treatment postperiod did, r

 
 ******************Collapse*****************************************************
 
preserve
collapse addMTR taxableIncome obs1, by (year qaddMTR)
list


 
 

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



