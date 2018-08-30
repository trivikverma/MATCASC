%Description : Function 'TargetedRemoval' selects a line based on the
%              highest load from the network and marks it as a trigger for
%              cascding failure in the network

function [ nodeI, nodeJ ] = TargetedRemoval( loadMatrix )

%Select the highest load node
indexIntoArray = find(loadMatrix == max(max(loadMatrix)));
%Line to be removed is between nodeI and nodeJ in that direction
[nodeI, nodeJ] = ind2sub(size(loadMatrix), indexIntoArray);

%Function Ends
end
