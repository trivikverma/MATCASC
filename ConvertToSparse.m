% Description: Function 'ConvertToSparse' converts a flow matrix (which is a directed matrix)
%                       into a (number of lines)*3 matrix. Column of the convertedFlowMatrix are
%                       (1) Node-from, (2) Node-to and (3) flow value in the line.

%              Input    flowMatrix: A matrix of a grid represenring the
%                       flow values in each line.
%                       capMatrix: Capacity matrix of a grid, which is
%                       computed based on flowMatrix. For additional information see  
%                       'A robustness metric for cascading failures by targeted attacks in power networks' by Ko? et al. 
%              Output   cap: Line capacity values
%                       convertedFlowMatrix: (number of lines)*3 matrix containing line ID's
%                       (column 1 and 2) and max capacity values of these lines.               


function [convertedFlowMatrix, cap]=ConvertToSparse(flowMatrix, capMatrix)

[row column flow]=find(flowMatrix);
[~, ~, cap] = find(capMatrix);

convertedFlowMatrix=[row column flow];



