%Description : Function 'RandomRemoval' randomly selects a line from the
%              network and marks it under threat as a trigger for cascading
%              failure in the network

function [ nodeI, nodeJ ] = RandomRemoval( flowMatrix )

%Select a node from the network using a random removal strategy
elements = find(flowMatrix);
[r, ~] = size(elements);
indexIntoArray = randi(r);
%Line to be removed is between nodeI and nodeJ in I----->J direction
index = elements(indexIntoArray);
[nodeI, nodeJ] = ind2sub(size(flowMatrix), index);

%Function Ends
end

