function [impMatrixDC]= MakeImpedanceMatrixDC(casedata)
% This m-file is usd to compute the impedance matrix for a DC load flow analysis from a given casedata.

[admMatrixDC]= MakeAdmittanceMatrixDC(casedata);

impMatrixDC=inv(admMatrixDC);