function [powerInj, powerInjReduced, slackPower]= MakePowerInjVector(casedata,busData, slack)

% demand values of each bus
demand=busData(:,3);  
% generation nodes and values
generation=casedata.gen(:,1:2);        

% obtaining power injection matrix excluding the slack node
powerInjTemp=demand*(-1);
for i=1:size(generation,1)            
    
    temp=generation(i,:);
    tempBus=temp(1);
    tempGen=temp(2);
    powerInjTemp(tempBus)=powerInjTemp(tempBus)+tempGen;
     
end

powerInjReduced=powerInjTemp;
% Reduced power injection vector excluding slack node. (-) loads, (+) generations
powerInjReduced(slack,:)=[];            

slackPower=(-1)*sum(powerInjReduced) + demand(slack);
powerInj=powerInjTemp;
% Full power injection vector including slack node generation/withdrawal
powerInj(slack)=slackPower;             