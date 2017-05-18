
tic;
str1=strings(1,9)
str1=['H','O','R','S','E','B','A','C','K']
str2=strings(1,9)
str2=['S','N','O','W','F','L','A','K','E']
new_st=string()
%lcs=strings(1,9)

%lcs1=strings(1,9)
%f=1
a=1
%new_st=strings(1,9)
mat1=zeros(10,10)
mat2=zeros(9,9)
 for i=2:10
     for j=2:10
         
        if(str2(1,i-1) == str1(1,j-1))
          
           
           
        mat1(i,j)=mat1(i-1,j-1)+1
       
        
        mat2(i-1,j-1)=mat1(i,j)
        else
            mat1(i,j)=max([mat1(i,j-1),mat1(i-1,j)])
           
            mat2(i-1,j-1)=mat1(i,j)
        end
    end
end   
print_lcs(mat2,str2,i-1,j-1,new_st)
%{
lcs1=[x1,y1,z1,x2,y2,z2,x3,y3,z3]
for h=9:1
    if(isempty(lcs1(1,h)))
    end
   
       lcs(1,a)=lcs1(1,h)
        a=a+1
    end
%}

   

         
    
