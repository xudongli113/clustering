file = struct;
file.patch = 'D:\Documents\MATLAB\xudong\Clustering\data\';
file.name = 'matrix_data.csv';

fn = [file.patch,file.name];
if ~exist(fn,'file')
   error('cannot find calendar file');
end

data = struct;
data.table = readtable(fn);
% N*113 cell
data.name = data.table.Properties.VariableNames;
[rows, cols] = size(data.table);
data.info = table2cell(data.table(:,1:5));
data.volume = table2array( data.table(:,6:cols));

%data reprocessing
data.volume(:,end-1:end)=0;
% convert volume to density
for i = 1:rows
    data.volume(i,:) = data.volume(i,:)/sum(nonzeros(data.volume(i,:)));
end

save 'index_volume'



