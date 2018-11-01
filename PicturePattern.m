function P = PicturePattern(var_size,filename,percent)
p  = rgb2gray(imread(filename));

P = zeros(fix(size(p)/percent));
[m,n] = size(p);
[M,N] = size(P);

P(fix(M/2-m/2):fix(M/2-m/2)+m-1,fix(N/2-n/2):fix(N/2-m/2)+n-1)=p;

P = imresize(P,var_size);
P = nmlz(fftshift(P));
