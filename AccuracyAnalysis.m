
totalV = 0;
totalI = 0;
totalN = 0;
total = 0;
numberCorrectV = 0;
numberCorrectI = 0;
numberCorrectN = 0;
numberCorrect = 0;
accuracyV = [];
accuracy = [];
trials = [];
trialsV = [];

studentTdistV = 0;
studentTdistN = 0;
studentTdistI = 0;

hisV = [];
hisI = [];
hisN = [];
his = [];


exclude = [];
notrack = 0;
for k = 1 : length(pptrials)
    if(~isempty(pptrials{1,k}.notracks.start)||pptrials{1,k}.AnswerDirection ~= -1)
        notrack = notrack+1;
        
        for l = 1 :length(pptrials{1,k}.notracks.start)
            
            if((pptrials{1,k}.notracks.start(l) < 505 && (pptrials{1,k}.notracks.start(l) + ...
                    pptrials{1,k}.notracks.duration(l)) > 505) ||  (pptrials{1,k}.notracks.start(l) > 505 ...
                    && pptrials{1,k}.notracks.start(l) < 805 )||pptrials{1,k}.AnswerDirection ~= -1)
                exclude = [exclude, k]; %#ok<*AGROW>
            end
            
            
            if(( (pptrials{1,k}.notracks.start(l) < 1105 && pptrials{1,k}.notracks.start(l) > 805) && (pptrials{1,k}.notracks.start(l) + ...
                    pptrials{1,k}.notracks.duration(l)) > 1105) ||  (pptrials{1,k}.notracks.start(l) > 1105 ...
                    && pptrials{1,k}.notracks.start(l) < 1141 )||pptrials{1,k}.AnswerDirection ~= -1)
                exclude = [exclude, k];
            end
            
            if(( (pptrials{1,k}.notracks.start(l) < 1285 && pptrials{1,k}.notracks.start(l) > 1141) && (pptrials{1,k}.notracks.start(l) + ...
                    pptrials{1,k}.notracks.duration(l)) > 1285) ||  (pptrials{1,k}.notracks.start(l) > 1285 ...
                    && pptrials{1,k}.notracks.start(l) < 1680 )|| pptrials{1,k}.AnswerDirection ~= -1)
                exclude = [exclude, k];
            end
            
        end
        
    end
    
    
    if(~isempty(pptrials{1,k}.saccades.start))
        for l = 1 :length(pptrials{1,k}.saccades.start)
            
            if((pptrials{1,k}.saccades.start(l) < 505 && (pptrials{1,k}.saccades.start(l) + ...
                    pptrials{1,k}.saccades.duration(l)) > 505) ||  (pptrials{1,k}.saccades.start(l) > 505 ...
                    && pptrials{1,k}.saccades.start(l) < 805 )||pptrials{1,k}.AnswerDirection ~= -1)
                exclude = [exclude, k]; %#ok<*AGROW>
            end
            
            
            if(( (pptrials{1,k}.saccades.start(l) < 1105 && pptrials{1,k}.saccades.start(l) > 805) && (pptrials{1,k}.saccades.start(l) + ...
                    pptrials{1,k}.saccades.duration(l)) > 1105) ||  (pptrials{1,k}.saccades.start(l) > 1105 ...
                    && pptrials{1,k}.saccades.start(l) < 1141 )||pptrials{1,k}.AnswerDirection ~= -1)
                exclude = [exclude, k];
            end
            
            if(( (pptrials{1,k}.saccades.start(l) < 1285 && pptrials{1,k}.saccades.start(l) > 1141) && (pptrials{1,k}.saccades.start(l) + ...
                    pptrials{1,k}.saccades.duration(l)) > 1285) ||  (pptrials{1,k}.saccades.start(l) > 1285 ...
                    && pptrials{1,k}.saccades.start(l) < 1680 )|| pptrials{1,k}.AnswerDirection ~= -1)
                exclude = [exclude, k];
            end
            
        end
        
    end
    
    
end

exclude = unique(exclude);
disp(exclude)
alltrials = pptrials;
for k = 1 : length(exclude)
    alltrials{exclude(k)} = [];
end
alltrials(cellfun('isempty', alltrials)) = [];
% Exclude inaccurate trials

for k = 1 : length(alltrials)
    total = total+1;
    if(alltrials{1,k}.Correctness == 1 )
        numberCorrect = numberCorrect + 1;
    end
    trials = [trials, k]; %#ok<*AGROW>
    his = [his, alltrials{1,k}.Correctness];
    
    if(alltrials{1,k}.AnswerDirection ~= -1 && alltrials{1,k}.TrialType == 1)
        totalV = totalV+1;
        if(alltrials{1,k}.Correctness == 1 )
            numberCorrectV = numberCorrectV + 1;
        end
        hisV = [hisV, alltrials{1,k}.Correctness];
        accuracyV = [accuracyV,numberCorrectV/totalV];
        trialsV = [trialsV, k]; %#ok<*AGROW>
    end
    
    if(alltrials{1,k}.AnswerDirection ~=-1 && alltrials{1,k}.TrialType == 2)
        totalN = totalN+1;
        if(alltrials{1,k}.Correctness == 1 )
            numberCorrectN = numberCorrectN + 1;
        end
        hisN = [hisN, alltrials{1,k}.Correctness];
       
        
    end
    
    if(alltrials{1,k}.AnswerDirection ~=-1 && alltrials{1,k}.TrialType == 0)
        totalI = totalI+1;
        if(alltrials{1,k}.Correctness == 1 )
            numberCorrectI = numberCorrectI + 1;
        end
        hisI = [hisI, alltrials{1,k}.Correctness];
    end
end
% Count number of trials for each condition

accuracyV = numberCorrectV/totalV;
accuracyN = numberCorrectN/totalN;
accuracyI = numberCorrectI/totalI;
%accuracy calculation

for k = 1 : length(alltrials)
    if(alltrials{1,k}.AnswerDirection ~= -1 && alltrials{1,k}.TrialType == 1)
        studentTdistV = double(studentTdistV + double(((alltrials{1,k}.Correctness - accuracyV)^2)));
    end
    if(alltrials{1,k}.AnswerDirection ~= -1 && alltrials{1,k}.TrialType == 0)
        studentTdistI = double(studentTdistI + double(((alltrials{1,k}.Correctness - accuracyI)^2)));
    end
    if(alltrials{1,k}.AnswerDirection ~= -1 && alltrials{1,k}.TrialType == 1)
        studentTdistN = double(studentTdistN + double(((alltrials{1,k}.Correctness - accuracyN)^2)));
    end
end
% Student T distribution calculation (We don't use that one)



studentTdistV = sqrt(studentTdistV/(totalV-1));
studentTdistI = sqrt(studentTdistI/(totalI-1));
studentTdistN = sqrt(studentTdistN/(totalN-1));


alphaup = 1-0.05/2;
alphadown = 0.05/2;
upV = tinv(alphaup,totalV-1);
upN = tinv(alphaup,totalN-1);
upI = tinv(alphaup,totalI-1);
downV = tinv(alphadown, totalV - 1);
downN = tinv(alphadown, totalN - 1);
downI = tinv(alphadown, totalI - 1);

errV = upV * studentTdistV/sqrt(totalV);
errN = upN * studentTdistN/sqrt(totalN);
errI = upI * studentTdistI/sqrt(totalI);
%standard error calculation


deltaV = accuracyV - accuracyN;
deltaI = accuracyI - accuracyN;
%accuracy differences

sigmaV = sqrt(totalV * accuracyV * (1-accuracyV));
sigmaN = sqrt(totalN * accuracyN * (1-accuracyN));
sigmaI = sqrt(totalI * accuracyI * (1-accuracyI));


sigV = sqrt(accuracyV * (1-accuracyV))/sqrt(totalV);
sigN = sqrt(accuracyN * (1-accuracyN))/sqrt(totalN);
sigI = sqrt(accuracyI * (1-accuracyI))/sqrt(totalI);
% Error bar calculation


CorrectV = numberCorrectV;
CorrectI = numberCorrectI;
CorrectN = numberCorrectN;

invalid_ac = accuracyI;
valid_ac = accuracyV;
neutral_ac = accuracyN;

Vn = totalN;
Vi = totalI;
Vv = totalV;

ph_vn = (CorrectV + CorrectN)/(Vv+Vn);
ph_in = (CorrectI + CorrectN)/(Vi+Vn);
ph_vi = (CorrectV + CorrectI)/(Vv+Vi);

Z_vn = (valid_ac-neutral_ac)/sqrt(ph_vn*(1-ph_vn)*(1/Vv+1/Vn))
Z_in = (invalid_ac-neutral_ac)/sqrt(ph_in*(1-ph_in)*(1/Vi+1/Vn))
Z_vi = (valid_ac-invalid_ac)/sqrt(ph_vi*(1-ph_vi)*(1/Vv+1/Vi))

pvalueVI = 1 - normcdf(abs(Z_vi))
pvalueIN = 1 - normcdf(abs(Z_in))
pvalueVN = 1 - normcdf(abs(Z_vn))
%p-value calculation


deltax = categorical({'Valid', 'Invalid'});
deltax = reordercats(deltax,{'Valid','Invalid'});

x = categorical({'Valid','Neutral','Invalid'});
x = reordercats(x,{'Valid','Neutral','Invalid'});

std = [sigmaV,sigmaN,sigmaI];
std2 = [sigV,sigN, sigI];
std3 = [errV,errN,errI];

mean = [numberCorrectV, numberCorrectN, numberCorrectI];
acc = [accuracyV,accuracyN,accuracyI];

figure(1);
d = [sqrt(ph_vn*(1-ph_vn)*(1/Vv+1/Vn)),sqrt(ph_in*(1-ph_in)*(1/Vi+1/Vn))];
deltaV = deltaV *100;
deltaI = deltaI *100;
d = d * 100;
bar(1, deltaV, 'facecolor', [222,235,247]/255);
hold on;
bar(2, deltaI,'facecolor', [49,130,189]/255);
xticks([1 2])
xticklabels({'Valid', 'Invalid'})
% f1 = bar(deltax,[deltaV,deltaI],0.4);
errorbar(deltax,[deltaV,deltaI],d,'.','Color','black');

ytickformat('percentage');
hold on;




h = figure(2);
acc = acc*100;
std2 = std2 *100;
std3 = std3*100;

%bar(x,acc, 0.4);
bar(1, acc(1), 'facecolor', [222,235,247]/255);
hold on;
bar(2, acc(2),'facecolor', [158,202,225]/255);
hold on;
bar(3, acc(3),'facecolor', [49,130,189]/255);

xticks([1 2 3])
xticklabels({'Valid','Neutral','Invalid'});
FontSize = 10;
ytickformat('percentage');
% title('Accuracy Comparison','FontSize',24);
xlabel('Conditions','FontSize',20);
ylabel('Task Acccuracy','FontSize',20);
ylim([50,100]);
hold on
errorbar(1:3,acc,std2,'.', 'Color', 'black');
hold on



