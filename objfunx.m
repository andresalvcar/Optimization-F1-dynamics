function [obj]=objfunx(x)
n=100;
theta=linspace(0,1,n);
h=theta(2)-theta(1);

obj1=0;

for i=1:n
b(i)=x(i);    
end

for i=1:n-1 
    term=h/(sqrt(b(i))+sqrt(b(i+1)));
    obj1=obj1+term;
end
obj=2*obj1;