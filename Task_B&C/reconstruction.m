function [X_re,shp_DG,volume_DG] = reconstruction(img_2CH,img_4CH)%(mhd_path_2CH,raw_path_2CH,mhd_path_4CH,raw_path_4CH)
% close all
% clear
% clc
%mhd_path_2CH = 'patient0010/patient0010_2CH_ES_gt.mhd';
%raw_path_2CH = 'patient0010/patient0010_2CH_ES_gt.raw';
% subplot(1,2,1)
%img_2CH = show_ground_truth(mhd_path_2CH,raw_path_2CH);
% title('2CH')

%mhd_path_4CH = 'patient0010/patient0010_4CH_ES_gt.mhd';
%raw_path_4CH = 'patient0010/patient0010_4CH_ES_gt.raw';
% subplot(1,2,2)
%img_4CH = show_ground_truth(mhd_path_4CH,raw_path_4CH);
% title('4CH')

% Plot Dark grey:
DG_2CH = img_2CH;
DG_2CH(DG_2CH~=1)=0;

% figure(2)
% subplot(1,2,1)
% imshow(imadjust(DG_2CH))
% title('2CH')

DG_4CH = img_4CH;
DG_4CH(DG_4CH~=1)=0;

% subplot(1,2,2)
% imshow(imadjust(DG_4CH))
% title('4CH')

DG_2CH = edge(DG_2CH);
DG_4CH = edge(DG_4CH);

% % Plot Light grey:
% LG_2CH = img_2CH;
% LG_2CH(LG_2CH~=2)=0;
% % subplot(2,3,2)
% % imshow(imadjust(LG_2CH))
% % title('Light grey')
% LG_4CH = img_4CH;
% LG_4CH(LG_4CH~=2)=0;
% % subplot(2,3,5)
% % imshow(imadjust(LG_4CH))
% % title('Light grey')
% 
% % Plot White:
% W_2CH = img_2CH;
% W_2CH(W_2CH~=3)=0;
% % subplot(2,3,3)
% % imshow(imadjust(W_2CH))
% % title('White')
% W_4CH = img_4CH;
% W_4CH(W_4CH~=3)=0;
% % subplot(2,3,6)
% % imshow(imadjust(W_4CH))
% % title('White')

%% suppose 2CH is in xy plane, 4CH is in yz plane:

% label: DarkGrey=1, LightGrey=2, White=3
label_DG = 1;
%label_LG = 2;
%label_W = 3;

[X_2CH_DG,X_4CH_DG] = crossintersect(DG_2CH,DG_4CH,label_DG); 
%[X_2CH_LG,X_4CH_LG] = crossintersect(LG_2CH,LG_4CH,label_LG); 
%[X_2CH_W,X_4CH_W] = crossintersect(W_2CH,W_4CH,label_W); 

% figure(2)
% plot3(X_2CH_DG(:,1), X_2CH_DG(:,2), X_2CH_DG(:,3),'.')
% hold on
% plot3(X_4CH_DG(:,1), X_4CH_DG(:,2), X_4CH_DG(:,3),'.')
% hold off
% axis equal


%% 3D reconstruction (circle interpolation):
n_rings = 50;
X_re = rough_3D_contour(X_2CH_DG, X_4CH_DG, n_rings);
shp_DG = alphaShape(X_re(:,1),X_re(:,2),X_re(:,3));
% figure(3)
% plot3(X_re(:,1),X_re(:,2),X_re(:,3),'o');
% axis equal;

% figure(4)
% h_DG = plot(shp_DG);
% set(h_DG,'EdgeAlpha',0.1);
% %title('Left Ventricle')
% axis equal;
% xlim([-100 100]);
% ylim([0 500]);
% zlim([-100 100]);

%% 3D reconstruction:
% Interpolate n more surfaces between the 2CH and 4CH
% n_interpolation = 10;
% 
% % Triangulate the points to form a mesh
% X_re_DG = rough_3D(X_2CH_DG, X_4CH_DG, n_interpolation);
% shp_DG = alphaShape(X_re_DG(:,1),X_re_DG(:,2),X_re_DG(:,3));
% 
% % X_re_LG = rough_3D(X_2CH_LG, X_4CH_LG, n_interpolation);
% % shp_LG = alphaShape(X_re_LG(:,1),X_re_LG(:,2),X_re_LG(:,3));
% % 
% % X_re_W = rough_3D(X_2CH_W, X_4CH_W, n_interpolation);
% % shp_W = alphaShape(X_re_W(:,1),X_re_W(:,2),X_re_W(:,3));
% 
% figure()
% plot3(X_re_DG(:,1),X_re_DG(:,2),X_re_DG(:,3),'o');
% axis equal;
% 
% figure()
% h_DG = plot(shp_DG);
% title('Left Ventricle')
% axis equal;

% figure()
% h_LG = plot(shp_LG);
% title('Left Ventricle Myocardium')
% axis equal;
% 
% figure()
% h_W = plot(shp_W);
% title('Left Atrium')
% axis equal;

%% Calculate the volume:
volume_DG = volume(shp_DG); % unit: voxel
end