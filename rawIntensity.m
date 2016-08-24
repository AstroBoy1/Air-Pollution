% This program determines the brightness/intensity of an image

%imagefiles = dir('**.JPG');
imagefiles = dir('**.dng');
warning off MATLAB:tifflib:TIFFReadDirectory:libraryWarning
warning('off', 'all');
counter = 0;

%[xmin ymin width height]

nfiles = length(imagefiles); % Number of files found
material_names = cell(1,nfiles);
intensity_data = 1:nfiles; % saves intensities of each image
white_intensity_data = 1:nfiles;
black_intensity_data = 1:nfiles;
gray_intensity_data = 1:nfiles;
scaled_intensity_data = 1:nfiles;
scaled_intensity_data2 = 1:nfiles;
scaled_intensity_data3 = 1:nfiles;

one_intensity_data = 1:nfiles;
two_intensity_data = 1:nfiles;
three_intensity_data = 1:nfiles;
four_intensity_data = 1:nfiles;
five_intensity_data = 1:nfiles;
six_intensity_data = 1:nfiles;
seven_intensity_data = 1:nfiles;
eight_intensity_data = 1:nfiles;
nine_intensity_data = 1:nfiles;
ten_intensity_data = 1:nfiles;

if nfiles >= 1
    for i=1:nfiles
        counter = counter + 1;
        currentfilename = imagefiles(i).name;
        material_names(i) = {currentfilename};
        t = Tiff(currentfilename, 'r');
        offsets = getTag(t, 'SubIFD');
        setSubDirectory(t,offsets(1));
        raw = read(t); % Create variable ’raw’, the Bayer CFA data
        close(t);
        meta_info = imfinfo(currentfilename);
        % Crop to only valid pixels
        x_origin = meta_info.SubIFDs{1}.ActiveArea(2)+1; % +1 due to MATLAB indexing
        width = meta_info.SubIFDs{1}.DefaultCropSize(1);
        y_origin = meta_info.SubIFDs{1}.ActiveArea(1)+1;
        height = meta_info.SubIFDs{1}.DefaultCropSize(2);
        raw = double(raw(y_origin:y_origin+height-1,x_origin:x_origin+width-1));

        if isfield(meta_info.SubIFDs{1}, 'LinearizationTable')
            linear = 'linear';
            ltab=meta_info.SubIFDs{1}.LinearizationTable;
            raw = ltab(raw+1);
        end
        black = meta_info.SubIFDs{1}.BlackLevel(1);
        saturation = meta_info.SubIFDs{1}.WhiteLevel; %saturation is the highest white
        lin_bayer = (raw-black)/(saturation-black);
        lin_bayer = max(0,min(lin_bayer,1));

        % White Balancing
        wb_multipliers = (meta_info.AsShotNeutral).^-1;
        wb_multipliers = wb_multipliers/wb_multipliers(2);
        mask = wbmask(size(lin_bayer,1),size(lin_bayer,2),wb_multipliers, 'rggb');
        balanced_bayer = lin_bayer .* mask;

        % Demosaic
        temp = uint16(balanced_bayer/max(balanced_bayer(:))*2^16);
        lin_rgb = double(demosaic(temp,'rggb'))/2^16;

        % Color space conversion
        xyz2cam = meta_info.ColorMatrix2;
        xyz2cam = reshape(xyz2cam,[3,3]);
        rgb2xyz = [0.4124564,0.3575761,0.1804375; 0.2126729,0.7151522,0.0721750; 0.0193339, 0.1191920, 0.9503041];
        rgb2cam = xyz2cam * rgb2xyz; % Assuming previously defined matrices
        rgb2cam = rgb2cam ./ repmat(sum(rgb2cam,2),1,3); % Normalize rows to 1
        cam2rgb = rgb2cam^-1;
        lin_srgb = apply_cmatrix(lin_rgb, cam2rgb);
        lin_srgb = max(0,min(lin_srgb,1)); % Always keep image clipped b/w 0-1
        %imshow(image);
        if counter == 1
            cm = msgbox('crop the material');
            [new_image, rect] = imcrop(lin_srgb);
            delete(cm);
            cb = msgbox('crop black');
            [new_image_b, rect_b] = imcrop(lin_srgb);
            delete(cb);
            cw = msgbox('crop white');
            [new_image_w, rect_w] = imcrop(lin_srgb);
            delete(cw);
            cg = msgbox('crop gray');
            [new_image_g, rect_g] = imcrop(lin_srgb);
            delete(cg);
            cg = msgbox('crop one');
            [new_image_one, rect_one] = imcrop(lin_srgb);
            delete(cg);
            cg = msgbox('crop two');
            [new_image_two, rect_two] = imcrop(lin_srgb);
            delete(cg);
            cg = msgbox('crop three');
            [new_image_three, rect_three] = imcrop(lin_srgb);
            delete(cg);
            cg = msgbox('crop four');
            [new_image_four, rect_four] = imcrop(lin_srgb);
            delete(cg);
            cg = msgbox('crop five');
            [new_image_five, rect_five] = imcrop(lin_srgb);
            delete(cg);
            cg = msgbox('crop six');
            [new_image_six, rect_six] = imcrop(lin_srgb);
            delete(cg);
            cg = msgbox('crop seven');
            [new_image_seven, rect_seven] = imcrop(lin_srgb);
            delete(cg);
            cg = msgbox('crop eight');
            [new_image_eight, rect_eight] = imcrop(lin_srgb);
            delete(cg);
            cg = msgbox('crop nine');
            [new_image_nine, rect_nine] = imcrop(lin_srgb);
            delete(cg);
            cg = msgbox('crop ten');
            [new_image_ten, rect_ten] = imcrop(lin_srgb);
            delete(cg);
        end
        x1 = rect(1);
        x2 = x1 + rect(3);
        y1 = rect(2);
        y2 = y1 + rect(4);
        image = lin_srgb(y1:y2,x1:x2,:);
        
        xb1 = rect_b(1);
        xb2 = xb1 + rect_b(3);
        yb1 = rect_b(2);
        yb2 = yb1 + rect_b(4);
        image_black = lin_srgb(yb1:yb2,xb1:xb2,:);
        
        xw1 = rect_w(1);
        xw2 = xw1 + rect_w(3);
        yw1 = rect_w(2);
        yw2 = yw1 + rect_w(4);
        image_white = lin_srgb(yw1:yw2,xw1:xw2,:);
        
        xone1 = rect_one(1);
        xone2 = xone1 + rect_one(3);
        yone1 = rect_one(2);
        yone2 = yone1 + rect_one(4);
        image_one = lin_srgb(yone1:yone2,xone1:xone2,:);
        
        xtwo1 = rect_two(1);
        xtwo2 = xtwo1 + rect_two(3);
        ytwo1 = rect_two(2);
        ytwo2 = ytwo1 + rect_two(4);
        image_two = lin_srgb(ytwo1:ytwo2,xtwo1:xtwo2,:);
        xthree1 = rect_three(1);
        xthree2 = xthree1 + rect_three(3);
        ythree1 = rect_three(2);
        ythree2 = ythree1 + rect_three(4);
        image_three = lin_srgb(ythree1:ythree2,xthree1:xthree2,:);
        xfour1 = rect_four(1);
        xfour2 = xfour1 + rect_four(3);
        yfour1 = rect_four(2);
        yfour2 = yfour1 + rect_four(4);
        image_four = lin_srgb(yfour1:yfour2,xfour1:xfour2,:);
        xfive1 = rect_five(1);
        xfive2 = xfive1 + rect_five(3);
        yfive1 = rect_five(2);
        yfive2 = yfive1 + rect_five(4);
        image_five = lin_srgb(yfive1:yfive2,xfive1:xfive2,:);
        xsix1 = rect_six(1);
        xsix2 = xsix1 + rect_six(3);
        ysix1 = rect_six(2);
        ysix2 = ysix1 + rect_six(4);
        image_six = lin_srgb(ysix1:ysix2,xsix1:xsix2,:);
        xseven1 = rect_seven(1);
        xseven2 = xseven1 + rect_seven(3);
        yseven1 = rect_seven(2);
        yseven2 = yseven1 + rect_seven(4);
        image_seven = lin_srgb(yseven1:yseven2,xseven1:xseven2,:);
                xeight1 = rect_eight(1);
        xeight2 = xeight1 + rect_eight(3);
        yeight1 = rect_eight(2);
        yeight2 = yeight1 + rect_eight(4);
        image_eight = lin_srgb(yeight1:yeight2,xeight1:xeight2,:);
                xnine1 = rect_nine(1);
        xnine2 = xnine1 + rect_nine(3);
        ynine1 = rect_nine(2);
        ynine2 = ynine1 + rect_nine(4);
        image_nine = lin_srgb(ynine1:ynine2,xnine1:xnine2,:);
                xten1 = rect_ten(1);
        xten2 = xten1 + rect_ten(3);
        yten1 = rect_ten(2);
        yten2 = yten1 + rect_ten(4);
        image_ten = lin_srgb(yten1:yten2,xten1:xten2,:);
                xg1 = rect_g(1);
        xg2 = xg1 + rect_g(3);
        yg1 = rect_g(2);
        yg2 = yg1 + rect_g(4);
        image_gray = lin_srgb(yg1:yg2,xg1:xg2,:);
        
        intensity_data(i) = mean(mean(mean(image)));
        white_intensity_data(i) = mean(mean(mean(image_white)));
        black_intensity_data(i) = mean(mean(mean(image_black)));
        gray_intensity_data(i) = mean(mean(mean(image_gray)));
        one_intensity_data(i) = mean(mean(mean(image_one)));
        two_intensity_data(i) = mean(mean(mean(image_two)));
        three_intensity_data(i) = mean(mean(mean(image_three)));
        four_intensity_data(i) = mean(mean(mean(image_four)));
        five_intensity_data(i) = mean(mean(mean(image_five)));
        six_intensity_data(i) = mean(mean(mean(image_six)));
        seven_intensity_data(i) = mean(mean(mean(image_seven)));
        eight_intensity_data(i) = mean(mean(mean(image_eight)));
        nine_intensity_data(i) = mean(mean(mean(image_nine)));
        ten_intensity_data(i) = mean(mean(mean(image_ten)));
        actual = [6,11,23,33.5,45.8,58.2,70.2,82.6,94.6,110.6];
        actual2 = [1.1, 55.5, 102.8];
        actual_one = [6,11,23,33.5,45.8];
        actual_two = [58.2,70.2,82.6,94.6,110.6];
        measured = [one_intensity_data(i), two_intensity_data(i), three_intensity_data(i), four_intensity_data(i), five_intensity_data(i), six_intensity_data(i), seven_intensity_data(i), eight_intensity_data(i), nine_intensity_data(i), ten_intensity_data(i)];
        measured2 = [black_intensity_data(i), gray_intensity_data(i), white_intensity_data(i)];
        p = polyfit(measured, actual, 1);
        p2 = polyfit(measured2, actual2, 1);
        
        p_one = polyfit(measured(1:5), actual_one, 1);
        p_two = polyfit(measured(6:10), actual_two, 1);
        p_average = [0,0];
        p_average(1) = (p_one(1)+p_two(1)) / 2;
        p_average(2) = (p_two(2)+p_two(2)) / 2;
        
        scaled_measured = p(1) * (intensity_data(i)-one_intensity_data(i)) + 6;
        scaled_measured2 = p2(1) * (intensity_data(i)-black_intensity_data(i)) + 1.1;
        scaled_measured3 = p_average(1) * (intensity_data(i)-one_intensity_data(i)) + 6;
        scaled_intensity_data(i) = scaled_measured;
        scaled_intensity_data2(i) = scaled_measured2;
        scaled_intensity_data3(i) = scaled_measured3;
        
    end
end

start_row = 1;
a1 = {'image'};
b1 = {'intensity'};
c1 = {'black intensity'};
d1 = {'white intensity'};
e1 = {'scaled intensity'};
f1 = {'scaled intensity2'};
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
q1 = {'scaled_average intensity'};

xlswrite('intensityData.xlsx', a1, 1, 'A1');
xlswrite('intensityData.xlsx', b1, 1, 'B1');
xlswrite('intensityData.xlsx', c1, 1, 'C1');
xlswrite('intensityData.xlsx', d1, 1, 'D1');
xlswrite('intensityData.xlsx', e1, 1, 'E1');
xlswrite('intensityData.xlsx', f1, 1, 'F1');
xlswrite('intensityData.xlsx', g1, 1, 'G1');
xlswrite('intensityData.xlsx', h1, 1, 'H1');
xlswrite('intensityData.xlsx', i1, 1, 'I1');
xlswrite('intensityData.xlsx', j1, 1, 'J1');
xlswrite('intensityData.xlsx', k1, 1, 'K1');
xlswrite('intensityData.xlsx', l1, 1, 'L1');
xlswrite('intensityData.xlsx', m1, 1, 'M1');
xlswrite('intensityData.xlsx', n1, 1, 'N1');
xlswrite('intensityData.xlsx', o1, 1, 'O1');
xlswrite('intensityData.xlsx', p1, 1, 'P1');
xlswrite('intensityData.xlsx', q1, 1, 'Q1');

xlswrite('intensityData.xlsx', intensity_data', 1, 'B2');
xlswrite('intensityData.xlsx', material_names', 1, 'A2');
xlswrite('intensityData.xlsx', black_intensity_data', 1, 'C2');
xlswrite('intensityData.xlsx', white_intensity_data', 1, 'D2');
xlswrite('intensityData.xlsx', scaled_intensity_data', 1, 'E2');
xlswrite('intensityData.xlsx', scaled_intensity_data2', 1, 'F2');
xlswrite('intensityData.xlsx', one_intensity_data', 1, 'G2');
xlswrite('intensityData.xlsx', two_intensity_data', 1, 'H2');
xlswrite('intensityData.xlsx', three_intensity_data', 1, 'I2');
xlswrite('intensityData.xlsx', four_intensity_data', 1, 'J2');
xlswrite('intensityData.xlsx', five_intensity_data', 1, 'K2');
xlswrite('intensityData.xlsx', six_intensity_data', 1, 'L2');
xlswrite('intensityData.xlsx', seven_intensity_data', 1, 'M2');
xlswrite('intensityData.xlsx', eight_intensity_data', 1, 'N2');
xlswrite('intensityData.xlsx', nine_intensity_data', 1, 'O2');
xlswrite('intensityData.xlsx', ten_intensity_data', 1, 'P2');
xlswrite('intensityData.xlsx', scaled_intensity_data3', 1, 'Q2');

'Finished'

