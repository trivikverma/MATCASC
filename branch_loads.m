function [ branchLoad ] = branch_loads( island )
%Extract branch loads and rectify links based on the load direction
define_constants;

%Extraction of loads from the island
branchLoad = island.branch(:,F_BUS);
branchLoad(:,2) = island.branch(:,T_BUS);
branchLoad(:,3) = island.branch(:,PF);
%All links are active in the start
branchLoad(:,4) = 1;

end

