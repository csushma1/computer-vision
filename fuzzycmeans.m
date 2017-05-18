
%{
    CSCI 5722/4830
Prof.Ioana Fleming
    Sushma Colanukudhuru
    Andrew Lee
    %}
function [disp_mat]=fuzzycmeans(I)
tic;
i_gray=I;
i_gray==double(i_gray);
[p,q]=size(i_gray);
nof=input('Enter the number of iterations');
%[pixels counts]=imhist(i_gray);
h=0;

%The initial values of the centroids are set

c1=50;
c2=100;
c3=150;
c4=180;
%The clustering is performed until the end of the iterations or until the
%ratio falls below 0.0001
while(h<nof)
    
    h=h+1;
    cluster_1=repmat(c1,p,q);
    cluster_2=repmat(c2,p,q);
    cluster_3=repmat(c3,p,q);
    cluster_4=repmat(c4,p,q);
    cluster_rep=cat(3,cluster_1,cluster_2,cluster_3,cluster_4);
    
    I_rep=cat(3,i_gray,i_gray,i_gray,i_gray);
    
    small_const=repmat(0.00001,p,q);
    small_rep= cat(3,small_const,small_const,small_const,small_const);
    d_I_rep=double(I_rep);
    d_cluster_rep=double(cluster_rep);
    diff_centroidsqr=(d_I_rep-d_cluster_rep).^2;
    diff__mat=d_I_rep+small_rep;
    dr=1/diff_centroidsqr;
    splt_dr=dr(:,:,1)+dr(:,:,2)+dr(:,:,3)+dr(:,:,4);
    splt_nr1=diff_centroidsqr(:,:,1);
    dist_c1=splt_nr1.*splt_dr;
    %The probability of a pixel belonging to cluster 1 is calculated as
    %wx1
    wx1=1./dist_c1;
    splt_nr2=diff_centroidsqr(:,:,2);
    dist_c2=splt_nr2.*splt_dr;
    %The probability of a pixel belonging to cluster 2 is calculated as
    %wx2
    wx2=1./dist_c2;
    splt_nr3=diff_centroidsqr(:,:,3);
    dist_c3=splt_nr3.*splt_dr;
    %The probability of a pixel belonging to cluster 3 is calculated as
    %wx3
    wx3=1./dist_c3;
    splt_nr4=diff_centroidsqr(:,:,4);
    dist_c4=splt_nr4.*splt_dr;
    %The probability of a pixel belonging to cluster 4 is calculated as
    %wx4
    wx4=1./dist_c4;
    %The new centroid values are calculated
    new_centroid1= nansum(nansum(wx1.*wx1.*double(i_gray)))/nansum(nansum(wx1.*wx1));
    %mulp=[];
    %d_mulp=double(mulp);
    
    %d_mulp=(wx1.*wx1.*(i_gray));
    %disp(d_mulp);
    %smulp=[];
    %d_smulp=double(smulp);
    %smulp=double(nansum(d_mulp));
    %disp(smulp);
    %ssmulp=[];
    %ssmulp=double(ssmulp);
    %ssmulp=nansum(nansum(d_mulp));
    %disp(ssmulp);
    %sssmulp=[];
    %sssmulp=double(sssmulp);
    %sssmulp=nansum(nansum(wx1.*wx1));
    %disp(sssmulp);
    %disp(new_centroid1);
    
   
    %disp(sum(sum(wx1.*wx1)));
    new_centroid2= nansum(nansum(wx2.*wx2.*double(i_gray)))/nansum(nansum(wx2.*wx2));
    %disp(new_centroid2);
    new_centroid3= nansum(nansum(wx3.*wx3.*double(i_gray)))/nansum(nansum(wx3.*wx3));
    %disp(new_centroid3);
    
    new_centroid4= nansum(nansum(wx4.*wx4.*double(i_gray)))/nansum(nansum(wx4.*wx4));
    %disp(new_centroid4);
    prob_rep=cat(3,wx1,wx2,wx3,wx4);
    next_req=[abs(c1-new_centroid1/c1),abs(c2-new_centroid2/c2),abs(c3-new_centroid3/c3),abs(c4-new_centroid4/c4)];
    seg_mat=[];
    for h=1:p
        for g=1:q
            if(max(prob_rep(h,g,:))==wx1(h,g))
                seg_mat(h,g)=1;
            end
            if(max(prob_rep(h,g,:))==wx2(h,g))
                
                seg_mat(h,g)=2;
                
            end
            if(max(prob_rep(h,g,:))==wx3(h,g))
                seg_mat(h,g)=3;
            end
            if(max(prob_rep(h,g,:))==wx4(h,g))
                seg_mat(h,g)=4;
            end
        end
    end
    %The clustering is repeated until it falls below this ratio  
    if(max(next_req)<0.0001)
        break;
    else
        c1=new_centroid1;
        c2=new_centroid2;
        c3=new_centroid3;
        c4=new_centroid4;
    end
    disp_mat=[];
    
    for e=1:p
        for f=1:q
            
            if(seg_mat(e,f)==1)
                disp_mat(e,f)=10;
            end
            if(seg_mat(e,f)==2)
                disp_mat(e,f)=50;
            end
            if(seg_mat(e,f)==3)
                disp_mat(e,f)=100;
            end
            if(seg_mat(e,f)==4)
                disp_mat(e,f)=220;
            end
        end
    end
    title([num2str(h) ' Iterations']); drawnow;
    imshow(uint8(disp_mat));
    
end
disp(h)
disp(toc);





















