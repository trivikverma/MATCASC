% Description: Function  'GetLinesOutOfService' determines the tripped lines after 
%                        cascading failures happened.
%                        

%              Input     flowStageResult: structure of the original grid
%                        after cascading failures happened together with islanding info, flow values  
%                        and outaged components in the grid.
%                        
%              Output    linesOutOfService: The list of the outaged
%              transmission lines as a result of the cascading effect in
%              the grid. It also includes the triggering outage.


function [linesOutOfService] = GetLinesOutOfService(flowStageResult)

linesOutOfService=[];
% go until (size(flowStageResult,2)-1) because last stage is empty
for i=1:(size(flowStageResult,2)-1)  
    
    tempStage=flowStageResult{i};
    for j=1:size(tempStage,2)
        tempLineThreat=tempStage(j).lineThreat;
        linesOutOfService=[linesOutOfService; tempLineThreat];   
    
    end     
    
end