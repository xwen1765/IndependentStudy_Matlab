numberCorrectV = 0;
numberCorrectI = 0;
numberCorrectN = 0;
totalV = 0;
totalI = 0;
totalN = 0;

for k = 1 : length(Bryce29)
    if(Bryce29{1,k}.AnswerDirection ~= -1 && Bryce29{1,k}.TrialType == 1)
        totalV = totalV + 1;
        if(Bryce29{1,k}.Correctness == 1 )
            numberCorrectV = numberCorrectV + 1;
        end
    end
    
    if(Bryce29{1,k}.AnswerDirection ~=-1 && Bryce29{1,k}.TrialType == 0)
       totalI = totalI + 1;
        if(Bryce29{1,k}.Correctness == 1 )
            numberCorrectI = numberCorrectI + 1;
        end
        
    end
    if(Bryce29{1,k}.AnswerDirection ~=-1 && Bryce29{1,k}.TrialType == 2)
        totalN = totalN + 1;
        if(Bryce29{1,k}.Correctness == 1 )
            numberCorrectN = numberCorrectN + 1;
        end
    end
end

accuracyV = numberCorrectV/totalV;
accuracyI = numberCorrectI/totalI;
accuracyN = numberCorrectN/totalN;

Bryce29deltaV = accuracyV - accuracyN;
Bryce29deltaI = accuracyI - accuracyN;
