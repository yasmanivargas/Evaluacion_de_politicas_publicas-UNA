
****IV using ivreg implementation;
use ..\data\hh_98,clear;

gen lexptot=ln(1+exptot)
gen lnland=ln(1+hhland/100)
gen vill=thanaid*10+villid

egen villfmf=max(dfmfd), by(vill)
gen fchoice=villfmf==1 & hhland<50
for var agehead-educhead lnland vaccess pcirr rice-oil: gen fchX=fchoice*X

****Female participation;
ivreg lexptot agehead-educhead lnland vaccess pcirr rice-oil (dfmfd= agehead-educhead      lnland vaccess pcirr rice-oil fch*), first
****Test for endogeneity;
ivendog

****IV using treatreg implementation;
treatreg lexptot agehead-educhead lnland vaccess pcirr rice-oil, treat (dfmfd= agehead-educhead lnland vaccess pcirr rice-oil fch*)

****IV with FE implementation in cross-sectional data;
use ..\data\hh_98,clear;

gen lexptot=ln(1+exptot)
gen lnland=ln(1+hhland/100)
gen vill=thanaid*10+villid

egen villfmf=max(dfmfd), by(vill year)
gen fchoice=villfmf==1 & hhland<50
for var agehead-educhead lnland vaccess pcirr rice-oil: gen fchX=fchoice*X

xtivreg lexptot year agehead-educhead lnland vaccess pcirr rice-oil (dfmfd= agehead-educhead lnland vaccess pcirr rice-oil fch*), fe i(vill)
****Test for endogeneity;
dmexogxt

****IV with FE implementation in panel data;
use ..\data\hh_9198,clear;

gen lexptot=ln(1+exptot)
gen lnland=ln(1+hhland/100)
gen vill=thanaid*10+villid

egen villfmf=max(dfmfd), by(vill year)
gen fchoice=villfmf==1 & hhland<50
for var agehead-educhead lnland vaccess pcirr rice-oil: gen fchX=fchoice*X

xtivreg lexptot year agehead-educhead lnland vaccess pcirr rice-oil (dfmfd= agehead-educhead lnland vaccess pcirr rice-oil fch*), fe i(nh)
****Test for endogeneity;
dmexogxt