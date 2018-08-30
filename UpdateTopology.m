function [mpcNew]=UpdateTopology(mpc, lineThreat)
% This m-file is used to uodate a topology. The inputted line(lineThreat)
% will be removed from casedata(mpc). mpcNew gives the updated
% configuration.


define_constants;
%FInd lines in the branch table
lines = mpc.branch(:,1:2);
mpcTemp = mpc;

%For each line in the threat table
for i = 1 : size(lineThreat,1),
    
    lineToBeRemoved = lineThreat(i,:);
    fromNode = lineThreat(i,1);
    toNode = lineThreat(i,2);

    [~,IDX] = ismember(lines, lineToBeRemoved, 'rows');      % Find the line to be removed
    B=any(IDX);                                             % Test parameter
    
    if B == 1
        [row,~] = find(IDX);                                % Determine the row number of line to be removed
        mpcTemp.branch(row,BR_STATUS)=0;                            % Delete the associated row from casedata
    else
        lineToBeRemoved = [lineToBeRemoved(2) lineToBeRemoved(1)];
        [~,IDX] = ismember(lines, lineToBeRemoved, 'rows');
        [row,~] = find(IDX);
        mpcTemp.branch(row,BR_STATUS)=0;                            % Delete the associated row from casedata
    end
    
end

for i = 1 : size(lineThreat,1),

    %Branches with from node in it that are still alive
    [fromNode1, ~] = size(find(mpcTemp.branch(:,BR_STATUS) == 1 & mpcTemp.branch(:,1) == fromNode));
    [fromNode2, ~] = size(find(mpcTemp.branch(:,BR_STATUS) == 1 & mpcTemp.branch(:,2) == fromNode));
    %If no such branch exists
    if(fromNode1 + fromNode2 == 0)
        %Isolate node
        mpcTemp.bus(fromNode,BUS_TYPE) = 4;
    end
    %Branches with to node in it that are still alive
    [toNode1, ~] = size(find(mpcTemp.branch(:,BR_STATUS) == 1 & mpcTemp.branch(:,1) == toNode));
    [toNode2, ~] = size(find(mpcTemp.branch(:,BR_STATUS) == 1 & mpcTemp.branch(:,2) == toNode));
    %If no such branch exists
    if(toNode1 + toNode2 == 0)
        %Isolate node
        mpcTemp.bus(toNode,BUS_TYPE) = 4;
    end
    mpcNew=mpcTemp;
    
end

end


