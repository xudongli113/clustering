filename = 'finaldata.xlsx';
nameSheet = 'Sheet2';
volumeSheet='Sheet1';
startrow = 'A2';

nameRange = 'A:A';
[numb,NameInfo] = xlsread(filename,nameSheet,nameRange);


stockNames = NameInfo(1:end,:);

%format matrix data
totalStock = 100;
columnFirstIndex = 65;
columnSecondIndex = 65;
timebin = 5;
opentime=8/24;
closetime=17/24;
volumnvec=[];
keyvec=[];
dataMatrix = [];
%    construct new matrix
%    column time bin vector
index = 0;
temptime=opentime;
while temptime<=closetime
    volumnvec =[volumnvec, datestr(temptime,'HH:MM:SS')];
    % increase 5 mins
    temptime=temptime+5/(24*60);
end
%    row stock RIC and date key pair

for j=1:1
   index = idivide(int32(j-1),13);
   if index ==0
       stockRange = [char(columnSecondIndex) ':' char(columnSecondIndex+1)];
   elseif index > 0
       stockRange = [char(columnFirstIndex+index-1) char(columnSecondIndex) ':' char(columnFirstIndex+index-1) char(columnSecondIndex+1)];
       
   end
   columnSecondIndex = columnSecondIndex +2;
   if rem(j,13) == 0
       columnSecondIndex = 65;
   end
   disp(stockRange);
%    read per stock by two columns
   [numb,text, volumeInfo] = xlsread(filename,volumeSheet,stockRange);
   
   volume = numb;
   [rowsnum, closnumb] = size(volume);
   dateTime = text(3:end,1);
   
   firstdatecell = strsplit(dateTime{1,1});
   curday = firstdatecell{1,1};
   curtimebin=1;

   for row = 1:rowsnum-1
       %today's open time and close time
       datecell = strsplit(dateTime{row});
       date = datecell{1,1};
       time = datecell{1,2};
       open = datevec([date, ' ', datestr(opentime,'HH:MM:SS')]);
       close = datevec([date, ' ', datestr(closetime,'HH:MM:SS')]);
       cur = datevec(dateTime{row});
       %same day
       if strcmp(date,curday)
           % the trading time is between the open and close time
           % add to matrix
           if etime(open,cur)*etime(close,cur)<0
               while time ~= volumnvec(curtimebin)
                   dataMatrix = [dataMatrix,0];
               end
               dataMatrix = [dataMatrix,volume(row)];
               key = [NameInfo(j) date];
               keyvec = [keyvec,key];
           else
               continue;
           end
       %another day
       else
           curday = date;
           row=row-1;
       end
  
   end
end





