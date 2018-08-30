function [BdcReduced, slack]= MakeBdcReduced(Bdc, busData)
% This m-file is used to obtain reduced admittance matrix, that is used in
% DC load flow computation

%Node 1 is always slack node 
slack = 1;

BdcReduced=Bdc;
BdcReduced(slack,:)=[];
BdcReduced(:,slack)=[];