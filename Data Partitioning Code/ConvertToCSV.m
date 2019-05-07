%%%
% File: ConvertToCSV.m
% Author: Calvin Kuo
% Date: 03-19-2019
%
% Function converts input dataset (cell type) into csv files. Each step
% will have its own csv file, which will be converted in batch by python
% into relevant data structures.

function ConvertToCSV( cell_data, file_prefix )
    if nargin == 1
        file_prefix = "data";
    end
    
    for i=1:length( cell_data )
        file_name = file_prefix + "_" + num2str( i, '%04.0f' ) + ".csv";
        csvwrite( file_name, cell_data{i} );
    end
end