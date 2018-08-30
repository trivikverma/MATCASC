function [BdcUpdated]=UpdateBdc(Bdc, lineThreat)
% This m-file is used to update the admittance matrix of a network when
% lineThreat is removed from the topology. Note that the tripped line is
% not removed from the topology but its admittance value is set to zero so that it does not
% carry any power anymore.



BdcTemp=Bdc;

row=lineThreat(1); 
column=lineThreat(2);


BdcTemp(row, column)=0;
BdcTemp(row,row)=Bdc(row,row)+Bdc(row, column);


BdcTemp(column, row)=0;
BdcTemp(column,column)=Bdc(column,column)+Bdc(column, row);

BdcUpdated=BdcTemp;
