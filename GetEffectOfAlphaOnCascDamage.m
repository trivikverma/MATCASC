function [LS, CS, DS] = GetEffectOfAlphaOnCascDamage(casedata, removalStrategy, Alpha)
% Thid m-file is used to see the effect of alpha parameter on cascading
% failures damage.

% Input:    Alpha: A row vector containing alpha values, that will be
%                  inputted to QuantifyDamageByCascade.m.
% Output:   LS,CS,DS: Coulmn vectors containing linkSurvivability,
%                  capacitySurvivability and demandSurvivability values 
%                  for each alpha value.

% Initialize
LS = [];
CS = [];
DS = [];

% for each alpha value
for i=1:size(Alpha,2)

    tempAlpha=Alpha(i);
    % Quantify the damage
    [linkSurvivability, capacitySurvivability, demandSurvivability] = QuantifyDamageByCascade(casedata, tempAlpha, removalStrategy);
    
    LS=[LS; linkSurvivability];
    CS=[CS; capacitySurvivability];
    DS=[DS; demandSurvivability];

end

% function ends
end

