close all
clear
clc

scale_ED = 1.7467e-05;
scale_ES = 1.7202e-05;

for n=1:10
mhd_path_4CH = convertStringsToChars('../../Team8/Test'+string(n)+'/'+'R_4CH_sequence.mhd');
raw_path_4CH = convertStringsToChars('../../Team8/Test'+string(n)+'/'+'R_4CH_sequence.raw');
image_info_4CH = read_mhd(mhd_path_4CH);
img_4CH = show_ground_truth(mhd_path_4CH,raw_path_4CH);
num_4CH = size(img_4CH,3);


mhd_path_2CH = convertStringsToChars('../../Team8/Test'+string(n)+'/'+'R_2CH_sequence.mhd');
raw_path_2CH = convertStringsToChars('../../Team8/Test'+string(n)+'/'+'R_2CH_sequence.raw');
image_info_2CH = read_mhd(mhd_path_2CH);
img_2CH = show_ground_truth(mhd_path_2CH,raw_path_2CH);
num_2CH = size(img_2CH,3);

% Calculate the length difference
diff_len = abs(num_2CH - num_4CH);

% Remove elements from the middle of the longer image sequence
if num_2CH > num_4CH
    % Remove elements from 2CH
    remove_idx = round(linspace(2, num_2CH-1, diff_len));
    img_2CH(:,:,remove_idx) = [];
else
    % Remove elements from 4CH
    remove_idx = round(linspace(2, num_4CH-1, diff_len));
    img_4CH(:,:,remove_idx) = [];
end

for i=1:min(num_2CH,num_4CH)
    [point_cloud, model, volume] = reconstruction(img_2CH(:,:,i),img_4CH(:,:,i));
    figure(1)
    h_DG = plot(model);
    title('Test'+string(n));
    xlim([-150 165]);
    ylim([-100 500]);
    zlim([-180 180]);
    view(-359.9674,-61.8000)
    daspect([1    2    1]);
    set(h_DG,'EdgeAlpha',0.05);
    frame = getframe(gcf);
    img =  frame2im(frame);
    [img,cmap] = rgb2ind(img,256);
    if i == 1
        imwrite(img,cmap,'../../Team8/Test'+string(n)+'/'+'animation'+string(n)+'.gif','gif','LoopCount',Inf,'DelayTime',0.2);
        volume_ED = scale_ED*volume;
    else
        imwrite(img,cmap,'../../Team8/Test'+string(n)+'/'+'animation'+string(n)+'.gif','gif','WriteMode','append','DelayTime',0.2);
    end
end
%volume_ED
volume_ES = scale_ES*volume;
stroke_volume = volume_ED-volume_ES;
ejection_fraction = 100*stroke_volume/volume_ED;
writematrix([stroke_volume;ejection_fraction],'../../Team8/Test'+string(n)+'/'+'taskC.txt');
end