%{
    CSCI 5722/4830
Prof.Ioana Fleming
    Sushma Colanukudhuru
    Andrew Lee
    %}

function [activeconts]=activecontours(i1) 
tic;
[p,q]=size(i1);
disp('No of rows');
disp(p);
disp('No of cols');
disp(q);
%Inputs are taken from the user
alpha=input('Enter the value of alpha');
beta=input('ENter the value for beta');
gamma=input('Enter the value for gamma');
x1=input('Enter the range for the initialisation mask');
x2=input('Enter the range for the initialisation mask');
y1=input('Enter the range for the initialisation mask');
y2=input('Enter the range for the initialisation mask');
maxits=input('Enter the max no. of iterations required');


%I=imread(I);
%i1=rgb2gray(I);

%The values are dependent in the image and must be input by the user 
%The mask is created based on the users input
init_mask=zeros(p,q);
init_mask(x1:y1,x2:y2)=1;


display=1;


ephsilon=0.1;

%The region phi function is created 
phi=find_phi(i1,init_mask);
disp(size(phi));
%The pixelson the boundary of the brain in the image are determined
for h=1:maxits
    bdr=find(phi<=1.2 & phi>=-1.2);

inside=find(phi<=0);
outside=find(phi>0);
%Average intensity values inside the boundary and outside are determined
mean_inside=sum(i1(inside))./length(inside);

mean_outside=sum(i1(outside))./length(outside);
Force=(i1(bdr)-mean_inside).^2-(i1(bdr)-mean_outside).^2;
curvature_bond=def_curvature(bdr,phi);
%Internal Energy function is calculated
internalenergy=internalfunc(bdr,phi);

%External Energy function is calculated
chg_phidt=alpha*internalenergy+gamma*double(Force./max(abs(Force)))+beta*curvature_bond;
chg_time=0.45./(max(chg_phidt)+ephsilon);
phi(bdr)=phi(bdr)+chg_time.*chg_phidt;
phi=smooth_func(phi,0.5);
    show_curvature(i1,phi,h);

end
activeconts=phi<=0;
function show_curvature(i1, phi, h)
  imshow(i1,'initialmagnification',200,'displayrange',[0 255]); hold on;
  contour(real(phi), [0 0], 'g','LineWidth',4);
  contour(real(phi), [0 0], 'k','LineWidth',2);
  hold off; title([num2str(h) ' Iterations']); drawnow;
end

function internalenergy=internalfunc(bdr,phi)
[x y]=size(phi);
xp=x+1;xm=x-1;
yp=y+1;
ym=y-1;
xp(xp>x)=x;
yp(yp>y)=y;
ym(ym<1)=1;
xm(xm<1)=1;


[border_x border_y]=ind2sub([x y],bdr);
border_l=sub2ind(size(phi),x,ym);
border_r=sub2ind(size(phi),x,yp);
border_u=sub2ind(size(phi),xm,y);
border_d=sub2ind(size(phi),xp,y);
phi_chgx=phi(border_r)-phi(border_l);
phi_chgy=phi(border_u)-phi(border_d);
internalenergy=sqrt((phi_chgx).^2+(phi_chgy).^2);


end
%Curvature of the boundary is determined
function curvature_bond=def_curvature(bdr,phi)
ephsilon=0.1;
[u,v]=size(phi);
[bdr_x bdr_y]=ind2sub([u,v],bdr);

bdr_xp=bdr_x+1;
bdr_xm=bdr_x-1;
bdr_yp=bdr_y+1;
bdr_ym=bdr_y-1;
 bdr_xp(bdr_xp>bdr_x)=bdr_x;
 bdr_xm(bdr_xm<1)=1;
 bdr_yp(bdr_yp>bdr_y)=bdr_y;
 bdr_ym(bdr_ym<1)=1;


bdul=sub2ind(size(phi),bdr_xm,bdr_ym);
%disp(bdul);
bdur=sub2ind(size(phi),bdr_xm,bdr_yp);


%disp(bdur);


bddl=sub2ind(size(phi),bdr_xp,bdr_ym);
%disp(bddl);
bddr=sub2ind(size(phi),bdr_xp,bdr_yp);
%disp(bddr);
bdu=sub2ind(size(phi),bdr_xm,bdr_y);
%disp(bdu);
bdd=sub2ind(size(phi),bdr_xp,bdr_y);
%disp(bdd);
bdl=sub2ind(size(phi),bdr_x,bdr_ym);
%disp(bdl);
bdr=sub2ind(size(phi),bdr_x,bdr_yp);
%disp(bdr);


df_x=phi(bdl)-phi(bdl);


df_y=phi(bdu)-phi(bdd);
df_xx=phi(bdr)+phi(bdl)-2*phi(bdr);
df_yy=phi(bdu)+phi(bdd)-2*phi(bdr);
df_xy=0.25*phi(bdul)+0.25*phi(bddr)-0.25*(bdur)-0.25*(bddl);
df_x2=(df_x).^2;
df_y2=(df_y).^2;
curvature_bond=( (df_x2.*df_yy+df_y2.*df_xx-2.*df_x.*df_y.*df_xy)./...
    (df_x2+df_y+ephsilon).^(3/2)).*(df_x2+df_y2).^(1/2);
end


function phi=find_phi(i1,init_mask)
bf_dist=bwdist(init_mask);
fb_dist=bwdist(1-init_mask);
phi=bf_dist-fb_dist+im2double(init_mask)-0.5;
end
function mat=smooth_func(mat,chg_time)
back_diff=mat-shift_right(mat);
for_diff=shift_left(mat)-mat;
up_diff=mat-shift_down(mat);
down_diff=shift_up(mat)-mat;
back_diffp=back_diff;
for_diffp=for_diff;
up_diffp=up_diff;
down_diffp=down_diff;

down_diffn=down_diff;
back_diffn=back_diff;
for_diffn=for_diff;
up_diffn=up_diff;

back_diffp(back_diff<0)=0;
for_diffp(for_diff<0)=0;
up_diffp(up_diff<0)=0;
down_diffp(down_diff<0)=0;

down_diffn(down_diffn>0)=0;
back_diffn(back_diffn>0)=0;
for_diffn(for_diffn>0)=0;
up_diffn(up_diffn>0)=0;
new_mat=zeros(size(mat));
mat_neg_ind=find(mat<0);
mat_pos_ind=find(mat>0);
new_mat(mat_pos_ind)=sqrt(max(back_diffp(mat_pos_ind).^2,for_diffp(mat_pos_ind).^2)...
    +max(up_diffp(mat_pos_ind).^2,down_diffp(mat_pos_ind).^2))-1;

new_mat(mat_neg_ind)=sqrt(max(back_diffn(mat_neg_ind).^2,for_diffn(mat_neg_ind).^2)+max(up_diffn(mat_neg_ind).^2,down_diffn(mat_neg_ind).^2))-1;
mat=mat-chg_time.*sign_smdfunc(mat).*new_mat;
end





    function shiftl=shift_left(mat)
        shiftl=[mat(:,2:(size(mat,2))),mat(:,2)];
        
    end

function shiftr=shift_right(mat)
    shiftr=[mat(:,1),mat(:,1:(size(mat,2)-1))];
        
end
function shiftu=shift_up(mat)
       shiftu=shift_left(mat')'; 
end
function shiftd=shift_down(mat)
        shiftd=shift_right(mat')'; 
end
    function sign=sign_smdfunc(mat)
        sign=mat./sqrt(mat.^2+1);
    end

%end
disp(toc);
end
