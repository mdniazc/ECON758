***REPLACE MISSING VALUES***
sum
replace sex =. if sex == 9
replace race =. if race == 9
replace yob =. if yob == 9999
replace schidk =. if schidk == 999
replace schid1 =. if schid1 == 999
replace schid2 =. if schid2 == 999
replace schid3 =. if schid3 == 999
replace sesk =. if sesk == 9
replace ses1 =. if ses1 == 9
replace ses2 =. if ses2 == 9
replace ses3 =. if ses3 == 9

***GENERATE DUMMIES***
***i. freelunch***
gen freelunchk=.
replace freelunchk = 1 if sesk == 1
replace freelunchk = 0 if sesk == 2
label variable freelunchk "receives free lunch = 1"

gen freelunch1=.
replace freelunch1 = 1 if ses1 == 1
replace freelunch1 = 0 if ses1 == 2
label variable freelunch1 "receives free lunch = 1"

gen freelunch2=.
replace freelunch2 = 1 if ses2 == 1
replace freelunch2 = 0 if ses2 == 2
label variable freelunch2 "receives free lunch = 1"

gen freelunch3=.
replace freelunch3 = 1 if ses3 == 1
replace freelunch3 = 0 if ses3 == 2
label variable freelunch3 "receives free lunch = 1"

***ii. attrition***
***Attrition rate is the fraction that ever exits the sample prior***
***to completing third grade. even if they return to the sample in***
***a subsequent year. Attrition rate is unavailable in third grade***
gen attritionk = .
replace attritionk = 0 if enterk == 1 & star1 == 1 & star2 == 1 & star3 == 1
replace attritionk = 1 if enterk == 1 & star1 == 1 & star2 == 1 & star3 == 2
replace attritionk = 1 if enterk == 1 & star1 == 1 & star2 == 2 & star3 == 2
replace attritionk = 1 if enterk == 1 & star1 == 2 & star2 == 2 & star3 == 2
replace attritionk = 1 if enterk == 1 & star1 == 2 & star2 == 1 & star3 == 2
label variable attritionk "enter K, exits sample before 3"

gen attrition1 = .
replace attrition1 = 0 if enter1 == 1 & star2 == 1 & star3 == 1
replace attrition1 = 1 if enter1 == 1 & star2 == 1 & star3 == 2
replace attrition1 = 1 if enter1 == 1 & star2 == 2 & star3 == 2
label variable attrition1 "enter 1, exits sample before 3"

gen attrition2 = .
replace attrition2 = 0 if enter2 == 1 & star3 == 1
replace attrition2 = 1 if enter2 == 1 & star3 == 2
label variable attrition2 "enter 2, exits sample before 3"

***iii. class size***
***small***
gen smallk = .
replace smallk = 1 if ctypek == 1
replace smallk = 0 if ctypek == 2 | ctypek == 3
label variable smallk "small class in K = 1"

gen small1 = .
replace small1 = 1 if ctype1 == 1
replace small1 = 0 if ctype1 == 2 | ctype1 == 3
label variable small1 "small class in 1 = 1"

gen small2 = .
replace small2 = 1 if ctype2 == 1
replace small2 = 0 if ctype2 == 2 | ctype2 == 3
label variable small2 "small class in 2 = 1"

gen small3 = .
replace small3 = 1 if ctype3 == 1
replace small3 = 0 if ctype3 == 2 | ctype3 == 3
label variable small3 "small class in 3 = 1"

***regular***
gen regulark = .
replace regulark = 1 if ctypek == 2
replace regulark = 0 if ctypek == 1 | ctypek == 3
label variable regulark "regular class in K = 1"

gen regular1 = .
replace regular1 = 1 if ctype1 == 2
replace regular1 = 0 if ctype1 == 1 | ctype1 == 3
label variable regular1 "regular class in 1 = 1"

gen regular2 = .
replace regular2 = 1 if ctype2 == 2
replace regular2 = 0 if ctype2 == 1 | ctype2 == 3
label variable regular2 "regular class in 2 = 1"

gen regular3 = .
replace regular3 = 1 if ctype3 == 2
replace regular3 = 0 if ctype3 == 1 | ctype3 == 3
label variable regular3 "regular class in 3 = 1"

***regular with aide***
gen regular_aidek = .
replace regular_aidek = 1 if ctypek == 3
replace regular_aidek = 0 if ctypek == 1 | ctypek == 2
label variable regular_aidek "regular with aide in K = 1"

gen regular_aide1 = .
replace regular_aide1 = 1 if ctype1 == 3
replace regular_aide1 = 0 if ctype1 == 1 | ctype1 == 2
label variable regular_aide1 "regular with aide in 1 = 1"

gen regular_aide2 = .
replace regular_aide2 = 1 if ctype2 == 3
replace regular_aide2 = 0 if ctype2 == 1 | ctype2 == 2
label variable regular_aide2 "regular with aide in 2 = 1"

gen regular_aide3 = .
replace regular_aide3 = 1 if ctype3 == 3
replace regular_aide3 = 0 if ctype3 == 1 | ctype3 == 2
label variable regular_aide3 "regular with aide in 3 = 1"

***iv. students who entered the STAR program***
gen enterk = 0
replace enterk = 1 if stark == 1
label variable enterk "entered STAR in K == 1"

gen enter1 = 0
replace enter1 = 1 if star1 == 1 & stark == 2
label variable enter1 "entered STAR in 1 == 1"

gen enter2 = 0
replace enter2 = 1 if star2 == 1 & stark == 2 & star1 == 2
label variable enter2 "entered STAR in 2 == 1"

gen enter3 = 0
replace enter3 = 1 if star3 == 1 & star2 == 2 & stark == 2 & star1 == 2
label variable enter3 "entered STAR in 3 == 1"

***v. white/Asian***
gen whiteasian=.
replace whiteasian = 1 if race == 1 | race == 3
replace whiteasian = 0 if race == 2 | race == 4 | race == 5 | race == 6
label variable whiteasian "white/asian = 1"

***vi. girls***
gen girl =.
replace girl = 1 if sex == 2
replace girl = 0 if sex == 1
label variable girl "girl == 1"

***age variable***
gen age=.
replace age = 1985-yob
label variable age "age as of December 31, 1985"

**************************************************
**************************************************

***
gen testk = .
replace testk = mathk_p if readk_p == .
replace testk = readk_p if mathk_p == .
replace testk = (mathk_p+readk_p)/2 if testk == .

gen test1 = .
replace test1 = math1_p if read1_p == .
replace test1 = read1_p if math1_p == .
replace test1 = (math1_p+read1_p)/2 if test1 == .

gen test2 = .
replace test2 = math2_p if read2_p == .
replace test2 = read2_p if math2_p == .
replace test2 = (math2_p+read2_p)/2 if test2 == .

gen test3 = .
replace test3 = math3_p if read3_p == .
replace test3 = read3_p if math3_p == .
replace test3 = (math3_p+read3_p)/2 if test3 == .



gen ctype_assigned = .
replace ctype_assigned = 1 if enterk == 1 & ctypek == 1
replace ctype_assigned = 2 if enterk == 1 & ctypek == 2
replace ctype_assigned = 3 if enterk == 1 & ctypek == 3
replace ctype_assigned = 1 if enter1 == 1 & ctype1 == 1
replace ctype_assigned = 2 if enter1 == 1 & ctype1 == 2
replace ctype_assigned = 3 if enter1 == 1 & ctype1 == 3
replace ctype_assigned = 1 if enter2 == 1 & ctype2 == 1
replace ctype_assigned = 2 if enter2 == 1 & ctype2 == 2
replace ctype_assigned = 3 if enter2 == 1 & ctype2 == 3
replace ctype_assigned = 1 if enter3 == 1 & ctype3 == 1
replace ctype_assigned = 2 if enter3 == 1 & ctype3 == 2
replace ctype_assigned = 3 if enter3 == 1 & ctype3 == 3
label variable ctype_assigned "initial class assignment"
