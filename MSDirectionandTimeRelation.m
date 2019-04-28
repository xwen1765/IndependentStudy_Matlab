withM = 0;
countM = 0;
theta = [];
amp = [];
time = [];
first = 0;
second = 0;
third = 0;
forth = 0;
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

MSbeforePrecue = [];
MSinPrecue = [];
MSBetweenPrecueAndStimuli = [];
MSinStimuli = [];
AllMS = [];
for k = 1 : length(alltrials)
    if(~isempty(alltrials{1,k}.microsaccades.start))
        if(alltrials{1,k}.Correctness == 1)
            correctM = correctM + 1;
        end
        
        
        collecta = 0;
        collectb = 0;
        
        for h = 1 : length(alltrials{1,k}.microsaccades.start)
            
            time = [time, alltrials{1,k}.microsaccades.start(h)];
            
            if((alltrials{1,k}.microsaccades.start(h) < 1141 ) && collectb == 0)
                trialsBeforeStmOff = [trialsBeforeStmOff, k];
                collectb = 1;
                
                for j = 1 : length(alltrials{1,k}.microsaccades.angle)
                    countM = countM + 1;
                    
                    if( alltrials{1,k}.microsaccades.start(h) < 505)
                   
                    MSbeforePrecue = [MSbeforePrecue, alltrials{1,k}.microsaccades.angle(j)];
                    end
                    
                    if(alltrials{1,k}.microsaccades.start(h) > 505 && alltrials{1,k}.microsaccades.start(h) < 805)
                   
                    MSinPrecue = [MSinPrecue, alltrials{1,k}.microsaccades.angle(j)];
                    end
                    if(alltrials{1,k}.microsaccades.start(h) > 805 && alltrials{1,k}.microsaccades.start(h) < 1105)
                   
                    MSBetweenPrecueAndStimuli = [MSBetweenPrecueAndStimuli, alltrials{1,k}.microsaccades.angle(j)];
                    end
                    if(alltrials{1,k}.microsaccades.start(h) > 1105 && alltrials{1,k}.microsaccades.start(h) < 1141)
                   
                    MSinStimuli = [MSinStimuli, alltrials{1,k}.microsaccades.angle(j)];
                    end
                    
                    AllMS = [AllMS, alltrials{1,k}.microsaccades.angle(j)];
                end
            end
            
            if((alltrials{1,k}.microsaccades.start(h) < 505 ...
                    || alltrials{1,k}.microsaccades.start(h) > 1141 ) && collecta == 0)
               
                 trialsNotImpo = [trialsNotImpo, k];
                   collecta = 1;
            end
            
        end

        totalM = totalM + 1;
    end
    
    if(isempty(alltrials{1,k}.microsaccades.start))
        if(alltrials{1,k}.Correctness == 1)
            correctNoM = correctNoM + 1;
        end
        totalNoM = totalNoM +1;
    end
end



disp(correctM/totalM);
disp(correctNoM/totalNoM);

All = polarhistogram(AllMS, 20);
AllValues = All.Values;
All.Values

k = polarhistogram(MSbeforePrecue,20);
sum(k.Values)
kValues = k.Values./sum(k.Values);
kValues(isnan(kValues)) = 0;

r = polarhistogram(MSinPrecue,20);
sum(r.Values)
rValues = r.Values./sum(r.Values);
rValues(isnan(rValues)) = 0;


g = polarhistogram(MSBetweenPrecueAndStimuli,20);

mmm = sum(g.Values);
mvalues = g.Values;



b = polarhistogram(MSinStimuli, 20);
nnn = sum(b.Values);
nvalues =  b.Values;

aValues  = (mvalues+nvalues)./(mmm + nnn);

subplot(1,3,1);
p3 = polarhistogram('BinEdges',0:pi/10:2*pi,'BinCounts', kValues, 'FaceColor', 'b','FaceAlpha', 0.5);
rlim([0,max(kValues)]);
title('MS before initial cue (505ms)', 'FontSize', 16);
set(gca,'FontSize',20);


hold off;


subplot(1,3,2);
p1 = polarhistogram('BinEdges',0:pi/10:2*pi,'BinCounts', rValues, 'FaceColor', 'r','FaceAlpha', 0.5);
rlim([0,max(rValues)]);
title('MS in initial cue (300ms)', 'FontSize', 16);
set(gca,'FontSize',20);

hold off;

subplot(1,3,3);

p2 = polarhistogram('BinEdges',0:pi/10:2*pi,'BinCounts', aValues, 'FaceColor', 'y','FaceAlpha', 0.5);
title('MS in ISI and stimuli (336ms)', 'FontSize', 16);
rlim([0,max(aValues)]);
set(gca,'FontSize',20);
set(h,'Position',[0, 0, 1200, 400]);
hold off;

%sgtitle('Z068 MS frequency data in probility', 'FontSize', 28);




% subplot(1,3,3);
% p3 = polarhistogram('BinEdges',0:pi/10:2*pi,'BinCounts', bValues, 'FaceColor', 'b','FaceAlpha', 0.5);
% title('MS in stimuli (36ms)', 'FontSize', 16);
% rlim([0,max(bValues)]);

% subplot(1,2,1);
% polarplot(theta,amp, 'x');
% subplot(1,2,2);
% hist(theta);
% xlim([0,2*pi]);
% xticks([0,pi/4, pi/2, 3*pi/4, pi, pi+pi/4, pi+pi/2, pi+3*pi/4, 2*pi]);
% xticklabels({'0','45','90','135','180','225','270','315','360'});
