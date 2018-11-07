clc
clear
units;
%%
path = [cd '/Optimized/'];
filename = 'ModeTransformation_10_layers.mat';
load([path,filename]);
LoadGlobal;
ModeNum = length(InputModes);
LayerNum = length(Layers.Distance);
%%

save_path = [cd '/Evaluation/',char(datetime('now','Format','dd-mmm-yyyy-HH-MM-SS')),'/'];
mkdir(save_path);
for  layer_index = 1:LayerNum
    imwrite(field2pic(fftshift(Layers.Absorb{layer_index}.*exp(i*(Layers.Phase{layer_index})))),[save_path 'layers' num2str(layer_index),'.bmp']);
end

%%
m = ceil( sqrt(ModeNum));

SF = zeros(ModeNum);


for input_mode_index = 1:ModeNum
    Forward = InputModes{input_mode_index};
    imwrite(field2pic(fftshift(Forward)),[save_path 'Forward_input' num2str(input_mode_index),'.bmp']);

    for  layer_index = 1:LayerNum
        Distance        = Layers.Distance(layer_index);  
        modulationPhase = Layers.Phase{layer_index};
        P               = Layers.ForwardPropagate{layer_index};    
        Forward = fft2(P.*ifft2(Forward));
        Forward = Forward.*exp(i*modulationPhase);   
        imwrite(field2pic(fftshift(Forward)),[save_path 'Forward_' num2str(input_mode_index),'_',num2str(layer_index),'.bmp']);
    end
    imwrite(field2pic(fftshift(Forward)),[save_path 'Forward_output' num2str(input_mode_index),'.bmp']);
    
    Backward = OutputModes{input_mode_index};
    imwrite(field2pic(fftshift(Backward)),[save_path 'Backward_input' num2str(input_mode_index),'.bmp']);
     for  layer_index = LayerNum:-1:1
        Distance        = Layers.Distance(layer_index);
        modulationPhase = Layers.Phase{layer_index};
        P               = Layers.BackwardPropagate{layer_index};     
        
        Backward = Backward.*exp(-i*modulationPhase);     
        Backward = fft2(P.*ifft2(Backward));
        imwrite(field2pic(fftshift(Backward)),[save_path 'Backward_' num2str(input_mode_index),'_',num2str(layer_index),'.bmp']);
    end     
     imwrite(field2pic(fftshift(Backward)),[save_path 'Backward_output' num2str(input_mode_index),'.bmp']);

     for output_mode_index = 1:ModeNum    
         output_mode_index
         Backward = OutputModes{output_mode_index};     
         SF(input_mode_index,output_mode_index)=Similarity_Factor(Backward,Forward);
    end
end
%%
subplot(1,1,1)
imagesc(SF);
for input_mode_index = 1:ModeNum
    for output_mode_index = 1:ModeNum    
        if(input_mode_index==output_mode_index)
            text(output_mode_index-0.4,input_mode_index,[' ' num2str(SF(input_mode_index,output_mode_index)*100,'%0.1f'),'%'],'Color',[0 0 0],'FontSize',18);
        else
            text(output_mode_index-0.4,input_mode_index,[num2str(log(SF(input_mode_index,output_mode_index))/log(10)*10,'%0.0f'),'dB'],'Color',[1 1 1],'FontSize',18);
        end
    end
end
colormap gray
set (gca,'position',[0,0,1,1] )
set (gcf,'position',[25,25,800,800] )
axis off