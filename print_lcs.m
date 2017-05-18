
function print_lcs(b,str2,i,j,new_st)

m = i
n = j

new_str=new_st

a=strings()

%{
if(~(isempty(y1)))
y1=new_str(1,2)
end
    
if(~(isempty(z1))
z1=new_str(1,3)

x2=new_str(1,4)
y2=new_str(1,5)
z2=new_str(1,6)
x3=new_str(1,7)
y3=new_str(1,8)
z3=new_str(1,9)

    %{
for o=1:t
         new_str(1,o)
   %}
       
   %}

   

%if(m==9 &
%n==9)
       %f=1
%end
if( m==1 | n==1)
   a=reverse(new_str)
   disp(a)

  return
end

if b(m,n)==b(m-1,n-1)
    
    
    print_lcs(b,str2,m-1,n-1,new_str)



elseif b(m,n)==b(m-1,n)
   
       new_str=strcat(new_str,str2(m-1))
       %f=f+1
       print_lcs(b,str2,m-1,n,new_str)

elseif b(m,n)==b(m,n-1)
        new_str=strcat(new_str,str2(m))
        %f=f+1
        
        print_lcs(b,str2,m,n-1,new_str)


        else
                  print_lcs(b,str2,m-1,n-1,new_str)
end

