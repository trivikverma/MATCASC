function [flowMatrix, Bdc, powerInj, phaseAngles, slackPower]= PerformDcLoadFlowAnalysis(casedata)

baseMVA=casedata.baseMVA;
busData=casedata.bus;           % Bus info
branchData=casedata.branch;     % Branch info

[BbusSparse,~,~,~] = MakeBdc(baseMVA, busData, branchData); % Obtain sparse admittance matrix
Bdc=full(BbusSparse);                                       % Full admittance matrix

[BdcReduced, slack]= MakeBdcReduced(Bdc, busData);                 % Reduced admittance matrix

[powerInj, powerInjReduced, slackPower]= MakePowerInjVector(casedata,busData, slack); % Compute nodal power injections

[phaseAngles, phaseAnglesReduced]= ComputePhaseAngles(powerInjReduced, BdcReduced, slack); % Compute nodal voltage phase angles

%% Computing the flow values in lines

TempFlowMatrix=triu(-1*Bdc+diag(diag(Bdc)));
[r,c,b]=find(TempFlowMatrix);

for j=1:size(r,1)
    
    tempr=r(j);
    tempc=c(j);
    tempb=b(j);
    tempPhaseDiff=phaseAngles(tempr)-phaseAngles(tempc);
    TempFlowMatrix(tempr,tempc)= tempPhaseDiff*tempb;
    
end


[r2,c2,f]=find(TempFlowMatrix<0);                 % Correcting negative flows
for i=1:size(f,1)
    TempFlowMatrix(c2(i),r2(i))=-TempFlowMatrix(r2(i),c2(i));
    TempFlowMatrix(r2(i),c2(i))=0;
end

flowMatrix=TempFlowMatrix;




