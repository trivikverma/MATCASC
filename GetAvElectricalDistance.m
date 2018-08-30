function [avElectricalDistanceImpBased, avElectricalDistanceAdmBased]= GetAvElectricalDistance(casedata)

% Obtain impedance matrix for the casedata
[impMatrixDC]= MakeImpedanceMatrixDC(casedata);
% Electrical distances between any node in the grid
elcDistancesImp=triu(impMatrixDC,1);
% Average electrical distance of the grid. For a electrical grid topology, this is equivalent to
% characteristic path length of a normal topology.
avElectricalDistanceImpBased=sum(sum(elcDistancesImp))/nnz(elcDistancesImp);


[admMatrixDC]= MakeAdmittanceMatrixDC(casedata);
elcDistancesAdm=triu(admMatrixDC,1);
avElectricalDistanceAdmBased=-sum(sum(elcDistancesAdm))/nnz(elcDistancesAdm);