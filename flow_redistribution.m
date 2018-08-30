%Author      : Trivik Verma
%Description : Function 'flow_redistribution' calculates the dynamic
%              efficiencies in case of a random failure or targeted attack
%              and redirects flows in turn to observe the cascading effects
%              using PTDFs

function [ nodeRemoved, flowStageResult ] = flow_redistribution( adjacencyMatrix,...
    mpcTemp, alpha, nodeMetric )

currentSetOfIslands = mpcTemp;
define_constants;
warning off all;

%Flow results for islands at every stage of the flow
flowStageResult = cell(2,numberOfRedistributionPhases); 
% Row 1 is set of islands at each stage
% Row 2 is buses under threat at each stage

%% Initial Internal ordering
[~, numberOfIslands] = size(currentSetOfIslands);
%Convert the ordering of each island to internal format
for k = 1 : numberOfIslands,
    currentSetOfIslands(k).island = ext2int(currentSetOfIslands(k).island);
    
    %Starting computations from the island configuration
    nodeGenSlashLoad = gen_load(currentSetOfIslands(k).island);
    initialBranchLoad = branch_loads(currentSetOfIslands(k).island);
    
    %Initial Node Load configuration
    initialNodeLoad = nodeLoad(nodeGenSlashLoad, initialBranchLoad);
    
    %Initialisations
    currentSetOfIslands(k).nodeGenSlashLoad = nodeGenSlashLoad;
    currentSetOfIslands(k).oldBranchLoad = initialBranchLoad;
    currentSetOfIslands(k).initialNodeLoad = initialNodeLoad;
    currentSetOfIslands(k).capacityVector = capacityVector;
end


%% Attack Strategy


%% Redistribution of Loads
for z = 1 : numberOfRedistributionPhases,
    
    % Start of each flow redistribution round
    
    [~, numberOfIslands] = size(currentSetOfIslands);
    %Clear use of temp struct
    clear intermediateSetOfIslands;
    intermediateSetOfIslands(1) = currentSetOfIslands(1); %Dummy value
    intermediateSetOfIslands(1).nodeOvershotPercentage = 0; %Dummy value for non existent field
    %Clear use of temp vector
    intermediateThreat = zeros(1,1);
   
    %For each Island
    for k = 1 : numberOfIslands,
       
        [nextSetOfIslands, nextIndexThreat, islandStatus] =...
            distribute_flow(currentSetOfIslands(k), lineThreatThreat);
        
        %If previous island was disconnected then continue with the next
        %one in line
        if islandStatus == -1
            continue
        end
        
        %Combine all indexThreats and nextSetOfIslands from one redistribution phase
        intermediateSetOfIslands = [intermediateSetOfIslands nextSetOfIslands];
        intermediateThreat = union(intermediateThreat, nextIndexThreat);
        
    end
    
    %Deleting dummy
    intermediateSetOfIslands(1) = [];
    intermediateThreat(1) = [];
    
    %For next phase
    currentSetOfIslands = intermediateSetOfIslands;
    intermediateThreat = sort(intermediateThreat);
    indexThreat = intermediateThreat;  
    
    flowStageResult{1,z} = currentSetOfIslands; %End of each round
    flowStageResult{2,z} = indexThreat; %End of each round

end

%Function Ends
end