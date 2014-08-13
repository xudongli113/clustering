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