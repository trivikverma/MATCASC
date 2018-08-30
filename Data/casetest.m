function mpc = casetest
%

%% MATPOWER Case Format : Version 2
mpc.version = '2';

%%-----  Power Flow Data  -----%%
%% system MVA base
mpc.baseMVA = 100;

%% bus data
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
mpc.bus = [
	1	3	0	0   	0	0	1	1	0	230	1	1.1	0.9;
	2	1	100	0   	0	0	1	1	0	230	1	1.1	0.9;
	%3	1	0	0       0	0	1	1	0	230	1	1.1	0.9;
    %4	1	0	0   	0	0	1	1	0	230	1	1.1	0.9;
    %5	1	0	0   	0	0	1	1	0	230	1	1.1	0.9;
    %6	1	200	0   	0	0	1	1	0	230	1	1.1	0.9;
];

%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
mpc.gen = [
	%4	318	0	100	-100	1.02	100	1	318	0	0	0	0	0	0	0	0	0	0	0	0;
	1	0	0	100	-100	1	100	1	0	0	0	0	0	0	0	0	0	0	0	0	0;
];

%% branch data
%	fbus	tbus	r	x	b	rateA	rateB	rateC	ratio	angle	status	angmin	angmax
mpc.branch = [
	1	2	0   	0.250	0   	0	0	0	0	0	1	-360	360;
	%1	3	0.01008	0.050	0.1025	250	250	250	0	0	1	-360	360;
    %1	4	0.01008	0.050	0.1025	250	250	250	0	0	1	-360	360;
    %2	4	0.01008	0.050	0.1025	250	250	250	0	0	1	-360	360;
    %2	5	0.01008	0.050	0.1025	250	250	250	0	0	1	-360	360;
    %3	4	0.01008	0.050	0.1025	250	250	250	0	0	1	-360	360;
    %3	5	0.01008	0.050	0.1025	250	250	250	0	0	1	-360	360;
    %4	6	0.01008	0.050	0.1025	250	250	250	0	0	1	-360	360;% virtual link
    %5	6	0.01008	0.050	0.1025	250	250	250	0	0	1	-360	360;% virtual link
];
