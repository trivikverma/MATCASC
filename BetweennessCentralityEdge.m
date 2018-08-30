%Description : Function 'BetweennessCentralityEdge' calculates the number of
%              shortest paths that flow through every edge (normalised by 
%              the total number of shortest paths in a completely connected
%              network)

function [ normalisedBetweennessCentralityMatrix ] = BetweennessCentralityEdge( flowMatrix )

%Size of the network
[numberOfNodes, ~] = size(flowMatrix);

%Creating adjacency matrix for topological betweenness
flowMatrix(flowMatrix > 0) = 1;
% Example
%    1 0 1
%    0 1 0
%    1 1 1
% 1 - Link present
% 0 - Link absent
%Goal is to minimize the distance between any two nodes

%Sparse matrix to calculate betweenness
adjacencyMatrix = sparse(flowMatrix);
%Betweenness Centrality for edges is stored in E
[~, E] = betweenness_centrality(adjacencyMatrix);

%Convert sparse matrix E to a full matrix for centrality of each edge
betweennessCentralityMatrix = full(E);

%Normalising with the total number of shortest paths that exist in the
%graph
normalisationFactor = numberOfNodes * (numberOfNodes - 1) / 2;
normalisedBetweennessCentralityMatrix = betweennessCentralityMatrix ./ normalisationFactor;

%Function Ends
end

