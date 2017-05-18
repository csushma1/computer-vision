function Img_zoom = bilinear_interpolation(Img, factor)
 
[h w c] = size(Img);
r = factor;
hn = r*(h-1)+1; wn = r*(w-1)+1;
%hn = floor(hn);
%wn = floor(wn);
Img_zoom = zeros(hn, wn, c);
 
% Padding the scaled image with 0 pixel value
for i= 1:h
   for j= 1:w
      Img_zoom(r*(i-1)+1, r*(j-1)+1, : ) = Img(i, j, : );
   end
end
 
% Interpolation
for k= 1:c
for i= 0:r:hn-r
for j= 0:r:wn-r
A = Img_zoom(i+1, j+1, k);
B = Img_zoom(i+1, j+r+1, k);
C = Img_zoom(i+r+1, j+1, k);
D = Img_zoom(i+r+1, j+r+1, k);
 
a0 = A;
         a1 = double((B-A)/r);
         a2 = double((C-A)/r);
         a3 = double((D-C-B+A)/(r*r));
 
         for l= 0:r
            for m= 0:r
               Img_zoom(i+l+1, j+m+1, k) = a0 + a1*m + a2*l + a3*m*l;
            end
         end
      end
   end
end
 
Img_zoom = uint8(Img_zoom);

image(Img_zoom)
 
end