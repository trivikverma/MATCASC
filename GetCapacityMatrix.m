% Description: Function  'GetCapacityMatrix' computes the Capacity matrix of a network. Capacity
%                         values in the matrix incorporate also the alpha values. At the moment we
%                         assume that each link in the network has the same tolerabilance parameter(alpha).
%                         In case each link has the different tolerability values, some futher modification 
%                         have to be done to the m file.

%               Input    flowMatrix: Flow matrix of the grid configuration
%                        alpha: Network tolerance parameter. C_i=L_i(1+alpha_i).
%                        For additional information see:  
%                        'A robustness metric for cascading failures by targeted attacks in power networks' 
%                        by Ko? et al.
%               Output   capMatrixSymmetric: The symmetric capacity matrix containing the line max capacity
%                        values at each entry, e.g. C12 is the capacity of transmission line connection nodes 1 and 2. 


function [capMatrixSymmetric] = GetCapacityMatrix(flowMatrix, alpha)

% Generating Alpha matrix
O=ones(size(flowMatrix,1),size(flowMatrix,1));
% Alpha matrix contains alpha values.
Alpha=O*alpha;                  


%% Obtaining capacity matrix C
capMatrix = flowMatrix.*Alpha;
capMatrixSymmetric = capMatrix + capMatrix';