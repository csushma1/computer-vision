%{
Sushma Colanukudhuru
Ioana Fleming
CSCI 5722
%}
%The first iput image is read and displayed

%{
Sushma COlanukudhuru
Ioana Fleming
CSCI 5722
%}
%The first input image is read and displayed
I=imread('uttower1.jpg');
imshow(I);
B=[];
%ginput function is used to get the input values of the mouse coordinates
%Mouse positions fromthe first image are stored in [x,y]

[x,y]=ginput;
%The second input image is read and displayed

I2=imread('uttower2.jpg');
imshow('uttower2.jpg');
%Mouse positions from the second image are stored in [x,y]
[a,b]=ginput;
%{The homography matrix is computed based on BH=0
%H=homography matrix
%{
B=[x1 y1 1 0 0 0 ?x˜1x1 ?x˜1y1 ?x˜1
0 0 0 x1 y1 1 ?y˜1x1 ?y˜1y1 ?y˜1
: : : : : : : : :
xN yN 1 0 0 0 ?x˜N xN ?x˜N yN ?x˜N
0 0 0 xN yN 1 ?y˜N xN ?y˜N yN ?y˜N ]
~x1,~y1 are the corresponding points in the uttower2.jpg
%}
%Computation of matrix B
for i=1:4
    D=[x(i,1);y(i,1);1]
    A=[-D',[0,0,0],[D'.*a(i,1)];
        [0,0,0], -D', [D'.*b(i,1)]];
    B=[B;A];
end
% The singular value decomposition of the  B is done
%It can be decomposed into three matrices
%The last column of the V matrix corresponds to the homography matrix
[s,u,v]=svd(B)

% Homography column vector of size is displayed
h=v( :,9);
disp(h);


%Computing the homography matrix
h1=h(1:3);
h2=h(4:6);
h3=h(7:9);
H=[h1';h2';h3'];
disp(H);


Hinverse=inv(H);
%{
invmap=[];%homography matrix is multiplied with the  points from the
%input image and maps it to corresponding points in the output image
for j=1:4
    G=[x(j,1);y(j,1);];
    V=Hinverse*G;
    invmap=[invmap;V'];
    %U=[:,Y]
end
invmap_changed=zeros(4,2);
disp(invmap_changed);
[s,t]=size(invmap);
for i=1:s
    for j=1:t-1
        disp(j);
        invmap_changed(i,j)=invmap(i,j)./invmap(i,t);
        disp( invmap_changed(i,j));
        
        disp(invmap_changed);
    end
end


for k=1:4
    
    T=[U(k,1)/U(k,3), U(k,2)/U(k,3)]
    
end
imshow('uttower2.jpg')

for n=1:4
    hold on;
    plot(T(n,:),'go')
end

    
%}






