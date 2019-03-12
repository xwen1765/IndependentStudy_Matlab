
K = 1:length(hisV);
[N,~] = histcounts(K,ceil(length(hisV)/10));
T = [];
num = 0;
numV = 0;
for k = 1 : length(N)
    for j = 1 : N(k)
        num  = num +1;
        numV = hisV(num) + numV;
    end
    T = [T, numV];
    numV = 0;
end
subplot(2,2,1);
bar(T);
title('Valid','FontSize',24);

K = 1:length(hisI);
[N,~] = histcounts(K,ceil(length(hisI)/10));
T = [];
num = 0;
numI = 0;
for k = 1 : length(N)
    for j = 1 : N(k)
        num  = num +1;
        numI = hisI(num) + numI;
    end
    T = [T, numI];
    numI = 0;
end
subplot(2,2,2);
bar(T);
title('Invalid','FontSize',24);
ylim([0,10]);

K = 1:length(hisN);
[N,edges] = histcounts(K,ceil(length(hisN)/10)); %#ok<*ASGLU>
T = [];
num = 0;
numN = 0;
for k = 1 : length(N)
    for j = 1 : N(k)
        num  = num +1;
        numN = hisN(num) + numN;
    end
    T = [T, numN];
    numN = 0;
end
subplot(2,2,3);
bar(T);
title('Neutral','FontSize',24);

K = 1:length(his);
[N,edges] = histcounts(K,ceil(length(his)/10));
T = [];
num = 0;
numN = 0;
for k = 1 : length(N)
    for j = 1 : N(k)
        num  = num +1;
        numN = his(num) + numN;
    end
    T = [T, numN];
    numN = 0;
end
subplot(2,2,4);
bar(T);
title('Overall','FontSize',24);

% g1 = subplot(2,2,1);
% plot(trialsV, accuracyV);
% xlabel({'Valid'},'FontSize',14,'FontWeight','bold');
% ylim([0,1])
%
% g2 = subplot(2,2,2);
% plot(trialsN, accuracyN);
% xlabel({'Neutral'},'FontSize',14,'FontWeight','bold');
% ylim([0,1])
% 
% g3 = subplot(2,2,3);
% plot(trialsI, accuracyI);
% xlabel({'Invalid'},'FontSize',14,'FontWeight','bold');
% ylim([0,1])
% 
% g4 = subplot(2,2,4);
% plot(trials, accuracy);
% xlabel({'All trials'},'FontSize',14,'FontWeight','bold');
% ylim([0,1])
% 
% sgtitle('Accuracy Changes --- Wen Overall','FontSize',24,'FontWeight','bold');
