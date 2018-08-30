function [admMatrixDC]= MakeAdmittanceMatrixDC(casedata)
% This m-file is usd to compute the admittance matrix for a DC load flow analysis from a given casedata.


% Extract branch information
branchData=casedata.branch;

% Reactance values togerher with line ID's
lineImp=[branchData(:,1:2) branchData(:,4)];
admMin=1./lineImp(:,3);
lineAdm=lineImp;
lineAdm(:,3)=-admMin;
sparseForm=spconvert(lineAdm);
upperB=full(sparseForm);


dupperB=size(upperB,2)-size(upperB,1);         % Making upperB square by adding zeros 
ZerosupperB=zeros(dupperB, size(upperB,2));
upperB=[upperB;ZerosupperB]; 

upperLowerB=upperB+upperB';
diagB=diag(-sum(upperLowerB));

admMatrixDC=diagB+upperLowerB;
