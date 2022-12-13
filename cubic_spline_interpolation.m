%Pradeep P
%2019MCB1227
%cubic spline interpolation

xy = input('Enter all the points in the matrix\n'); % taking input of all the points
n=size(xy,1);

a=zeros(n,1);
x=zeros(n,1);
y=zeros(n,1);
for i=1:n
    a(i,1)=xy(i,2); % a(i)
    x(i,1)=xy(i,1); % x(i)
    y(i,1)=xy(i,2); % y(i)
end
    
h=zeros(n-1,1);
for i=1:n-1
    h(i,1)=xy(i+1,1)-xy(i,1); %h(i)
end

% determining p of px = q to find c(i)
p = eye(n);
for i=2:n-1
    p(i,i-1)=h(i-1,1);
    p(i,i+1)=h(i,1);
    p(i,i)=2*(h(i,1)+h(i-1,1));
end

% determining q of px = q to find c(i)
q = zeros(n,1);
for i=2:n-1
    q(i,1) = (3/h(i,1))*(a(i+1,1)-a(i,1)) - (3/h(i-1,1))*(a(i,1)-a(i-1,1));
end

c = p\q; % solving px = q

b=zeros(n-1,1);
for i=1:n-1
    b(i,1) = (1/h(i,1))*(a(i+1,1)-a(i,1)) - (h(i,1)/3)*(c(i+1,1) + 2*c(i,1)); %b(i)
end

d=zeros(n-1,1);
for i=1:n-1
    d(i,1) = (1/(3*h(i,1)))*(c(i+1,1)-c(i,1)); %d(i)
end

% printing all cubic polynomials
fprintf('The interpolating function s(x) is given as\n');

for i=1:n-1
    fprintf('s(x%d) = %d*(x-%d)^3 + %d*(x-%d)^2 + %d*(x-%d) + %d in the interval (%d,%d)\n',i,d(i,1),xy(i,1),c(i,1),xy(i,1),b(i,1),xy(i,1),a(i,1),xy(i,1),xy(i+1,1));
end 

% preparing data to plot the points of s(x)
xx=[];
yy=[];
for i=1:n-1
    xp = x(i,1):0.1:x(i+1,1)-0.1;
    yp = d(i,1).*(xp - x(i,1)).^3 + c(i,1).*(xp - x(i,1)).^2 + b(i,1).*(xp - x(i,1)) + a(i,1);
    xx=cat(2,xx,xp);
    yy=cat(2,yy,yp);
end
xp = x(n,1);
yp = a(n,1);
xx=cat(2,xx,xp);
yy=cat(2,yy,yp);

plot(x,y,'o',xx,yy) %plotting