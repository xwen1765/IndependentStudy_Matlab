


CorrectV = numberCorrectV;
CorrectI = numberCorrectI;
CorrectN = numberCorrectN;

invalid_ac = accuracyI;
valid_ac = accuracyV;
neutral_ac = accuracyN;

Vn = totalN;
Vi = totalI;
Vv = totalV;

% ph_vn = (CorrectV + CorrectN)/(Vv+Vn);
% ph_in = (CorrectI + CorrectN)/(Vi+Vn);
% ph_vi = (CorrectV + CorrectI)/(Vv+Vi);

ph_vv = (lvc + rvc)/(totalV);
ph_ii = (lic + ric)/(totalI);
ph_nn = (lnc + rnc)/(totalN);

ph_lv = lvc/lvt;
ph_rv = rvc/rvt;
ph_ln = lnc/lnt;
ph_rn = rnc/rnt;
ph_li = lic/lit;
ph_ri = ric/rit;



d_vv = [1.96*sqrt(ph_lv*(1-ph_lv)*(1/lvc+1/rvc)),1.96* sqrt(ph_in*(1-ph_in)*(1/Vi+1/Vn))];


% Z_vn = (valid_ac-neutral_ac)/sqrt(ph_vn*(1-ph_vn)*(1/Vv+1/Vn))
% Z_in = (invalid_ac-neutral_ac)/sqrt(ph_in*(1-ph_in)*(1/Vi+1/Vn))
% Z_vi = (valid_ac-invalid_ac)/sqrt(ph_vi*(1-ph_vi)*(1/Vv+1/Vi))

Z_vv = (accrv-acclv)/sqrt(ph_vv*(1-ph_vv)*(1/lvt+1/rvt));
Z_ii = (accri-accli)/sqrt(ph_ii*(1-ph_ii)*(1/lit+1/rit));
Z_nn = (accrn-accln)/sqrt(ph_nn*(1-ph_nn)*(1/lnt+1/rnt));


%*x = table([3;1],[6;7],'VariableNames',{'Flu','NoFlu'},'RowNames',{'NoShot','Shot'})*%
%[h,p,stats] = fishertest(x)
pvalueVV = 1 - normcdf(Z_vv)
pvalueII = 1 - normcdf(abs(Z_ii))
pvalueNN = 1 - normcdf(Z_nn)
