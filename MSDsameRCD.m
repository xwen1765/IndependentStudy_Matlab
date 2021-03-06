% This code compares trials with MS in the right interval(505-->1141) to 
% (trials without MS + trials with MS which is not in the right interval)

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
% exclude all trials without MS


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
% exclude all trials with MS

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


totalMS = 0;

rightTotal = 0;
rightOpTotal = 0;

leftTotal = 0;
leftOpTotal = 0;

rightCorrect = 0;
rightOpCorrect = 0;
leftCorrect = 0;
leftOpCorrect = 0;

for k = 1 : length(alltrialsMS)
    totalMS = totalMS + 1;
    
        
         if(alltrialsMS{1,k}.CueDirection == -1)
            if(alltrialsMS{1,k}.microsaccades.angle(1) < 60*(pi/180))
                rightTotal = rightTotal+1;
                
                if(alltrialsMS{1,k}.Correctness == 1)
                    rightCorrect = rightCorrect+1;
                   
                end
            end
            
            if(alltrialsMS{1,k}.microsaccades.angle(1) > 180*(pi/180) && alltrialsMS{1,k}.microsaccades.angle(1) < 240*(pi/180))
                rightOpTotal = rightOpTotal+1;
                
                if(alltrialsMS{1,k}.Correctness == 1)
                    rightOpCorrect = rightOpCorrect+1;
                    
                end
            end
           
         end
        
        
        if(alltrialsMS{1,k}.CueDirection == 1)
            
           if(alltrialsMS{1,k}.microsaccades.angle(1) > 180*(pi/180) && alltrialsMS{1,k}.microsaccades.angle(1) < 240*(pi/180))
                leftTotal = leftTotal+1;
                
                if(alltrialsMS{1,k}.Correctness == 1)
                    leftCorrect = leftCorrect+1;
                    
                end
           end
           
           if(alltrialsMS{1,k}.microsaccades.angle(1) < 60*(pi/180))
                leftOpTotal = leftOpTotal+1;
                
                if(alltrialsMS{1,k}.Correctness == 1)
                    leftOpCorrect = leftOpCorrect+1;
                   
                end
            end
            
        end
        
   
end
% Count number of trials for each condition

accuracyL = leftCorrect/leftTotal;
accuracyLOp = leftOpCorrect/leftOpTotal;
accuracyR = rightCorrect/rightTotal;
accuracyROp = rightOpCorrect/rightOpTotal;

accMS = [accuracyL,accuracyLOp;accuracyR, accuracyROp];

bar(accMS);


figure();


bar(1, accuracyL, 'facecolor', [222,235,247]/255);
hold on;
bar(2, accuracyR, 'facecolor', [49,130,189]/255);

deltax = categorical({'To Left','To Right'});
deltax = reordercats(deltax,{'To Left','To Right'});

xticks([1 2]);
xticklabels({'To Left','To Right'});
title("---", "FontSize", 20);
set(gca,'FontSize',26);