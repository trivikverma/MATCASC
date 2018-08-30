% Description: Function 'ComputePhaseAngles' computes the voltage phase angles at each node in the network. 
%                       Voltage phase angles are in DC load flow analysis. 

%              Input    powerInjReduced: Reduced power injection matrix. Slack entry is removed from power injection matrix  
%                       BdcReduced: Reduced admittance matrix for the grid. Slack entry is removed from system admittance matrix
%                       Slack: ID of slack node.
%              Output   phaseAngles: Voltage phase angles at each node.
%                       phaseAnglesReduced: Reduced phaseAngles vector. Slack entry is removed from phaseAngles vector.



function [phaseAngles, phaseAnglesReduced]= ComputePhaseAngles(powerInjReduced, BdcReduced, slack)


% Reduced phase angles excluding the slack
phaseAnglesReduced=inv(BdcReduced)*powerInjReduced;    

if slack==1
    phaseAngles=[0;phaseAnglesReduced];
else
    % Complete phase angles including slack node
    phaseAngles=[phaseAnglesReduced(1:(slack-1));0;phaseAnglesReduced(slack:size(phaseAnglesReduced,1))];   
    
end