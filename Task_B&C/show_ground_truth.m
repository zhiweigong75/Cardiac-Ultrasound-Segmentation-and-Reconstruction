function image_data = show_ground_truth(mhd_path,raw_path)
    % Load the MHD file using the "load_mhd" function
    image_info = read_mhd(mhd_path);
    
    % Extract the necessary information from the image_info structure
    image_size = image_info.size;
    
    % Open the raw file and read the data
    fid = fopen(raw_path);
    %format = class(image_info.data);
    format = 'uint8';
    raw_data = fread(fid, prod(image_size), format);
    fclose(fid);
    
    % Reshape the raw data into the correct dimensions
    image_data = reshape(raw_data, image_size');
    %image_data = imnoise(image_data,'salt & pepper',0.02);
    %daspect(image_info.spacing);
    % Adjust the contrast of the image
    %image_data_adjusted = imadjust(image_data);
    
    % Display the image
    %imshow(image_data(:,:,1));
end