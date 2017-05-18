%All the functions are called from the "Compute Disparity " section of the 
%DepthEstimationFromStereoVideoExample

%{
Sushma Colanukudhuru
Ioana Fleming
CSCI 5722
hw3
%}
function nccMap=ncc_algorithm(frameLeftRect,frameRightRect)


%read the two images and convert them to gray scale

a1=imread('frameLeftRect.png');
b1=imread('frameRightRect.png');
frameLeftGray  = rgb2gray(a1);
frameRightGray = rgb2gray(b1);
I1=frameLeftGray;
I2=frameRightGray;

%Get the size of the window from the user

windowSize=input('Enter the size of window');


strSize = [0 0];
%The disparity range is from 0-64 which is 65
disp_range = 65;
win = floor(windowSize/2);

%find the size of both the image,they must be of the same size
[m,n] = size(I1);
[p,q] = size(I2);


%Timer is started to check the running time
tic();
%Initialise the disparity matrix with zeros
disparityMap = zeros(m,n);

for x = 1:m
    %The window size for every pixel position is determined(rows that can
    %be traveresed)
    min_r = max(1, x-win);
    
    max_r = min(m, x+win);
    
    
     %The window size for every pixel position is determined(colums that can
    %be traveresed)
    for y = 1:n
        
        try
        
        min_y = max(1, y-win);
        max_y = min(n, y+win);
        %a window is selected in the left/reference image
        template = I1(min_r:max_r, min_y:max_y);
               
        max_d = min(disp_range, n-max_y); 
        
        
        window = [];
        
        if max_d == 0
            template = repmat(template(:),1);  
            
            window = I2(min_r:max_r, min_y:max_y);
            window = repmat(window(:),1);    
        else 
            template = repmat(template(:),1,max_d);                   
            for k = min_y:max_y
  %window in the second image is selected
                window = [window; I2(min_r:max_r, k : k + max_d-1)];
            end
        end    
       %the mean of the left and right windows are calculated
        ml_img=mean2(template);
        mr_img=mean2(window);
        %The standard deviation values are calculated
        nr1=sum(sum(template-ml_img));
        nr2=sum(sum(window-mr_img));
        nr=nr1*nr2;
        
        std_devl=(sum(sum(template-ml_img).^2));
        std_devr=(sum(sum(window-mr_img).^2));
        dr=sqrt(std_devr*std_devl);
        ncc=nr/dr;
        %the ncc value is calculated
        
      
        
      % max of the values in the ncc vector is selected 
        
        [ncc_val, ncc_index] = max(ncc);
        % the column corresponding to the max value in the ncc values
        % vector is assigned to the nccMap
        nccMap(x,y) = ncc_index;
        
       
        end
    end
    
    



end

% the ncc disparity map is displayed

imshow(nccMap,[0 64]);
colormap('jet');
colorbar;