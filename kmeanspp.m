function [C,ind] = kmeanspp(M,k)
[C, ind] = spreadseeds(M, k);
end

function D = sqrdistance(A, B)
% Square Euclidean distances between all sample pairs
% A:  n1 x d data matrix
% B:  n2 x d data matrix
% WB: n2 x 1 weights for matrix B
% D: n2 x n1 pairwise square distance matrix
%    D(i,j) is the squared distance between A(i,:) and B(j,:)
% Written by Michael Chen (sth4nth@gmail.com). July 2009.
n1 = size(A,1); n2 = size(B,2);
m = (sum(A,1)+sum(B,1))/(n1+n2);
A = bsxfun(@minus,A,m);
B = bsxfun(@minus,B,m);
D = full((-2)*(A*B'));
D = bsxfun(@plus,D,full(sum(B.^2,2))');
D = bsxfun(@plus,D,full(sum(A.^2,2)))';
end

function [S, index] = spreadseeds(X, k)

[n,d] = size(X);
index = zeros(k,1);
S = zeros(k,d);
D = inf(n,1);
index(1) = ceil(n.*rand);

S(1,:) = X(index(1),:);

for i = 2:k
    D = min(D,sqrdistance(S(i-1,:),X));
    index(i) = find(cumsum(D)/sum(D)>rand,1);
    S(i,:) = X(index(i),:);
end
end