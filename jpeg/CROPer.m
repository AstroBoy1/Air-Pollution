% This programs does an initial crop of an image and saves that data

imagefiles = dir('**.JPG'); 
image = imread(imagefiles(1).name);
t = 1;
cm = msgbox('select region and double clip to crop');
pause(t);
a = msgbox('crop the white');
pause(t);
[white_image, rect_white] = imcrop(image);
delete(cm)
delete(a)
b = msgbox('crop the black');
pause(t);
[black_image, rect_black] = imcrop(image);
delete(b)
c = msgbox('crop the material');
pause(t);
[material_image, rect_material] = imcrop(image);
delete(c)
d = msgbox('crop the gray');
pause(t);
[gray_image, rect_gray] = imcrop(image);
delete(d);

d = msgbox('crop the one');
pause(t);
[one_image, rect_one] = imcrop(image);
delete(d);
d = msgbox('crop the two');
pause(t);
[two_image, rect_two] = imcrop(image);
delete(d);
d = msgbox('crop the three');
pause(t);
[three_image, rect_three] = imcrop(image);
delete(d);
d = msgbox('crop the four');
pause(t);
[four_image, rect_four] = imcrop(image);
delete(d);
d = msgbox('crop the five');
pause(t);
[five_image, rect_five] = imcrop(image);
delete(d);
d = msgbox('crop the six');
pause(t);
[six_image, rect_six] = imcrop(image);
delete(d);
d = msgbox('crop the seven');
pause(t);
[seven_image, rect_seven] = imcrop(image);
delete(d);
d = msgbox('crop the eight');
pause(t);
[eight_image, rect_eight] = imcrop(image);
delete(d);
d = msgbox('crop the nine');
pause(t);
[nine_image, rect_nine] = imcrop(image);
delete(d);
d = msgbox('crop the ten');
pause(t);
[ten_image, rect_ten] = imcrop(image);
delete(d);

save('rect_data.mat');
close all;

'finished CROPer'
