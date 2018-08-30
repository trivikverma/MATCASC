function [overloaded, lineToBeTripped] = OverloadCheck(flowMatrix, capacityMatrix)

o = flowMatrix > capacityMatrix;                          % Check whether any line is overloaded   

[row, col] = find(o);  % Locate the first overloaded line (find fnction in matlab starts checking the elements from element (1,1) and goes as (2,1), (3,1),.., (n,1), (1,2), (2,2),.., (n,2). 
                                        % This is not what we want. We want that matlab does counting from left to right and starts with first row, continues with second, thirth, so forth. Thats why, we transpose o.
                                        % Since we transposed o, row and the columns are reversed as well.)

                                        
lineToBeTripped = [row, col];                 % Indices of line-to-be-tripped

if size(lineToBeTripped,1)==0                   % if no further line overloaded, we are done
    overloaded=0;
else
    overloaded=1;
end