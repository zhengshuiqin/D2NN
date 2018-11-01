function S=LG(var,w0s,p,l,x0,y0)
syms  variable
Laguerre = 0;

for k = 0:p
    C = factorial(p+abs(l))/factorial(abs(l)+k)/factorial(k)/factorial(p-k);
Laguerre = Laguerre+C*(-variable).^k;
end
Laguerre = eval(['@(variable)',vectorize(Laguerre)]);
x = var.x-x0;
y = var.y-y0;
S= (sqrt(2).*(x+sign(l)*i*y)./w0s).^(abs(l)).*Laguerre(2*(x.^2+y.^2)/w0s.^2).*exp(-(sqrt(x.^2+y.^2)/w0s).^2);

S = S./sum(abs(S(:)).^2);
