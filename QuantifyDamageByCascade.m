function [linkSurvivability, capacitySurvivability, demandSurvivability] = QuantifyDamageByCascade(casedata, alpha, removalStrategy)

% This m-file is used to quantify the damage by cascading falures in the
% terms of the fractions of survived links, total capacity of the survived links, and satisified power demand. 

[flowStageResult] = SimCascFailures(casedata, alpha, removalStrategy);

[linkSurvivability] = GetLinkSurvivability(flowStageResult);
[capacitySurvivability] = GetCapacitySurvivability(flowStageResult, alpha);
[demandSurvivability] = GetDemandSurvivability(flowStageResult);

