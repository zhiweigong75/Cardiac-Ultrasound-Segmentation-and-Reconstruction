function [cx, cy, theta, emin, emax] = calculate_geometric_attributes(label_img,label)
    geo_img = double(label_img);
    geo_img(geo_img ~= label) = 0;
    geo_img(geo_img == label) = 1;
    A = 0;
    sum_x = 0;
    sum_y = 0;
    a = 0;
    b = 0;
    c = 0;
    for i = 1:size(geo_img,1)
        for j = 1:size(geo_img,2)
            A = A + geo_img(i,j);
            sum_x = sum_x + j*geo_img(i,j);
            sum_y = sum_y + i*geo_img(i,j); 
        end
    end
    cx = sum_x/A;
    cy = sum_y/A;
    
    for y = 1:size(geo_img,1)
        for x = 1:size(geo_img,2)
            a = a + (x-cx)^2*geo_img(y,x);
            b = b + 2*(x-cx)*(y-cy)*geo_img(y,x);
            c = c + (y-cy)^2*geo_img(y,x);
        end
    end

    theta = atan2(b, a-c)/2;
    theta2 = theta + pi/2;
    d2E = (a-c)*cos(2*theta)+b*sin(2*theta);
    
    if d2E > 0
        emin = a*sin(theta)^2 - b*sin(theta)*cos(theta) + c*cos(theta)^2;
        emax = a*sin(theta2)^2 - b*sin(theta2)*cos(theta2) + c*cos(theta2)^2;
    else
        emin = a*sin(theta2)^2 - b*sin(theta2)*cos(theta2) + c*cos(theta2)^2;
        emax = a*sin(theta)^2 - b*sin(theta)*cos(theta) + c*cos(theta)^2;
        theta = theta2;
    end
end    