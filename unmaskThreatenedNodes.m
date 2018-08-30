function [ unmaskedIndexThreat ] = unmaskThreatenedNodes( indexThreat, mask )
%UnMask the threatened nodes so they correspond to the main island ordering
%externally

%Find rows that contain threatened nodes as original values    
unmaskedIndexThreat = zeros(size(indexThreat,1),1);

for i = 1 : size(indexThreat,1),
    unmaskedIndexThreat(i) = mask(indexThreat(i),1);
end

end