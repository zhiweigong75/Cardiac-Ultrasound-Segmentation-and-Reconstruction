function X_re = rough_3D_contour(X_2CH_DG, X_4CH_DG, n_rings)
    % Given 4 points in 3D space
    len = min(size(X_2CH_DG,1),size(X_4CH_DG,1));
    X_re = [X_2CH_DG; X_4CH_DG];

    for i=round(linspace(1,len-1,n_rings))
        p(1,:) = [X_2CH_DG(i,1), X_2CH_DG(i,2), X_2CH_DG(i,3)];
        p(2,:) = [X_4CH_DG(i,1), X_4CH_DG(i,2), X_4CH_DG(i,3)];
        p(3,:) = [X_2CH_DG(i+1,1), X_2CH_DG(i+1,2), X_2CH_DG(i+1,3)]; 
        p(4,:) = [X_4CH_DG(i+1,1), X_4CH_DG(i+1,2), X_4CH_DG(i+1,3)];
        xyz = p';
        X = fnplt(cscvn(xyz(:,[1:end 1])),'r',2);
        X_re = [X_re; X'];
    end    
end