
use ..\data\hh_98;

gen lexptot=ln(1+exptot)
gen lnland=ln(1+hhland/100)
gen vill=thanaid*10+villid
egen progvillf=max(dfmfd), by(vill)

***Impacts of program placement;  
****t-test;
ttest lexptot, by(progvillf)

****Regression implementation;
reg lexptot progvillf

****Expanded regression
reg lexptot progvillf sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg [pw=weight]

***Impacts of program participation;  
****t-test;
ttest lexptot, by(dfmfd)

****Regression implementation;
reg lexptot dfmfd

****Expanded regression;
reg lexptot dfmfd sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg [pw=weight]

****Expanded regression: capturing both program placement and participation; 
reg lexptot dfmfd progvillf sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg [pw=weight]

***Impacts of program participation in program villages;
reg lexptot dfmfd if progvillf==1 [pw=weight]
reg lexptot dfmfd sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg if progvillf==1 [pw=weight]

***Spliiover effects of program placement;
reg lexptot progvillf if dfmfd==0 [pw=weight]
reg lexptot progvillf sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg if dfmfd==0 [pw=weight]