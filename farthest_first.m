function P = farthest_first(A,B)
% Compute square Euclidean or Mahalanobis distances between all pair of vectors.
%   A: d x n1 data matrix
%   B: d x n2 data matrix
%   M: d x d  Mahalanobis matrix
%   D: n1 x n2 pairwise square distance matrix
% Written by Michael Chen (sth4nth@gmail.com).
assert(size(A,1)==size(B,1));
P = bsxfun(@plus,full(dot(B,B,1)),full(dot(A,A,1))')-full(2*(A'*B));
end