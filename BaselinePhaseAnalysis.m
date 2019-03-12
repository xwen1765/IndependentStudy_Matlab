correct = 0;
incorrect = 0;

for k = 1:length(pptrials)
    if(pptrials{1,k}.Correctness == 1)
        correct = correct+1;
    end
    if((pptrials{1,k}.Correctness == 0) && (pptrials{1,k}.AnswerDirection ~= -1))
        incorrect = incorrect+1;
    end
    
end
