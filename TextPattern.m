function P = TextPattern(var_size,str,percent)

P = zeros(200);
FontSize = 200*percent;
P = insertText(P,[0.5 0.5]*200,str,'FontSize',FontSize,'TextColor',[1 1 1],'BoxColor',[0 0 0],'BoxOpacity',1,'AnchorPoint','Center','Font','Source Code Pro');
P = nmlz(double(rgb2gray(P)));
P = fftshift(imresize(P,var_size,'nearest'));
