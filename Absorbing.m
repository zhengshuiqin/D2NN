function A = Absorbing(var,inner_cut_off,outer_cut_off,type)
%% The type 1 absorbing border.
if(type==1)
    T = 2*(outer_cut_off-inner_cut_off);
    r = sqrt(var.x.^2+var.y.^2);
    A = zeros(size(var.x));
    A = (1+cos(2*pi/T*(r-inner_cut_off)))/2;
    A(r<inner_cut_off)=1;
    A(r>outer_cut_off)=0;
end

%% The type 2 absorbing border.
% you can add you  absorbing border there