% Description: Function 'GetActiveLinks' determines the active lines in a network after
%                       cascading failures happened. Active line means a line which is not
%                       overloaded and not isolated/disconnected from a generator. For additional information see  
%                       'A robustness metric for cascading failures by targeted attacks in power networks' by Ko? et al. 

%              Input    flowStageResult: structure of the original grid
%                       after cascading failures happened together with islanding info, flow values and outaged 
%                       components in the grid.
%              Output   activeLinks: ID of still active links.  


function [activeLinks] = GetActiveLinks(flowStageResult)

[IDOfLastStages] = size(flowStageResult,2);
% Active(i.e. not-overloaded and not-deadlyisolated) lines
activeLinks = [];
    
% Several islands in the last stage
[numberOfIslandsInStage] = size(flowStageResult{1,IDOfLastStages},2);
        
        %Sevaral islands
        for j = 1 : numberOfIslandsInStage,
            
            % total generation capacity in the island
            generationInIsland=...
                sum(flowStageResult{1,IDOfLastStages}(j).island.gen(:,2));
            % branches in the island. Branch ID's are the original ID's (from original grid)
            branchesInIsland=...
                flowStageResult{1,IDOfLastStages}(j).island.order.ext.branch(:,1:2);
            
            % Still generation in the island?
            if generationInIsland ~= 0
                % If so, lines in the island are dead
                activeLinks =[activeLinks; branchesInIsland ]; 
            end
            
        end