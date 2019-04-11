withM = 0;
countM = 0;
theta = [];
amp = [];
time = [];
correctM = 0;
totalM = 0;
correctNoM = 0;
totalNoM = 0;
exclude = [];
trialsBeforeStmOff = [];
trialsNotImpo = [];

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
    
end

exclude = unique(exclude);
alltrials = pptrials;
for k = 1 : length(exclude)
    alltrials{exclude(k)} = [];
end
alltrials(cellfun('isempty', alltrials)) = [];
% Exclude inaccurate trials


for k = 1 : length(alltrials)
    if(~isempty(alltrials{1,k}.saccades.start))
        
        
        
        collecta = 0;
        collectb = 0;
        
        for h = 1 : length(alltrials{1,k}.saccades.start)
            
            time = [time, alltrials{1,k}.saccades.start(h)];
            
            if((alltrials{1,k}.saccades.start(h) > 505 ...
                    && alltrials{1,k}.saccades.start(h) < 1141 ) && collectb == 0)
                trialsBeforeStmOff = [trialsBeforeStmOff, k];
                collectb = 1;
            end
            
            if((alltrials{1,k}.saccades.start(h) < 505 ...
                    || alltrials{1,k}.saccades.start(h) > 1141 ) && collecta == 0)
                
                trialsNotImpo = [trialsNotImpo, k];
                collecta = 1;
            end
            
        end
        
        totalM = totalM + 1;
    end
    
end
countL = 0;
countR = 0;
countN = 0;
thetaR = [];
ampR = [];
thetaL = [];
ampL = [];
thetaN = [];
ampN = [];

for i = 1:length(trialsBeforeStmOff)
    if((alltrials{1,trialsBeforeStmOff(i)}.CueDirection == -1 && alltrials{1,trialsBeforeStmOff(i)}.TrialType == 1)...
            ||(alltrials{1,trialsBeforeStmOff(i)}.CueDirection == 1) && alltrials{1,trialsBeforeStmOff(i)}.TrialType == 2)
        for j = 1 : length(alltrials{1,trialsBeforeStmOff(i)}.saccades.angle)
            countR = countR + 1;
            thetaR = [thetaR, alltrials{1,trialsBeforeStmOff(i)}.saccades.angle(j)]; %#ok<*AGROW>
            ampR = [ampR, alltrials{1,trialsBeforeStmOff(i)}.saccades.amplitude(j)];
        end
        
    end
    
    if((alltrials{1,trialsBeforeStmOff(i)}.CueDirection == 1 && alltrials{1,trialsBeforeStmOff(i)}.TrialType == 1)...
            ||(alltrials{1,trialsBeforeStmOff(i)}.CueDirection == -1) && alltrials{1,trialsBeforeStmOff(i)}.TrialType == 2)
        
         for j = 1 : length(alltrials{1,trialsBeforeStmOff(i)}.saccades.angle)
            countL = countL + 1;
            thetaL = [thetaL, alltrials{1,trialsBeforeStmOff(i)}.saccades.angle(j)]; %#ok<*AGROW>
            ampL = [ampL, alltrials{1,trialsBeforeStmOff(i)}.saccades.amplitude(j)];
        end
        
    end
    
    if(alltrials{1,trialsBeforeStmOff(i)}.TrialType == 0)
        
         for j = 1 : length(alltrials{1,trialsBeforeStmOff(i)}.saccades.angle)
            countN = countN + 1;
            thetaN = [thetaN, alltrials{1,trialsBeforeStmOff(i)}.saccades.angle(j)]; %#ok<*AGROW>
            ampN = [ampN, alltrials{1,trialsBeforeStmOff(i)}.saccades.amplitude(j)];
        end
        
    end
    
end
h = figure();
subplot(3,2,1);
polarplot(thetaL,ampL, 'x');


subplot(3,2,2);
polarhistogram(thetaL,15);

% xlim([0,2*pi]);
% xticks([0,pi/4, pi/2, 3*pi/4, pi, pi+pi/4, pi+pi/2, pi+3*pi/4, 2*pi]);
% xticklabels({'0','45','90','135','180','225','270','315','360'});

subplot(3,2,3);
polarplot(thetaR,ampR, 'x');
subplot(3,2,4);
polarhistogram(thetaR,15);
% xlim([0,2*pi]);
% xticks([0,pi/4, pi/2, 3*pi/4, pi, pi+pi/4, pi+pi/2, pi+3*pi/4, 2*pi]);
% xticklabels({'0','45','90','135','180','225','270','315','360'});

subplot(3,2,5);
polarplot(thetaN,ampN, 'x');
subplot(3,2,6);
polarhistogram(thetaR,15);
sgtitle('Z068 Saccades Data','FontSize',16);
set(h,'Position',[0, 0, 600, 800]);
export_fig BryceSaccadesData.png -m3;

% xlim([0,2*pi]);
% xticks([0,pi/4, pi/2, 3*pi/4, pi, pi+pi/4, pi+pi/2, pi+3*pi/4, 2*pi]);
% xticklabels({'0','45','90','135','180','225','270','315','360'});

