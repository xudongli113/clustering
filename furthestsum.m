function C = furthestsum(X,k)
[~,col] = size(X);
init=zeros(1,col);

C = zeros(k,col);
Ctemp=[];
for i = 1:k
    if i==1
        [idx,p] = pick(init,X);
    else
        [idx,p] = pick(Ctemp,X);
    end  
    
    C(i,:) = p;
    Ctemp = [Ctemp;p];
    X(idx,:) = [];
end
end

function [idx,P] = pick(A,B)
D = pdist2(A,B);
Dsum = sum(D,1);
[~,idx] = max(Dsum);
P=B(idx,:); 
end