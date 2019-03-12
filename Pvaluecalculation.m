
CorrectV = numberCorrectV;
CorrectI = numberCorrectI;
CorrectN = numberCorrectN;

invalid_ac = accuracyI;
valid_ac = accuracyV;
neutral_ac = accuracyN;

Vn = totalN;
Vi = totalI;
Vv = totalV;
   

% CorrectV = lvc;
% CorrectI = lic;
% CorrectN = lnc;
% 
% valid_ac = acclv;
% invalid_ac = accli;
% neutral_ac = accln;
% 
% Vn = lnt;
% Vi = lit;
% Vv = lvt;


% CorrectV = rvc;
% CorrectI = ric;
% CorrectN = rnc;
% 
% varid_ac = accrv;
% invarid_ac = accri;
% neutral_ac = accrn;
% 
% Vn = rnt;
% Vi = rit;
% Vv = rvt;


ph_vn = (CorrectV + CorrectN)/(Vv+Vn);
ph_in = (CorrectI + CorrectN)/(Vi+Vn);
ph_vi = (CorrectV + CorrectI)/(Vv+Vi);

Z_vn = (valid_ac-neutral_ac)/sqrt(ph_vn*(1-ph_vn)*(1/Vv+1/Vn))
Z_in = (invalid_ac-neutral_ac)/sqrt(ph_in*(1-ph_in)*(1/Vi+1/Vn))
Z_vi = (valid_ac-invalid_ac)/sqrt(ph_vi*(1-ph_vi)*(1/Vv+1/Vi))

pvalueVI = 1 - normcdf(abs(Z_vi))
pvalueIN = 1 - normcdf(abs(Z_in))
pvalueVN = 1 - normcdf(abs(Z_vn))
