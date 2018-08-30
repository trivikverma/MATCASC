% Description: Function  'GetLinkSurvivability' computes the fraction of the 
%                        not-overloaded/not-tripped lines in a grid during
%                        cascading failures.

%              Input     flowStageResult: structure of the original grid
%                        after cascading failures happened together with islanding info, flow values  
%                        and outaged components in the grid.
%                       
%              Output    linkSurvivability: Fraction of the survived transmission 
%                        lines in the grid. For additional information, see
%                        'A robustness metric for cascading failures by targeted attacks in power networks' by Ko? et al.


function [linkSurvivability] = GetLinkSurvivability(flowStageResult)

% This m-file is used to determine the fraction of
% not-overloaded/not-tripped lines in a grid during cascading failures.
% GIVE REFERENCE FOR LinkSurvivability METRIC!!!

% % Initial flow matrix
% flowMatrixInitial = flowStageResult{1,1}.flowMatrix;                       
% % Initial number of lines
% nInitialLinks = nnz(flowMatrixInitial); 

% Initial flow matrix
initialLinks = flowStageResult{1,1}.island.order.ext.branch(:,1:2);                       
% Initial number of lines
nInitialLinks = size(initialLinks,1); 

% Survived lines (Active lines)
 [activeLinks] = GetActiveLinks(flowStageResult);
% Number of survived lines (Active lines)
nActiveLinks = size(activeLinks,1);           

% Fraction of not-overloaded/not-tripped lines
linkSurvivability = nActiveLinks/nInitialLinks;    





       
        
  

