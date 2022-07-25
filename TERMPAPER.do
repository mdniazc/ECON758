version 13
clear all
*use "C:\Users\simon.maina\Desktop\term paper econometrics\consump1.dta"
use "C:\Users\Nk\Desktop\term paper econometrics\consump1.dta"
*log using "C:\Users\simon.maina\Desktop\term paper econometrics\consump1.dta"
 gen lagy1=y[_n-1]
*for income
gen chy=(y-y[_n-1])/lagy1
*lagged changed in income
gen chyb1=chy[_n-1]
gen chyb2=chy[_n-2]
gen chyb3=chy[_n-3]
gen chyb4=chy[_n-4]
gen chyb5=chy[_n-5]
gen chyb6=chy[_n-6]
*consumption
gen lagc1=c[_n-1]
gen chc=(c-c[_n-1])/lagy1
*lagged change in consumption
gen chcb1=chc[_n-1]
gen chcb2=chc[_n-2]
gen chcb3=chc[_n-3]
gen chcb4=chc[_n-4]
gen chcb5=chc[_n-5]
gen chcb6=chc[_n-6]
*interest rates
gen lagi1=i[_n-1]
gen chi=i-lagi1
*laged change in interst rates
gen chib1=chi[_n-1]
gen chib2=chi[_n-2]
gen chib3=chi[_n-3]
gen chib4=chi[_n-4]
gen chib5=chi[_n-5]
gen chib6=chi[_n-6]
*savings
gen s=y-c

*OLS 
regress chc chyb2 chyb3 chyb4
reg chc chyb2 chyb3 chyb4 chyb5 chyb6
reg chc chcb2 chcb3 chcb4
reg chc chcb2 chcb3 chcb4 chcb4 chcb6 
reg chc chib2 chib3 chib4
reg chc chib2 chib3 chib4 chib5 chib6 
reg chc chyb2 chyb3 chyb4 chcb2 chcb3 chcb4 
reg chc chyb2 chyb3 chyb4 chcb2 chcb3 chcb4 chib2 chib3 chib4 

*ols of change in income on the instruments
reg chy chyb2 chyb3 chyb4
reg chy chyb2 chyb3 chyb4 chyb5 chyb6
reg chy chcb2 chcb3 chcb4
reg chy chcb2 chcb3 chcb4 chcb5 chcb6
reg chy chib2 chib3 chib4
reg chy chib2 chib3 chib4 chib5 chib6
reg chy chyb2 chyb3 chyb4 chcb2 chcb3 chcb4 s
reg chy chyb2 chyb3 chyb4 chcb2 chcb3 chcb4 chib2 chib3 chib4 s

*IV REGRESS

ivregress 2sls chc (chy=chyb2 chyb3 chyb4)
ivregress 2sls chc (chy=chyb2 chyb3 chyb4 chyb5 chyb6)
ivregress 2sls chc (chy=chcb2 chcb3 chcb4)
ivregress 2sls chc (chy=chcb2 chcb3 chcb4 chcb5 chcb6)
ivregress 2sls chc (chy=chib2 chib3 chib4)
ivregress 2sls chc (chy=chib2 chib3 chib4 chib5 chib6)
ivregress 2sls chc (chy=chyb2 chyb3 chyb4 chcb2 chcb3 chcb4 )
ivregress 2sls chc (chy=chyb2 chyb3 chyb4 chcb2 chcb3 chcb4 chib2 chib3 chib4)

*log close 



