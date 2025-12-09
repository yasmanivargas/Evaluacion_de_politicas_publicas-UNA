
****DD IMPLEMENTATION;

***Simplest implementation;
use ..\data\hh_9198;

gen exptot0=exptot if year==0
egen exptot91=max(exptot0), by(nh)
keep if year==1
gen lexptot91=ln(1+exptot91) if year==1
gen lexptot98=ln(1+exptot) if year==1
gen lexptot9891=lexptot98-lexptot91

ttest lexptot9891 if year==1, by(dfmfd)

clear

***Regression implementation;
use ..\data\hh_9198,clear;

gen lexptot=ln(1+exptot)
gen lnland=ln(1+hhland/100)
gen dfmfd1=dfmfd==1 & year==1
egen dfmfd98=max(dfmfd1), by(nh)
gen dfmfdyr=dfmfd98*year

***Basic model;
reg lexptot year dfmfd98 dfmfdyr

****Full model;
reg lexptot year dfmfd98 dfmfdyr sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg [pw=weight]

****Fixed effects: Basic;
xtreg lexptot year dfmfd98 dfmfdyr, fe i(nh)

****Fixed effects: Full Model;
xtreg lexptot year dfmfd98 dfmfdyr sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg, fe i(nh)

clear

***DD in cross-sectional data;
use ..\data\hh_91,clear

gen vill=thanaid*10+villid
gen lexptot=ln(1+exptot)
gen lnland=ln(1+hhland/100)
gen target=hhland<50
gen progvill=thanaid<25

gen progtarget=progvill*target

sum target if progvill==1

reg lexptot progvill target progtarget
reg lexptot progvill target progtarget sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg [pw=weight]
xtreg lexptot progvill target progtarget, fe i(vill)
xtreg lexptot progvill target progtarget sexhead agehead educhead lnland, fe i(vill)

****Taking into account initial conditions;
use ..\data\hh_9198,clear;

gen lexptot=ln(1+exptot)
gen lnland=ln(1+hhland/100)
gen dfmfd1=dfmfd==1 & year==1
egen dfmfd98=max(dfmfd1), by(nh)
gen dfmfdyr=dfmfd98*year
drop dfmfd1

sort nh year
by nh: gen dlexptot=lexptot[2]-lexptot[1]
by nh: gen ddfmfd98= dfmfd98[2]- dfmfd98[1]
by nh: gen ddfmfdyr= dfmfdyr[2]- dfmfdyr[1]
by nh: gen dsexhead= sexhead[2]- sexhead[1]
by nh: gen dagehead= agehead[2]- agehead[1]
by nh: gen deduchead= educhead[2]- educhead[1]
by nh: gen dlnland= lnland[2]- lnland[1]
by nh: gen dvaccess= vaccess[2]- vaccess[1]
by nh: gen dpcirr= pcirr[2]- pcirr[1]
by nh: gen drice= rice[2]- rice[1]
by nh: gen dwheat= wheat[2]- wheat[1]
by nh: gen dmilk= milk[2]- milk[1]
by nh: gen doil= oil[2]- oil[1]
by nh: gen degg= egg[2]- egg[1]

reg dlexptot ddfmfd98 ddfmfdyr dsexhead dagehead deduchead dlnland dvaccess dpcirr drice dwheat dmilk doil degg sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg if year==0 [pw=weight]