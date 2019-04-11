% %This code compares trials with MS in the right interval(505-->1141) to 
% %(trials without MS + trials with MS which is not in the right interval)

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
exclude = [];


for k = 1 : length(pptrials)
    
    
    if(~isempty(pptrials{1,k}.notracks.start)||pptrials{1,k}.AnswerDirection ~= -1)
        
        
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
    if(~ismember(fieldnames(pptrials{1,k}),'ResponseTime'))
         exclude = [exclude, k];
    end
end

exclude = unique(exclude);
alltrials = pptrials;
for k = 1 : length(exclude)
    alltrials{exclude(k)} = [];
end
alltrials(cellfun('isempty', alltrials)) = [];
% Exclude inaccurate trials


alltrialsMS = alltrials;
exclude = [];
for k = 1 : length(alltrialsMS)
    if(isempty(alltrialsMS{1,k}.microsaccades.start))
        exclude = [exclude, k];
    end
end
exclude = unique(exclude);
for k = 1 : length(exclude)
    alltrialsMS{exclude(k)} = [];
end
alltrialsMS(cellfun('isempty', alltrialsMS)) = [];
%exclude all trials without MS


alltrialsNoMS = alltrials;
exclude = [];
for k = 1 : length(alltrialsNoMS)
    if(~isempty(alltrialsNoMS{1,k}.microsaccades.start))
        exclude = [exclude, k];
    end
end
exclude = unique(exclude);
for k = 1 : length(exclude)
    alltrialsNoMS{exclude(k)} = [];
end
alltrialsNoMS(cellfun('isempty', alltrialsNoMS)) = [];
%exclude all trials with MS

trialsBeforeStmOff = [];
for k = 1 : length(alltrialsMS)
    if(~isempty(alltrialsMS{1,k}.microsaccades.start))
        onlyCountOnce = 0;
        
        for h = 1 : length(alltrialsMS{1,k}.microsaccades.start)
            
            if((alltrialsMS{1,k}.microsaccades.start(h) > 505 ...
                    && alltrialsMS{1,k}.microsaccades.start(h) < 1141 ) && onlyCountOnce == 0)
                trialsBeforeStmOff = [trialsBeforeStmOff, k]; %#ok<*AGROW>
                onlyCountOnce = 1;
            end
        end
        
    end
end


totalMSVinI = 0;
totalMSIinI = 0;
totalMSNinI = 0;
totalMSVNoinI = 0;
totalMSNNoinI = 0;
totalMSINoinI = 0;

totalMS = 0;
numberCorrectVMS = 0;
numberCorrectIMS = 0;
numberCorrectNMS = 0;

numberCorrectVNoMSinI = 0;
numberCorrectINoMSinI = 0;
numberCorrectNNoMSinI = 0;

accuracyVMS = 0;
accuracyNMS = 0;
accuracyIMS = 0;


for k = 1 : length(alltrialsMS)
    totalMS = totalMS + 1;
    if((alltrialsMS{1,k}.AnswerDirection ~= -1 && alltrialsMS{1,k}.TrialType == 1))
        
        if(ismember(k, trialsBeforeStmOff))
             totalMSVinI = totalMSVinI+1;
             %all trials contain MS in the right time interval
             if(alltrialsMS{1,k}.Correctness == 1 )
                %number of right anwsers
                numberCorrectVMS = numberCorrectVMS + 1;
             end
        else
            totalMSVNoinI = totalMSVNoinI +1;
            %all trials contain MS not in the time interval
             if(alltrialsMS{1,k}.Correctness == 1 )
                %number of right anwsers
                 numberCorrectVNoMSinI = numberCorrectVNoMSinI + 1;
             end 
        end
    end
    
    if((alltrialsMS{1,k}.AnswerDirection ~=-1 && alltrialsMS{1,k}.TrialType == 2))
        
        if(ismember(k, trialsBeforeStmOff))
            totalMSNinI = totalMSNinI+1;
             if(alltrialsMS{1,k}.Correctness == 1 )
                numberCorrectNMS = numberCorrectNMS + 1;
             end
        else
             totalMSNNoinI = totalMSNNoinI+1;
             if(alltrialsMS{1,k}.Correctness == 1 )
                 numberCorrectNNoMSinI = numberCorrectNNoMSinI + 1;
             end 
        end
        
    end
    
    if((alltrialsMS{1,k}.AnswerDirection ~=-1 && alltrialsMS{1,k}.TrialType == 0))
        
         if(ismember(k, trialsBeforeStmOff))
             totalMSIinI = totalMSIinI+1;
             if(alltrialsMS{1,k}.Correctness == 1 )
                numberCorrectIMS = numberCorrectIMS + 1;
             end
         else
            totalMSINoinI = totalMSINoinI+1;
             if(alltrialsMS{1,k}.Correctness == 1 )
                 numberCorrectINoMSinI = numberCorrectINoMSinI + 1;
             end 
        end
        
    end
end
% Count number of trials for each condition

accuracyVMS = numberCorrectVMS/totalMSVinI;
accuracyNMS = numberCorrectNMS/totalMSNinI;
accuracyIMS = numberCorrectIMS/totalMSIinI;
accMS = [accuracyVMS,accuracyNMS,accuracyIMS];
%accuracy calculation



totalNoMSV = 0;
totalNoMSI = 0;
totalNoMSN = 0;
totalNoMS = 0;
numberCorrectVNoMS = 0;
numberCorrectNNoMS = 0;
numberCorrectINoMS = 0;
accuracyVNoMS = 0;
accuracyNNoMS = 0;
accuracyINoMS = 0;

for k = 1 : length(alltrialsNoMS)
    totalNoMS = totalNoMS + 1;
    
    if(alltrialsNoMS{1,k}.AnswerDirection ~= -1 && alltrialsNoMS{1,k}.TrialType == 1 )
        totalNoMSV = totalNoMSV+1;
        if(alltrialsNoMS{1,k}.Correctness == 1 )
            numberCorrectVNoMS = numberCorrectVNoMS + 1;
        end
    end
    
    if(alltrialsNoMS{1,k}.AnswerDirection ~=-1 && alltrialsNoMS{1,k}.TrialType == 2)
        totalNoMSN = totalNoMSN+1;
        if(alltrialsNoMS{1,k}.Correctness == 1 )
            numberCorrectNNoMS = numberCorrectNNoMS + 1;
        end
        
    end
    
    if(alltrialsNoMS{1,k}.AnswerDirection ~=-1 && alltrialsNoMS{1,k}.TrialType == 0)
        totalNoMSI = totalNoMSI+1;
        if(alltrialsNoMS{1,k}.Correctness == 1 )
            numberCorrectINoMS = numberCorrectINoMS + 1;
        end
        
    end
end
% Count number of trials for each condition

accuracyVNoMS = (numberCorrectVNoMS + numberCorrectVNoMSinI)/(totalNoMSV + totalMSVNoinI);
accuracyNNoMS = (numberCorrectNNoMS + numberCorrectNNoMSinI)/(totalNoMSN + totalMSNNoinI);
accuracyINoMS = (numberCorrectINoMS + numberCorrectINoMSinI)/(totalNoMSI + totalMSINoinI);
%accuracy calculation




CorrectVMS = numberCorrectVMS;
CorrectIMS = numberCorrectIMS;
CorrectNMS = numberCorrectNMS;

invalid_acMS = accuracyIMS;
valid_acMS = accuracyVMS;
neutral_acMS = accuracyNMS;

VnMS = totalMSNinI;
ViMS = totalMSIinI;
VvMS = totalMSVinI;

ph_vnMS = (CorrectVMS + CorrectNMS)/(VvMS+VnMS);
ph_inMS = (CorrectIMS + CorrectNMS)/(ViMS+VnMS);
ph_viMS = (CorrectVMS + CorrectIMS)/(VvMS+ViMS);

Z_vnMS = (valid_acMS-neutral_acMS)/sqrt(ph_vnMS*(1-ph_vnMS)*(1/VvMS+1/VnMS))
Z_inMS = (invalid_acMS-neutral_acMS)/sqrt(ph_inMS*(1-ph_inMS)*(1/ViMS+1/VnMS))
Z_viMS = (valid_acMS-invalid_acMS)/sqrt(ph_viMS*(1-ph_viMS)*(1/VvMS+1/ViMS))

pvalueVIMS = 1 - normcdf(abs(Z_viMS))
pvalueINMS = 1 - normcdf(abs(Z_inMS))
pvalueVNMS = 1 - normcdf(abs(Z_vnMS))
%p-value calculation for trials with MS

sigVMS = sqrt(accuracyVMS * (1-accuracyVMS))/sqrt(totalMSVinI);
sigNMS = sqrt(accuracyNMS * (1-accuracyNMS))/sqrt(totalMSNinI);
sigIMS = sqrt(accuracyIMS * (1-accuracyIMS))/sqrt(totalMSIinI);
% Error bar calculation


CorrectVNoMS = numberCorrectVNoMS;
CorrectINoMS = numberCorrectINoMS;
CorrectNNoMS = numberCorrectNNoMS;

invalid_acNoMS = accuracyINoMS;
valid_acNoMS = accuracyVNoMS;
neutral_acNoMS = accuracyNNoMS;

VnNoMS = totalNoMSN;
ViNoMS = totalNoMSI;
VvNoMS = totalNoMSV;

ph_vnNoMS = (CorrectVNoMS + CorrectNNoMS)/(VvNoMS+VnNoMS);
ph_inNoMS = (CorrectINoMS + CorrectNNoMS)/(ViNoMS+VnNoMS);
ph_viNoMS = (CorrectVNoMS + CorrectINoMS)/(VvNoMS+ViNoMS);

Z_vnNoMS = (valid_acNoMS-neutral_acNoMS)/sqrt(ph_vnNoMS*(1-ph_vnNoMS)*(1/VvNoMS+1/VnNoMS))
Z_inNoMS = (invalid_acNoMS-neutral_acNoMS)/sqrt(ph_inNoMS*(1-ph_inNoMS)*(1/ViNoMS+1/VnNoMS))
Z_viNoMS = (valid_acNoMS-invalid_acNoMS)/sqrt(ph_viNoMS*(1-ph_viNoMS)*(1/VvNoMS+1/ViNoMS))

pvalueVINoMS = 1 - normcdf(abs(Z_viNoMS))
pvalueINNoMS = 1 - normcdf(abs(Z_inNoMS))
pvalueVNNoMS = 1 - normcdf(abs(Z_vnNoMS))
%p-value calculation

sigVNoMS = sqrt(accuracyVNoMS * (1-accuracyVNoMS))/sqrt(totalNoMSV);
sigNNoMS = sqrt(accuracyNNoMS * (1-accuracyNNoMS))/sqrt(totalNoMSN);
sigINoMS = sqrt(accuracyINoMS * (1-accuracyINoMS))/sqrt(totalNoMSI);
% Error bar calculation



hold off;
acc = [accuracyVMS accuracyVNoMS;accuracyNMS accuracyNNoMS; accuracyIMS accuracyINoMS];
errStd = [sigVMS sigVNoMS; sigNMS sigNNoMS; sigIMS sigINoMS];
acc = acc*100;
errStd = errStd *100;
stdlabel = [sigVMS sigVNoMS; sigNMS sigNNoMS; sigIMS sigINoMS];

hB = barwitherr(errStd,acc);

%labels = [totalMSVinI (totalNoMSV +totalMSVNoinI); totalMSNinI (totalNoMSN + totalMSNNoinI); totalMSIinI (totalNoMSI + totalMSINoinI)];

labels = [totalMSVinI (totalNoMSV ); totalMSNinI (totalNoMSN); totalMSIinI (totalNoMSI)];
labels = string(labels);
hT=[];              
% placeholder for text object handles


% for i=1:length(hB)  % iterate over number of bar objects
%     hT=[hT,text(hB(i).XData+hB(i).XOffset,hB(i).YData + 0.05,labels(:,i), ...
%         'VerticalAlignment','bottom','horizontalalign','center')];
% end



xticks([1 2 3 4 5 6]);
xticklabels({'Valid','Neutral','Invalid'});
ylim([50,100]);
ytickformat('percentage');
ylabel('Task Acccuracy','FontSize',20);
legend("With MS","Without MS", 'FontSize', 26);
set(h,'Position',[0, 0, 800, 640]);
set(gca,'FontSize',26);

figure();
deltaMS = accuracyVMS - accuracyIMS;
deltaNoMS = accuracyVNoMS - accuracyINoMS;
deltaAcc = [accuracyVMS - accuracyIMS, accuracyVNoMS - accuracyINoMS];

d = [sqrt(ph_viMS*(1-ph_viMS)*(1/VvMS+1/ViMS)),sqrt(ph_viNoMS*(1-ph_viNoMS)*(1/VvNoMS+1/ViNoMS))];

bar(1, deltaMS, 'facecolor', [222,235,247]/255);
hold on;
bar(2, deltaNoMS, 'facecolor', [49,130,189]/255);

deltax = categorical({'With MS','Without MS'});
deltax = reordercats(deltax,{'With MS','Without MS'});

errorbar(deltax,[deltaMS,deltaNoMS],d,'.','Color','black');

xticks([1 2 ]);
xticklabels({'With MS','Without MS'});
title("Valid Accurancy - Invalid Accurancy", "FontSize", 20);
set(gca,'FontSize',26);