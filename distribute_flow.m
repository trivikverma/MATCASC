function [ nextSetOfIslands, islandStatus ] =...
    distribute_flow(currentIsland)

define_constants;

    %% Extraction of information 
    %Extract island parameters to start distribution of flow
    %Internal formatting of island
    islandInt = currentIsland.island;
    capacityMatrix = currentIsland.capacityMatrix;
    lineThreat = currentIsland.lineThreat;
        
    %% Masking for internal external conversion 
    %Mask the real nodes under threat as corresponding numbers in the
    %secondary island
    maskParent = islandInt.order.bus.i2e;
    lineThreat(:,1) = maskThreatenedNodes(lineThreat(:,1), maskParent);
    lineThreat(:,2) = maskThreatenedNodes(lineThreat(:,2), maskParent);
    %Now we have the line threat in internal format
    
    %% Update Topology
    %Make branch under threat and isolated buses as out-of-service
    [islandIntUpdated] = UpdateTopology(islandInt, lineThreat);
    
    %% Islanding
    %Find Islands in 'groups' as bus numbers and in 'isolatedNodes' as
    %isolated individual nodes
    islandExt = int2ext(islandIntUpdated);
    [groups, ~, islandStatus] = find_islands(islandExt);
    %Extract all the islands as individual mpc structs
    islands = extract_islands(islandExt, groups);
    [~, numberOfIslands] = size(islands);
    
    %% If the island is still connected, proceed
    if islandStatus ~= -1
        %Calculate Flow Matrix for each Island
        nextSetOfIslands(numberOfIslands).island = islandInt; %Dummy value
        itr = 1;
        for l = 1 : numberOfIslands, 

            %Filter islands that cannot sustain themselves
            if( ~isempty(islands{l}.gen) )
                
                %Convert island to internal format for Flow matrix calculation
                islandTemp = ext2int(islands{l});
                
                %Mask
                maskChild = islandTemp.order.bus.i2e;
                
                %Extract Capacity from Parent Island 
                intNodes = maskThreatenedNodes(islands{l}.bus(:,1),maskParent);
                capacityMatrixNew = capacityMatrix(intNodes,intNodes);
                
                %Dispatch Power
                [flowMatrixNew, ~, ~, ~, ~] = PerformDcLoadFlowAnalysis(islandTemp);
                
                %Overload Check
                [overloaded, lineThreat] = OverloadCheck(flowMatrixNew, capacityMatrixNew);

                %Unmask threatened nodes of a secondary island to get real node IDS in
                %the main island
                lineThreat(:,1) = unmaskThreatenedNodes(lineThreat(:,1), maskChild);
                lineThreat(:,2) = unmaskThreatenedNodes(lineThreat(:,2), maskChild);

                %Put info about island back to the island struct for
                %next iteration in the tree
                nextSetOfIslands(itr).island = islandTemp;
                nextSetOfIslands(itr).flowMatrix = flowMatrixNew;
                nextSetOfIslands(itr).capacityMatrix = capacityMatrixNew;
                nextSetOfIslands(itr).lineThreat = lineThreat;
                nextSetOfIslands(itr).overloaded = overloaded;

                itr = itr + 1;
            else
                numberOfIslands = numberOfIslands - 1;
            end
        end
        nextSetOfIslands = nextSetOfIslands(1:numberOfIslands);

        %No child islands exist with sustaining capacity
        if numberOfIslands == 0
            islandStatus = -1;
            % Island overloaded but no child has generation capacity
            currentIsland.overloaded = 3;
            nextSetOfIslands = currentIsland;
        end

        %If island is not sustainable (complete disconnection)
    else
        nextSetOfIslands(1) = currentIsland; 
        nextSetOfIslands(1).overloaded = 2; %Island intact, but further will be completely disconnected
        nextSetOfIslands(1).lineThreat = [];
        nextSetOfIslands = nextSetOfIslands(1:1);

    end
    
end

