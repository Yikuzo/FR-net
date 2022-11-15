clear all
close all
clc
%% Wavelet transform
% Decompose the signal into a series of superposition of wavelet functions
load('Kerry3D_40_400_150_ori.mat')
d0 =Kerry3D_40_400_150;
s_cplot(squeeze(d0(1,:,:)))
d0 = permute(d0,[3 2 1]);%150 400 40
C = zeros(150,400,60);%xline Inline timeline
S = zeros(150,400,5);
sz = size(d0);
for i = 1:sz(1)
    for j = 1:sz(2)
        [a,b] = wavedec(reshape(d0(i,j,:),[1,40]),3,'sym4');
        C(i,j,:) = reshape(a,[1,1,60]);
        S(i,j,:) = reshape(b,[1,1,5]);
    end
end
K_40_400_150_W = permute(C(:,:,1:40), [3, 2, 1]);
save('C.mat','C')
save('S.mat','S')
index=1;
kerry_440_400_50_W=zeros(440,400,50);     
for t=1:40      % 
    dn=squeeze(K_40_400_150_W(t,:,:));
    for j=1:10:101    
        kerry_440_400_50_W(index,:,:)=dn(:,j:j+49);
        index=index+1;
    end
end
%save('kerry_440_400_50_W.mat','kerry_440_400_50_W')
figure;imagesc(-squeeze(kerry_440_400_50_W(1,:,:)));%colormap(gray)