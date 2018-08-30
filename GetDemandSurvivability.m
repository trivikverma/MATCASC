% Description: Function  'GetDemandSurvivability' computes the fraction of the 
%                        satisified demand in the grid after cascading failures
%                        happened.

%              Input     flowStageResult: structure of the original grid
%                        after cascading failures happened together with islanding info, flow values  
%                        and outaged components in the grid.
%                        
%              Output    demandSurvivability: Fraction of the satisified power demand 
%                        in the grid. For additional information, see
%                        'A robustness metric for cascading failures by targeted attacks in power networks' by Ko? et al.


function [demandSurvivability] = GetDemandSurvivability(flowStageResult)

[powerSatisfiedPerStage, ~] = GetPowerLossPerStage(flowStageResult);
lastStage = size(powerSatisfiedPerStage,2);

% Fraction of satisified power
demandSurvivability = powerSatisfiedPerStage(1, lastStage);