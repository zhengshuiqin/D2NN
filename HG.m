function S=HG(var,w0s,m,n,x0,y0)

syms  variable
Hm_syms = hermiteH(m,variable);
Hm = eval(['@(variable)',vectorize(Hm_syms)]);
Hn_syms = hermiteH(n,variable);
Hn = eval(['@(variable)',vectorize(Hn_syms)]);

x = var.x-x0;
y = var.y-y0;
S=Hm(sqrt(2)*x./w0s).*Hn(sqrt(2)*y./w0s).*exp(-(sqrt(x.^2+y.^2)/w0s).^2);

S = S./sum(abs(S(:)).^2); % Energy normalization
