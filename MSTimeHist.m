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
trialsBeforeCue = [];
trialsBeforeStmOff = [];

for k = 1 : length(alltrials)
   
    if(~isempty(alltrials{1,k}.microsaccades.start))
        if(alltrials{1,k}.Correctness == 1)
            correctM = correctM + 1;
        end
        for h = 1 : length(alltrials{1,k}.microsaccades.start)         
            time = [time, alltrials{1,k}.microsaccades.start(h)];
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


hist(time);
[heights,centers] = hist(time);
hold on
n = length(centers);
w = centers(2)-centers(1);
t = linspace(centers(1)-w/2,centers(end)+w/2,n+1);
p = fix(n/2);
hold off
dt = diff(t);
Fvals = cumsum([0,heights.*dt]);
F = spline(t, [0, Fvals, 0]);
DF = fnder(F);  % computes its first derivative
hold on
fnplt(DF, 'r', 2);
ylims = ylim; 
ylim([0,ylims(2)]);

lb = [505 805 1105 1141 1285 1680];
for i = 1 : length(lb)
    
    plot([lb(i),lb(i)],[0,350],'w--', 'LineWidth', 2);
    hold on;
end

title("#mS in time","Fontsize", 22);
xticks([505 805 1105 1141 (1285+1680)/2]);
xticklabels({'Cues Appear','Cues End','Stimulus','','Response Cues'});





% y = hist(time,50);
% hist(time,50);
% hold on;
% %x = smooth(y);
% [f,xi] = ksdensity(y);
% hold on
% plot(xi,f);
% title("#mS in time","Fontsize", 26);
% xticks([0 505 805 1105 1141 1285 1680]);
% xticklabels({'0','505','805','1105','1141','1285','1680'});
% hold off;
% %polarplot(theta,amp, 'x');
