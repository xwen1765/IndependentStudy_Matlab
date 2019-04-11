leftTotal = 0;
rightTotal = 0;
direction = 0;
lvt = 0;
lit = 0;
lnt = 0;
rvt = 0;
rit = 0;
rnt = 0;
lvc = 0;
lic = 0;
lnc = 0;
rvc = 0;
ric = 0;
rnc = 0;

rightCorrect = 0;
leftCorrect = 0;
for k = 1:length(alltrials)
    
    if(alltrials{1,k}.TrialType == 1)
        if(alltrials{1,k}.CueDirection == -1)
            leftTotal = leftTotal+1;
            lvt = lvt+1;
            if(alltrials{1,k}.Correctness == 1)
                leftCorrect = leftCorrect+1;
                lvc = lvc+1;
            end
        end
        
        if(alltrials{1,k}.CueDirection == 1)
            rightTotal = rightTotal+1;
            rvt = rvt+1;
            if(alltrials{1,k}.Correctness == 1)
                rightCorrect = rightCorrect+1;
                rvc = rvc +1;
            end
        end
    end
    
    
    
    if(alltrials{1,k}.TrialType == 0)
        if(alltrials{1,k}.CueDirection == 1)
            leftTotal = leftTotal+1;
            lit = lit+1;
            if(alltrials{1,k}.Correctness == 1)
                leftCorrect = leftCorrect+1;
                lic = lic+1;
            end
        end
        
        if(alltrials{1,k}.CueDirection == -1)
            rightTotal = rightTotal+1;
            rit = rit+1;
            if(alltrials{1,k}.Correctness == 1)
                rightCorrect = rightCorrect+1;
                ric = ric +1;
            end
        end
    end
    
    
    if(alltrials{1,k}.TrialType == 2)
        if(alltrials{1,k}.CueDirection == -1)
            leftTotal = leftTotal+1;
            lnt = lnt+1;
            if(alltrials{1,k}.Correctness == 1)
                leftCorrect = leftCorrect+1;
                lnc = lnc+1;
            end
        end
        
        if(alltrials{1,k}.CueDirection == 1)
            rightTotal = rightTotal+1;
            rnt = rnt+1;
            if(alltrials{1,k}.Correctness == 1)
                rightCorrect = rightCorrect+1;
                rnc = rnc +1;
            end
        end
    end
end

acclv = lvc/lvt;
accli = lic/lit;
accln = lnc/lnt;
accrv = rvc/rvt;
accri = ric/rit;
accrn = rnc/rnt;

accl = leftCorrect/leftTotal;
accr = rightCorrect/rightTotal;

sigVL = 1* sqrt(acclv * (1-acclv))/sqrt(lvt);
sigNL = 1* sqrt(accln * (1-accln))/sqrt(lnt);
sigIL = 1* sqrt(accli * (1-accli))/sqrt(lit);
sigVR = 1* sqrt(accrv * (1-accrv))/sqrt(rvt);
sigNR = 1* sqrt(accrn * (1-accrn))/sqrt(rnt);
sigIR = 1* sqrt(accri * (1-accri))/sqrt(rit);

err = [sigVL sigVR; sigNL sigNR; sigIL sigIR ];
err = err *100;
disp('Total accuracy');
disp(leftCorrect/leftTotal);
disp(rightCorrect/rightTotal);

xname = categorical({'Valid','Neutral','Invalid'});
xname = reordercats(xname,{'Valid','Neutral','Invalid'});

x = [lvc/lvt rvc/rvt;lnc/lnt rnc/rnt;lic/lit ric/rit];
x = x *100;
% g = bar(xname,x);
% hold on;
% errorbar(x,err,'.','Color','black');
% l = [{'Up'},{'Bottom'}];
% leg = legend(g,l);
% set(leg,'FontSize',16);
% ylim([0.5,1]);



% Data to be plotted as a bar graph
model_series = x;
%Data to be plotted as the error bars
model_error = err;
% Creating axes and the bar graph
ax = axes;
h = bar(model_series,'BarWidth',1);
% Set color for each bar face
% h(1).FaceColor = 'blue';
% h(2).FaceColor = 'yellow';
% Properties of the bar graph as required
ax.YGrid = 'off';
ax.GridLineStyle = '-';
xticks(ax,[1 2 3]);
ytickformat('percentage');

% Naming each of the bar groups
xticklabels(ax,{ 'Valid', 'Neutral', 'Invalid'});
% X and Y labels

ylim([50,100]);
% Creating a legend and placing it outside the bar plot
hold on;
% Finding the number of groups and the number of bars in each group
ngroups = size(model_series, 1);
nbars = size(model_series, 2);
% Calculating the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
% Set the position of each error bar in the centre of the main bar
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
for i = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, model_series(:,i), model_error(:,i), 'k', 'linestyle', 'none');
end
lg = legend('Upper-right','Lower-left'); 
set(lg,'FontSize',26);
hold on;

%set(h,'Position',[0, 0, 800, 640]);
set(gca,'FontSize',26);


% disp('Bottom left');
% disp(lvc/lvt);
% disp(lnc/lnt);
% disp(lic/lit);
% 
% disp('Upper right');
% disp(rvc/rvt);
% disp(rnc/rnt);
% disp(ric/rit);