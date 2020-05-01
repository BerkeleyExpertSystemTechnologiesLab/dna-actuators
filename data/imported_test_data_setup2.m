% imported_test_data_setup2.
% 
% Data copied from spreadsheets which recorded force/torque/displacement
% data for the second set of test stands for the double helix linear
% actuators.
% Andrew P. Sabelhaus, 2020

% No prepping the workspace - we'll overwrite variables as needed.

% We have three actuator designs, and four sets of data.
% (i) 0.007" rails, pretensioned (wave springs), both slide + bearing
% (ii) 0.007" rails, loose fit, bearing
% (iii) 0.015" rails, loose fit, bearing

%% (i), from slide
% TO-DO: WHERE IS THAT SPREADSHEET FROM THE IDETC PAPER?
ii_slide = struct;


%% (i), from bearing.

% We'll store in structs according to load.
ii_bearing = struct;

% Note: same theta for all tests in design (ii).
% number of turns used, by index.
ii_bearing.theta = [0.25
                    0.5
                    0.75
                    1
                    1.25
                    1.5
                    1.75
                    2
                    2.25
                    2.375
                    0.00];

% TO-DO: convert to radians.


% Unloaded: 0 grams

% Sloppy, but we can copy-paste from the spreadsheet.
% Columns are test number, row corresponds to theta index.
ii_bearing.g0 = [1	0.7	1.3	1	0.9
                3.3	3.8	3.4	3.7	3.8
                7	7	7.3	7.5	7.9
                8	9	10.2	9	10.6
                7.3	7.4	8	8.5	7.8
                7.1	5.6	5.4	6.1	7.3
                4.1	6	5.7	5.9	5.6
                4.1	3.9	4.6	5.8	5.5
                5.1	2.2	1.8	2.1	2.5
                -1	-0.8	0.1	-1.2	-0.4
                -0.3	0.3	0.4	0	-0.1];

% 100g
ii_bearing.g100 = [ 1.8	1.6	1.7	2	1.7
                    4.9	4.7	4.6	4.8	5.2
                    8.3	8.3	9.1	8.9	8.5
                    10	11.2	11.3	10.7	10.3
                    10.2	10.6	9.7	10.8	10.9
                    8.1	8.3	8.3	9.8	9.9
                    7.1	9	7.5	7.7	8.6
                    6.6	7	8.7	7.9	7.1
                    4.3	5.2	6.8	6.8	10.7
                    5.5	4.8	3	4.2	4
                    -0.4	-0.2	0.1	-0.1	0];

% 200g
ii_bearing.g200 = [ 2	2	1.9	1.9	1.9
                    5.4	5.6	5.2	4.8	5.4
                    9.9	9	9.4	8.9	9.3
                    11.4	12.6	12.3	11.6	12.4
                    12.5	11.8	11.2	10.8	11.8
                    10.5	9.7	10.5	9.2	11
                    8.6	9.4	10	10	10.4
                    10.6	8.3	10	8.8	8.2
                    12.3	16	11.7	13.3	9
                    10.5	14	14	13	19
                    -0.1	0	-0.1	-0.2	0];

% 300g
ii_bearing.g300 = [ 2.9	2.5	2.8	2.5	2.7
                    6.5	5.5	5.7	5.9	5.7
                    10.4	9.4	10	9.2	9.8
                    13.1	13.2	13	12	12.4
                    13.1	12.4	11.8	12.8	12.5
                    10.7	10.4	10.6	10.8	10.3
                    13	11.9	13	11.4	9.7
                    15.6	13.9	12.8	13.7	10.3
                    14.6	19.8	13.3	13	18.2
                    13.2	19.1	18	14	12
                    0	-0.3	0	-0.1	0];
                
% 400g
ii_bearing.g400 = [ 2.7	2.7	2.7	2.7	2.6
                    6.1	5.9	5.8	6.4	6.1
                    10.3	9.9	10.5	10.1	10.6
                    13.5	13.9	12.7	14.3	14.2
                    13	15.3	14.1	13.8	14.3
                    15	13.4	13.8	13.2	14.2
                    11.8	14.3	14.9	14.3	15.3
                    17.6	13	15.4	14.6	16.7
                    23.7	21.1	17.7	18.1	17.2
                    21	27	26	27	30
                    -0.2	-0.1	0	-0.2	0.1];

%% (ii), loose fit, bearing




















