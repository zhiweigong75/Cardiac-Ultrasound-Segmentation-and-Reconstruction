clear all
Team = string('Team8/');

for i=1:1
    caseID = 'Test'+string(i)+'/';
    %% Evaluate task A
    for j=1:2
        if j==1
            view = string('2CH');
        elseif j==2
            view = string('4CH');
        end
        % Read student's result %
        img = read_raw(Team + caseID+'R_'+view+'_sequence');

        % Read ground truth (held out data) %
        files = dir('GT/'+caseID);
        for k = 1:length(files)
            file_name = files(k).name;
            if contains(file_name, view+'_ED_gt.raw')
                disp(['Found file: ' file_name]);
                [~, name, ~] = fileparts(file_name);
                gt1 = read_raw(string('GT/')+caseID+name);
            end
            if contains(file_name, view+'_ES_gt.raw')
                disp(['Found file: ' file_name]);
                [~, name, ~] = fileparts(file_name);
                gt2 = read_raw(string('GT/')+caseID+name);
            end
        end
        gt1(find(gt1 ~= 1)) = 0;
        gt2(find(gt2 ~= 1)) = 0;
        % Convert the images to binary images with threshold 0.5
        bwimg1 = imbinarize(gt1, 0.5);
        bwimg2 = imbinarize(gt2, 0.5);
        bwimg_ED = imbinarize(img(:,:,1), 0.5);
        bwimg_ES = imbinarize(img(:,:,end), 0.5);
        % Compute the absolute difference between the binary images
        diffimg1 = imabsdiff(bwimg_ED, bwimg1);
        diffimg2 = imabsdiff(bwimg_ES, bwimg2);
        % Compute the overlap percentage
        overlap_percent_ED = (1 - sum(diffimg1(:)) / sum(bwimg1,"all")) * 100;
        overlap_percent_ES = (1 - sum(diffimg2(:)) / sum(bwimg2,"all")) * 100;
        accuracy_segmentation(i) = (overlap_percent_ED + overlap_percent_ES)/2;
    end
    %% Evaluate Task C
    % Read student's result %
    matrix = load(Team+caseID+'taskC.txt');

    % Read ground truth (held out data)%
    fileID = fopen('GT/'+caseID+'Info_4CH.cfg','r');
    formatSpec = '%s %s';
    C = textscan(fileID, formatSpec, 'Delimiter', ':', 'Whitespace', '\n');
    EDV_index = find(strcmp(C{1},'LVedv'));
    ESV_index = find(strcmp(C{1},'LVesv'));
    EF_index = find(strcmp(C{1},'LVef'));
    stroke_value = str2num(string(C{2}(EDV_index)))-str2num(string(C{2}(ESV_index)));
    EF_value = str2num(string(C{2}(EF_index)));
    fclose(fileID);

    dev_C(i,:) = [(matrix(1)-stroke_value)/stroke_value; matrix(2)-EF_value];
end
avg_accuracy_segmentation = mean(accuracy_segmentation)
avg_dev_C = mean(dev_C,1)

%% Evaluate stroke volume and ejection fraction


%% Read .raw/.hmd file
function img = read_raw(path)
% Open the header file
fid = fopen(path+'.mhd', 'r');

% Read the header file line by line
while ~feof(fid)
    line = fgetl(fid);

    % Look for the line containing DimSize
    if contains(line, 'DimSize')
        % Extract the values after the equals sign and convert to a numeric array
        dims = textscan(line, 'DimSize = %d %d %d');
        dims = cell2mat(dims);

        % Break out of the loop once we've found the DimSize field
        break;
    end
end

% Close the file
fclose(fid);


id = fopen(path+'.raw');
img = fread(id);
img = reshape(img,dims);
end