use "\\files\users\apalustre\Desktop\ps1_newdummy.dta" 

use "\\files\users\mdniazc\Desktop\758 term paper\ps1 (2).dta"


***DESCRIPTIVE STATISTICS***
sum nonwhite age ed work earn if children == 0
sum nonwhite age ed work earn if children >= 1
sum nonwhite age ed work earn if children == 1
sum nonwhite age ed work earn if children >= 2

***GENERATE DUMMIES***
gen child = 1 if children >= 1
replace child = 0 if children == 0

gen post1993 = 1 if year >= 1994
replace post1993 = 0 if year <= 1993

gen did=child*post1993

***parts a-c***
bysort year child: egen workmean=mean(work)

twoway (line workmean year if child == 1) (line workmean year if child == 0)
gen work1991 = 1 if workmean | year == 1991
replace work1991 = 0 if year >= 1992
gen test = .5122606
twoway (line workmean year if child == 1) (line workmean year if child == 0) (line test year)

******R code used to generate figure 2*****
//ps1 <- read_dta("//files/users/apalustre/Desktop/ps1.dta")
//View(ps1)
//hw1 = ps1
//year<-c(1991,1992,1993,1994,1995,1996)
//meanchild<-c(0.46,0.44,0.44,0.46,0.51,0.50)
//meannochild<-c(0.58,0.57,0.57,0.59,0.57,0.55)
//mean1 <- meanchild/min(meanchild[1])
//mean2<-meannochild/meannochild[1]
//plot(Year, mean2, xlim=c(1991, 1996), ylim=c(0, 1.5), type="b",
//             main="Annual Mean Labor Market Participation Rates", pch=19,
//             col="red", xlab="Tax Year", ylab="Annual mean labor participation rate")
//lines(Year, mean1, pch=5, col="blue", type="b", lty=2)
//legend(1991, 1.5, legend=c("Single women without children", "Single women with children"),
//                col=c("red", "blue"), lty=1:2, cex=0.7)
******

***parts d-h***
reg work child post1993 did, r
reg work child##post1993, r

sum work if children == 1 | post1993 == 1
sum work if children == 1 | post1993 == 0
gen child1 = 1 if children == 1
replace child1 = 0 if children == 0
gen did1=child1*post1993
reg work child1 post1993 did1, r

sum work if children >= 2 | post1993 == 1
sum work if children >= 2 | post1993 == 0
gen child2 = 1 if children >= 2
replace child2 = 0 if children == 0
gen did2=child2*post1993
reg work child2 post1993 did2, r

reg work child post1993 did, r
reg work urate child post1993 did, r
reg work nonwhite child post1993 did, r
reg work age child post1993 did, r
reg work ed child post1993 did, r
reg work urate nonwhite age ed child post1993 did, r

gen placeboyear = 1 if year == 1992 | year == 1993
replace placeboyear = 0 if year == 1991
gen postplacebo = child*placeboyear
reg work urate nonwhite age ed child placeboyear postplacebo, r
