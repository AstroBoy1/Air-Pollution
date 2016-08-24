% This program calculates the scaled intensity values

load('intensity_data.mat');
scaled_measured_data = 1:nfiles;
scaled_measured_data2 = 1:nfiles;
scaled_measured_data3 = 1:nfiles;

% calculated scaled intensity
white_scaled = 1;
black_scaled = 1;
material_scaled = 1;
material_scaled2 = 1;
material_scaled3 = 1;
one_scaled = 1;
two_scaled = 1;
three_scaled = 1;
four_scaled = 1;
five_scaled = 1;
six_scaled = 1;
seevn_scaled = 1;
eight_scaled = 1;
nine_scaled = 1;
ten_scaled = 1;
gray_scaled = 1;
% measured black is the y-intercept
% 255 / (measured_white-measured_black) is the inverse slope

for i = 1:nfiles
    measured_white = white_data(i);
    measured_black = black_data(i);
    measured_material = material_data(i);
    measured_gray = gray_data(i);
    measured_one = one_data(i);
    measured_two = two_data(i);
    measured_three = three_data(i);
    measured_four = four_data(i);
    measured_five = five_data(i);
    measured_six = six_data(i);
    measured_seven = seven_data(i);
    measured_eight = eight_data(i);
    measured_nine = nine_data(i);
    measured_ten = ten_data(i);
    actual = [6,11,23,33.5,45.8,58.2,70.2,82.6,94.6,110.6];
    actual2 = [1.1, 55.5, 102.8];
    measured = [measured_one, measured_two, measured_three, measured_four, measured_five, measured_six, measured_seven, measured_eight, measured_nine, measured_ten];
    measured2 = [measured_black, measured_gray, measured_white];
    p = polyfit(measured, actual, 1);
    p2 = polyfit(measured2, actual2, 1);
    p_one = polyfit(measured(1:5),actual(1:5), 1);
    p_two = polyfit(measured(6:10),actual(6:10), 1);
    p_average = [0,0];
    p_average(1) = (p_one(1) + p_two(1))/2;
    p_average(2) = (p_one(2) + p_two(2))/2;
    
    scaled_measured = p(1) * (measured_material-measured_one) + 6;
    scaled_measured2 = p2(1) * (measured_material-measured_black) + 1.1;
    scaled_measured3 = p_average(1) * (measured_material-measured_one) + 6;
    scaled_measured_data(i) = scaled_measured;
    scaled_measured_data2(i) = scaled_measured2;
    scaled_measured_data3(i) = scaled_measured3;
end

% save data to file

start_row = 2;
a1 = {'material'};
b1 = {'scaled_intensity'};
xlswrite('scaled_data.xlsx', scaled_measured_data', 1, 'B2');
xlswrite('scaled_data.xlsx', a1, 1, 'A1');
xlswrite('scaled_data.xlsx', b1, 1, 'B1');
xlswrite('scaled_data.xlsx', material_names', 1, 'A2');

c1 = {'white intensity'};
d1 = {'black intensity'};
e1 = {'gray intensity'};
f1 = {'material intensity'};
g1 = {'one intensity'};
h1 = {'two intensity'};
i1 = {'three intensity'};
j1 = {'four intensity'};
k1 = {'five intensity'};
l1 = {'six intensity'};
m1 = {'seven intensity'};
n1 = {'eight intensity'};
o1 = {'nine intensity'};
p1 = {'ten intensity'};
q1 = {'scaled_intensity2(bwg)'};
r1 = {'scaled_intensity_average'};

xlswrite('scaled_data.xlsx', c1, 1, 'C1');
xlswrite('scaled_data.xlsx', d1, 1, 'D1');
xlswrite('scaled_data.xlsx', e1, 1, 'E1');
xlswrite('scaled_data.xlsx', f1, 1, 'F1');
xlswrite('scaled_data.xlsx', g1, 1, 'G1');
xlswrite('scaled_data.xlsx', h1, 1, 'H1');
xlswrite('scaled_data.xlsx', i1, 1, 'I1');
xlswrite('scaled_data.xlsx', j1, 1, 'J1');
xlswrite('scaled_data.xlsx', k1, 1, 'K1');
xlswrite('scaled_data.xlsx', l1, 1, 'L1');
xlswrite('scaled_data.xlsx', m1, 1, 'M1');
xlswrite('scaled_data.xlsx', n1, 1, 'N1');
xlswrite('scaled_data.xlsx', o1, 1, 'O1');
xlswrite('scaled_data.xlsx', p1, 1, 'P1');
xlswrite('scaled_data.xlsx', q1, 1, 'Q1');
xlswrite('scaled_data.xlsx', r1, 1, 'R1');

xlswrite('scaled_data.xlsx', white_data', 1, sprintf('C%d',start_row));
xlswrite('scaled_data.xlsx', black_data', 1, sprintf('D%d',start_row));
xlswrite('scaled_data.xlsx', gray_data', 1, sprintf('E%d',start_row));
xlswrite('scaled_data.xlsx', material_data', 1, sprintf('F%d',start_row));
xlswrite('scaled_data.xlsx', one_data', 1, sprintf('G%d',start_row));
xlswrite('scaled_data.xlsx', two_data', 1, sprintf('H%d',start_row));
xlswrite('scaled_data.xlsx', three_data', 1, sprintf('I%d',start_row));
xlswrite('scaled_data.xlsx', four_data', 1, sprintf('J%d',start_row));
xlswrite('scaled_data.xlsx', five_data', 1, sprintf('K%d',start_row));
xlswrite('scaled_data.xlsx', six_data', 1, sprintf('L%d',start_row));
xlswrite('scaled_data.xlsx', seven_data', 1, sprintf('M%d',start_row));
xlswrite('scaled_data.xlsx', eight_data', 1, sprintf('N%d',start_row));
xlswrite('scaled_data.xlsx', nine_data', 1, sprintf('O%d',start_row));
xlswrite('scaled_data.xlsx', ten_data', 1, sprintf('P%d',start_row));
xlswrite('scaled_data.xlsx', scaled_measured_data2', 1, sprintf('Q%d',start_row));
xlswrite('scaled_data.xlsx', scaled_measured_data3', 1, sprintf('R%d',start_row));

'finish scaled'
