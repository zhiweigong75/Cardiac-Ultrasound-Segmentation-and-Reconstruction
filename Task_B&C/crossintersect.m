function [X_2CH,X_4CH] = crossintersect(DG_2CH,DG_4CH,label)
    [x_2CH, y_2CH] = find(DG_2CH);
    z_2CH = zeros(length(x_2CH),1);
    [z_4CH, y_4CH] = find(DG_4CH);
    x_4CH = zeros(length(z_4CH),1);
    
    % Find the left most point of each image, then align them
    [x_left_2CH, y_left_2CH] = left_most_point(DG_2CH);
    [x_left_4CH, y_left_4CH] = left_most_point(DG_4CH);
    
    % Update the new coordinates of the two iamges
    x_2CH = x_2CH-x_left_2CH; y_2CH = y_2CH-y_left_2CH; 
    y_4CH = y_4CH-y_left_4CH; z_4CH = -z_4CH+x_left_4CH;
    
    % Calculate the axis with samllest moment of inertia. Align the two axis together
    [~, ~, theta_2, ~, ~] = calculate_geometric_attributes(DG_2CH,label);
    R_2 = [cos(theta_2) -sin(theta_2); sin(theta_2) cos(theta_2)];
    xy_r = R_2*[x_2CH y_2CH]';
    [~, ~, theta_4, ~, ~] = calculate_geometric_attributes(DG_4CH,label);
    R_4 = [cos(theta_4) -sin(theta_4); sin(theta_4) cos(theta_4)];
    yz_r = R_4*[y_4CH z_4CH]';
     
    x_2CH = xy_r(1,:)';
    y_2CH = xy_r(2,:)';
    y_4CH = yz_r(1,:)';
    z_4CH = yz_r(2,:)';
    
    X_2CH = [x_2CH, y_2CH, z_2CH];
    X_4CH = [x_4CH, y_4CH, z_4CH];
end