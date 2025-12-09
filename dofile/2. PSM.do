
use ..\data\hh_98
gen lexptot=ln(1+exptot)
gen lnland=ln(1+hhland/100)

****Impacts of program participation;

***Female participants; 
****pscore equation;
pscore dfmfd sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg [pw=weight], pscore(ps98) blockid(blockf1) comsup level(0.001)

****Nearest Neighbor Matching;
attnd lexptot dfmfd [pweight=weight], pscore(ps98) comsup

****Stratification Matching;
atts lexptot dfmfd, pscore(ps98) blockid(blockf1) comsup

****Radius Matching;
attr lexptot dfmfd, pscore(ps98) radius(0.001) comsup

****Kernel Matching;
attk lexptot dfmfd, pscore(ps98) comsup bootstrap reps(50)

****Direct Matching using Nearest neighbor;
nnmatch lexptot dfmfd sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg [pw=weight], tc(att) m(1)