%Description : Function 'ElectricalNodeSignificance' calculates the
%              outgoing electrical power from each node of the network

function [ nodeSignificanceVector ] = ElectricalNodeSignificance( flowMatrix )

%Outgoing Power of each node corresponds to its node significance
nodeSignificanceVector = sum(flowMatrix, 2);

%Function ends
end