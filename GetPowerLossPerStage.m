function [ powerSatisfiedPerStage, powerLossPerStage ] = GetPowerLossPerStage(flowStageResult)

% This m-file is used to monitor the damage in the terms of not-served
% power during the progress of cascading effect. Fraction of satisified power at each 
% cascade stage is given by powerSatisfiedPerStage while powerLossPerStage 
% gives the power loss at each stage.  

powerLossPerStage = zeros(1, size(flowStageResult,2)); 
powerSatisfiedPerStage = zeros(1, size(flowStageResult,2)); 

%Demand to be matched in the original grid
totalDemand = sum(flowStageResult{1,1}.island.bus(:,3));


    %Number of stages
    [numberOfRedistributionStages] = size(flowStageResult,2);

    %Several stages
    for i = 1 : numberOfRedistributionStages,

        %Initialise
%         supplyPerStage = 0;
%         demandPerStage=0;
        
        powerSatisfiedInStage=0;

        [numberOfIslandsPerStage] = size(flowStageResult{1,i},2);
        %Sevaral islands
        for j = 1 : numberOfIslandsPerStage,
            
            supplyPerIsland=sum(flowStageResult{1,i}(j).island.gen(:,2));
            demandPerIsland=sum(flowStageResult{1,i}(j).island.bus(:,3));
            
            powerSatisfiedPerIsland = 0;
            if supplyPerIsland < demandPerIsland
                
                % Load shedding in island
                powerSatisfiedPerIsland = supplyPerIsland; 
            else
                
                % No need for load shedding
                powerSatisfiedPerIsland = demandPerIsland; 
            end
            
            powerSatisfiedInStage = powerSatisfiedInStage + powerSatisfiedPerIsland;
           
            
%             %Get the real node IDS unmasked
%             supplyPerStage = supplyPerStage + sum(flowStageResult{1,i}(j).island.gen(:,2));
%             demandPerStage = demandPerStage + sum(flowStageResult{1,i}(j).island.bus(:,3));

        end
        
        
        powerSatisfiedPerStage(1,i)=(powerSatisfiedInStage / totalDemand);
        powerLossPerStage(1,i) = 1 - (powerSatisfiedInStage / totalDemand);
       
        
    end
     

end

