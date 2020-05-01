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

% NOTE: ALL TORQUE DATA IN N*CM (newton-centimeters)

%% (i), 0.007, pretensioned, slide

% This data copied from "restorative_torque_experiment.m", as recorded by
% Kyle Z.
i_slide = struct;

% The input angles:
i_slide.theta = [0; 0.25; 0.5; 0.75; 1; 1.25; 1.5; 1.75; 2; 2.25; 2.5];
% One "rotation" is 360 degrees, i.e., 2*pi radians.
i_slide.theta = i_slide.theta .* (2*pi);

% Unloaded, 0 grams. The test was performed five times.
% Here, each row is one test, and each column is angle of rotation.
i_slide.g0 = [
    0, 0.12, 0.43, 0.63, 0.71, 0.62, 0.47, 0.25, 0.21, 0.05, 0;
    0, 0.12, 0.37, 0.57, 0.70, 0.64, 0.49, 0.29, 0.17, 0.07, 0;
    0, 0.12, 0.37, 0.58, 0.72, 0.61, 0.50, 0.26, 0.18, 0.04, 0;
    0, 0.06, 0.37, 0.60, 0.70, 0.67, 0.48, 0.30, 0.17, 0.08, 0;
    0, 0.07, 0.38, 0.66, 0.73, 0.66, 0.51, 0.32, 0.20, 0.08, 0];

% To have same dimensions as Ellande's data below, transpose:
i_slide.g0 = i_slide.g0';

% Convert all these torques from inch-pounds to newton-centimeters:
lb_to_N = 4.44822;
lbf_in_to_N_cm = lb_to_N * 2.54;
i_slide.g0 = i_slide.g0 .* lbf_in_to_N_cm;


%% (i), 0.007, pretensioned, bearing.

% We'll store in structs according to load.
i_bearing = struct;

% Note: same theta for all tests in design (i) bearing.
% number of turns used, by index.
i_bearing.theta = [0.25
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

% One "rotation" is 360 degrees, i.e., 2*pi radians.
i_bearing.theta = i_bearing.theta .* (2*pi);

% Unloaded: 0 grams

% Sloppy, but we can copy-paste from the spreadsheet.
% Columns are test number, row corresponds to theta index.
i_bearing.g0 = [1	0.7	1.3	1	0.9
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
i_bearing.g100 = [ 1.8	1.6	1.7	2	1.7
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
i_bearing.g200 = [ 2	2	1.9	1.9	1.9
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
i_bearing.g300 = [ 2.9	2.5	2.8	2.5	2.7
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
i_bearing.g400 = [ 2.7	2.7	2.7	2.7	2.6
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

%% (ii), 0.007 loose fit, bearing

ii = struct;

% Note: same theta for all tests in design (ii).
% number of turns used, by index.
ii.theta = [0.25
            0.5
            0.75
            1
            1.25
            1.5
            1.75
            2
            2.25
            0.00];

% One "rotation" is 360 degrees, i.e., 2*pi radians.
ii.theta = ii.theta .* (2*pi);

% Unloaded: 0 grams
ii.g0 = [   1.8	1.4	1.2	1.4	1.4
            4.4	4.3	4.4	4.4	4.1
            8	8.3	8	8.4	8.3
            10	9.8	9.9	10.6	10.2
            7.8	8.9	8.2	9.1	8.9
            4.9	6.1	6.3	6.1	7.9
            4	4.4	5.2	6.1	6.1
            2.2	4.9	2.8	3.4	4
            1.1	1.3	6	1.2	3.6
            0	-0.2	-0.1	0.1	-0.1];

% 100g
ii.g100 = [ 1.8	1.7	1.4	1.5	1.7
            5.2	5.2	5	4.9	5.1
            9.2	9.4	9.1	9.2	8.9
            10.3	11.9	11.7	11.9	11.6
            9.5	9.1	10.7	8.9	10.9
            8.3	7.7	7.2	8.4	8.6
            8	7.5	8	6.6	8.6
            6.5	5.2	7.4	5.5	5.8
            13	5.1	6.3	8.6	12.7
            0	0	0	0	0];

% 200g
ii.g200 = [ 2	1.8	2.4	1.9	2.4
            5.6	5.5	5.4	5.5	5.4
            9.4	9.9	9.9	10.2	9.9
            12.9	12.5	12.5	12.8	13
            12.6	12.6	13	12.9	12.1
            10.9	12.9	11.2	12.3	10.6
            11.8	11	10	11.2	7.8
            9.6	12.9	10.6	12	10.3
            17.9	11.2	14.1	16.2	10.1
            0	0	0	0.1	0];

% 300g
ii.g300 = [ 2.1	2.2	2.2	2.8	2.2
            5.7	6.2	6.3	6.3	6.2
            10.6	10.6	10.6	10	11.2
            13	14	12.5	12.8	13.5
            13	12.7	13.3	13.6	14
            13	12.3	12.8	11.6	12.6
            13.1	12	12.3	12.1	13.8
            12.4	15.9	14	13.2	17.3
            15.8	24.4	18.4	15.9	16.3
            0.1	0	0.1	0.1	0];

% 400g
ii.g400 = [ 2.5	2	2.3	2.4	2.3
            6.6	6.6	6.5	6.5	7
            10.9	11.1	11.1	12.3	11.7
            13.2	14.9	13.8	13.9	14.7
            14.1	13.5	13.9	13.2	15.8
            14.7	12.7	13.3	14.3	14.6
            12.1	12.6	13	15.8	13.2
            15.1	14.3	18	15.5	14.7
            22.2	21	21.5	23.3	20.4
            0	0	0	0	0.1];

%% (iii), 0.015 loose fit, bearing

iii = struct;        

% input angle.
iii.theta = [   0.25
                0.5
                0.75
                1
                1.25
                1.5
                1.75
                2
                2.25
                0.00];

% One "rotation" is 360 degrees, i.e., 2*pi radians.
iii.theta = iii.theta .* (2*pi);

% Unloaded: 0 grams
iii.g0 = [  13.4	12	11.4	11.1	11.7
            32.3	28	27	26.8	27.5
            54.4	48.1	46.3	46.6	44
            69.6	65.2	63.1	64.6	59.7
            75.3	76.1	74.2	74.6	68.8
            72.8	74	74.6	74.2	66.3
            57.4	60.8	63	60.4	52.8
            37.8	47.6	51.5	46.2	43
            32	40	38.8	40.3	30
            -4	-0.4	-0.4	-0.4	-0.7];

iii.g100 = [11	10.3	9.9	9.5	10
            26.1	25.6	24.8	24.3	24.8
            44.7	44.3	43	42.3	43.4
            63	61.8	61.4	60.2	60.7
            73.9	72.7	70.4	70.9	70.5
            73.3	73.8	71.8	71.7	72.5
            61.2	60.8	61.6	60.9	59.9
            49.7	46.8	47.3	48.8	48.1
            41.8	39.4	41.3	42.3	42.4
            -0.1	0	-0.3	-0.3	0.1];
        
iii.g500 = [10.6	10.7	9.9	9.9	10.5
            26.5	25.9	25.5	25	25
            46.7	45.1	43.5	43.1	44.2
            64.1	63.4	62.7	61.9	62.8
            75.9	74.6	75.7	73.3	74.4
            79.1	77.9	77.2	78.2	77.1
            70	71.1	68.3	66.1	64.6
            57.5	56.8	58.6	57.9	58.7
            59.7	57.3	56.6	57.2	58.4
            -0.2	-0.5	-0.7	-0.7	0];

iii.g1000 = [   11.1	11.8	11.6	11.6	11.4
                27.3	28.2	28	27	27
                47.4	47.1	47.1	45.6	46.6
                67.1	66.9	67.3	66.6	66.6
                80.9	81.8	81	80.7	80.3
                85.7	86.1	85.2	85.5	85.4
                79.3	79.9	78.7	79	78.2
                74	73.6	74.8	72.6	74.8
                78.9	76.9	77.5	76.7	77.8
                -0.5	0	0	0	0];








