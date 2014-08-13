function [IDX] = seedallapp(data,k,centroid)
data_dim = length(data(1,:));
nbData   = length(data(:,1));

%% contriod update-seed one approach
% each time the contriosd of each cluster is given a new data
% update the contriod immediately 
D = repmat(NaN,n,k);   % point-to-cluster distances
Del = repmat(NaN,n,k); % reassignment criterion
m = zeros(k,1);
% no stopping at start
pos_diff = 1.;
while pos_diff > 0.0
%     assign data to all clusters
    assignment = [];
    % assign each datapoint to the closest centroid
    for d = 1 : length( data(:, 1) );
        min_diff = ( data( d, :) - centroid( 1,:) );
        min_diff = min_diff * min_diff';
        curAssignment = 1;
        for c = 2 : nbCluster;
            diff2c = ( data( d, :) - centroid( c,:) );
            diff2c = diff2c * diff2c';
            if( min_diff >= diff2c)
                curAssignment = c;
                min_diff = diff2c;
            end
        end
        % assign the d-th dataPoint
        assignment = [ assignment; curAssignment];
    end
    
    % for the stoppingCriterion
    oldPositions = centroid;  
    
end
