%Description : Function 'GetLineThreat' marks a line of the network that is
%              under threat and will act as a trigger for cascading
%              failure in the network

function [ linesUnderThreat ] = GetLineThreat( flowMatrix, removalStrategy )

%% Attack Strategy

%Attack strategy for line removal 
%Random removal - (option 0)
%Load based removal - (option 1,2 extendable)

%Line metric used to remove lines
%1 - Betweenness Centrality
%2 - Electrical Node Significance
%..................................Extend code
%0 - Random removal

%% Remove a line using a carefully desined removal strategy
    %Betweennes Centrality
    if(removalStrategy == 1)
        normalisedBetweennessCentralityMatrix = BetweennessCentralityEdge(flowMatrix);
        [nodeI, nodeJ] = TargetedRemoval(normalisedBetweennessCentralityMatrix);
    %Node Significance
    elseif(removalStrategy == 2)
        %1 dimension vector for node significanc of nodes
        nodeSignificanceVector = ElectricalNodeSignificance(flowMatrix);
        %Node with the highest node significance is 'node'
        [node, ~] = TargetedRemoval(nodeSignificanceVector);
        nodeI = node;
        %The node receiving the most outgoing power from node 'nodeI' is
        %'nodej'
        [~, nodeJ] = max(flowMatrix(node,:));
    %....................................Extend code
    %Random removal
    elseif(removalStrategy == 0)
        [nodeI, nodeJ] = RandomRemoval(flowMatrix);
    end

%Lines to be removed as a trigger for cascading failure
%   Example
%   Col1(FromNode)           Col2(ToNode)
%   1               --->     7
%   2               --->     4
%   6               --->     1
linesUnderThreat = nodeI;
linesUnderThreat(:,2) = nodeJ';

%Function ends
end