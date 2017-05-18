%{
    CSCI 5722/4830
Prof.Ioana Fleming
    Sushma Colanukudhuru
    Andrew Lee
    %}




function [threshold_mat]=thresholding(i1)
%I=imread(I);
%i1=rgb2gray(I);
tic;
%The size of the image is determined
[p,q]=size(i1);
%White color indicates the presence of the tumor
%Red color indicates the presence of a CSF
%Blue- indicates grey matter
%Green indiates white matter

for i=1:p
    for j=1:q
        %Threshold values for gray matter is set
        if(i1(i,j)>=10 && i1(i,j)<=50)
            i1(i,j,1)=0;
            i1(i,j,2)=0;
            i1(i,j,3)=1;
        %Threshold values for white matter is set
        elseif(i1(i,j)>=60 && i1(i,j)<=80)
             i1(i,j,1)=0;
            i1(i,j,2)=1;
            i1(i,j,3)=0;
            %Threshold values for CSF is set
             elseif(i1(i,j)>=100 && i1(i,j)<=190)
             i1(i,j,1)=1;
            i1(i,j,2)=0;
            i1(i,j,3)=0;
            %Threshold values for tumor is set
            elseif(i1(i,j)>=200 && i1(i,j)<=255)
             i1(i,j,:)=255;
            
        end
    end
end
title('Thresholding');
        imshow(i1);
        threshold_mat=i1;
       disp(toc);
       