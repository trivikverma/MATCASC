% Description: Function  'GetCapacitySurvivability' computes the fraction of the 
%                        capacity of the remaining transmission lines aftre cascading failures
%                        happened.

%              Input     flowStageResult: structure of the original grid
%                        after cascading failures happened together with islanding info, flow values  
%                        and outaged components in the grid.
%                        alpha: Network tolerance parameter. C_i=L_i(1+alpha_i).
%              Output    capacitySurvivability: Fraction of the capacity of the survived transmission 
%                        lines in the grid. For additional information, see
%                        'A robustness metric for cascading failures by targeted attacks in power networks' by Ko? et al.


function [capacitySurvivability] = GetCapacitySurvivability(flowStageResult, alpha)

% This m-file is used to deterimine the fraction of the 
% capacity of the remaining transmission lines to carry power flow. GIVE
% REFERENCE FOR CAPACITYSURVIVABILITYY METRIC!!!


flowMatrixInitial = flowStageResult{1,1}.flowMatrix;                        % Initial flow matrix
% triggerOutage = flowStageResult{1,1}.lineThreat;                            % Initial outage


[capMatrix] = GetCapacityMatrix(flowMatrixInitial, alpha);  % Capacity matrix
totalCapacity = sum(sum(capMatrix))/2;                        % Total capacity of initial grid

[activeLinks] = GetActiveLinks(flowStageResult);

%% Compute survived capacity, i.e. sum of the capacities of active lines
% Total capacity of survived lines
survivedCapacity = 0;
for i=1:size(activeLinks,1)
   
    tempLine = activeLinks(i,:);
    tempCap = capMatrix(tempLine(1),tempLine(2));
    survivedCapacity = survivedCapacity+tempCap;
    
end

%% compute the capacitySurvivability

capacitySurvivability = survivedCapacity/totalCapacity;   % Fraction of survived capacity


