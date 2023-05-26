function  [x_left,y_left] = left_most_point(img)
    for col = 1 : size(img, 2)
	    if sum(img(:,col))~=0
            x_left = find(img(:,col));
            y_left = col;
            if length(x_left)>1
                x_left = x_left(round(length(x_left)/2));
            end
            break;
        end
    end
end