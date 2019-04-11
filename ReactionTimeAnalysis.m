%test github changes
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
ResponseTime = 0;

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
    
    
    
    if(~ismember(fieldnames(pptrials{1,k}),'ResponseTime'))
         exclude = [exclude, k];
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

rtV = 0;
rtN = 0;
rtI = 0;

for k = 1 : length(alltrials)
    total = total+1;
    if(alltrials{1,k}.Correctness == 1 )
        numberCorrect = numberCorrect + 1;
    end
    trials = [trials, k]; %#ok<*AGROW>
    his = [his, alltrials{1,k}.Correctness];
    
    if(alltrials{1,k}.AnswerDirection ~= -1 && alltrials{1,k}.TrialType == 1)
        totalV = totalV+1;
        rtV = rtV + alltrials{1,k}.ResponseTime;
        if(alltrials{1,k}.Correctness == 1 )
            numberCorrectV = numberCorrectV + 1;
        end
        
        hisV = [hisV, alltrials{1,k}.Correctness];
        accuracyV = [accuracyV,numberCorrectV/totalV];
        trialsV = [trialsV, k]; %#ok<*AGROW>
    end
    
    if(alltrials{1,k}.AnswerDirection ~=-1 && alltrials{1,k}.TrialType == 2)
        totalN = totalN+1;
        rtN = rtN + alltrials{1,k}.ResponseTime;
        if(alltrials{1,k}.Correctness == 1 )
            numberCorrectN = numberCorrectN + 1;
        end
        hisN = [hisN, alltrials{1,k}.Correctness];
       
        
    end
    
    if(alltrials{1,k}.AnswerDirection ~=-1 && alltrials{1,k}.TrialType == 0)
        totalI = totalI+1;
        rtI = rtI + alltrials{1,k}.ResponseTime;
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




sigV = sqrt(accuracyV * (1-accuracyV))/sqrt(totalV);
sigN = sqrt(accuracyN * (1-accuracyN))/sqrt(totalN);
sigI = sqrt(accuracyI * (1-accuracyI))/sqrt(totalI);
% Error bar calculation




deltax = categorical({'Valid', 'Invalid'});
deltax = reordercats(deltax,{'Valid','Invalid'});

x = categorical({'Valid','Neutral','Invalid'});
x = reordercats(x,{'Valid','Neutral','Invalid'});

std = [sigmaV,sigmaN,sigmaI];
std2 = [sigV,sigN, sigI];
std3 = [errV,errN,errI];

mean = [numberCorrectV, numberCorrectN, numberCorrectI];
acc = [accuracyV,accuracyN,accuracyI];

rt = [rtV/totalV , rtN/totalN , rtI/totalI ];

h = figure(2);
%bar(x,acc, 0.4);
bar(1, rt(1), 'facecolor', [222,235,247]/255);
hold on;
bar(2, rt(2),'facecolor', [158,202,225]/255);
hold on;
bar(3, rt(3),'facecolor', [49,130,189]/255);

xticks([1 2 3])
xticklabels({'Valid','Neutral','Invalid'});
FontSize = 10;
set(gca,'FontSize',26);
% title('Accuracy Comparison','FontSize',24);
ylim([1680, 2300]);
xlabel('Conditions','FontSize',28);
ylabel('Response Time','FontSize',28);
hold on

set(h,'Position',[0, 0, 800, 640]);

