clear all
close all
clc
%% Splicing according to the original track
load('recover_440_400_50_W.mat'); % Output data of the network
load('Kerry3D_40_400_150_ori.mat'); % Original data
qiege = permute(recover, [2,3,1]);
kerry_testunfold=zeros(40,400,150);
for t1=1:40
    data=qiege(:,:,((t1-1)*11+1):t1*11);     
    ping = zeros(400, 150);
    horizontal =400;
    len=10;
    num=11;       
  
    k=1;
    ping(((k-1)*horizontal+1):k*horizontal,0*len+1:1*len)=data(:,1:len,(k-1)*num+1);
    ping(((k-1)*horizontal+1):k*horizontal,1*len+1:2*len)=(data(:,len+1:2*len,(k-1)*num+1)+data(:,1:len,(k-1)*num+2))/2;
    ping(((k-1)*horizontal+1):k*horizontal,2*len+1:3*len)=(data(:,2*len+1:3*len,(k-1)*num+1)+data(:,len+1:2*len,(k-1)*num+2)+data(:,1:len,(k-1)*num+3))/3;
    ping(((k-1)*horizontal+1):k*horizontal,3*len+1:4*len)=(data(:,3*len+1:4*len,(k-1)*num+1)+data(:,2*len+1:3*len,(k-1)*num+2)+data(:,len+1:2*len,(k-1)*num+3)+data(:,1:len,(k-1)*num+4))/4;
    ping(((k-1)*horizontal+1):k*horizontal,4*len+1:5*len)=(data(:,4*len+1:5*len,(k-1)*num+1)+data(:,3*len+1:4*len,(k-1)*num+2)+data(:,2*len+1:3*len,(k-1)*num+3)+data(:,len+1:2*len,(k-1)*num+4)+data(:,1:len,(k-1)*num+5))/5;
    for j=2:6    
        ping(((k-1)*horizontal+1):k*horizontal,(j+3)*len+1:(j+4)*len)=(data(:,4*len+1:5*len,(k-1)*num+j)+data(:,3*len+1:4*len,(k-1)*num+(j+1))+data(:,2*len+1:3*len,(k-1)*num+(j+2))+data(:,len+1:2*len,(k-1)*num+(j+3))+data(:,1:len,(k-1)*num+(j+4)))/5;
    end
              
    ping(((k-1)*horizontal+1):k*horizontal,10*len+1:11*len)=(data(:,4*len+1:5*len,(k-1)*num+7)+data(:,3*len+1:4*len,(k-1)*num+8)+data(:,2*len+1:3*len,(k-1)*num+9)+data(:,len+1:2*len,(k-1)*num+10)+data(:,1:len,(k-1)*num+11))/5;
    ping(((k-1)*horizontal+1):k*horizontal,11*len+1:12*len)=(data(:,4*len+1:5*len,(k-1)*num+8)+data(:,3*len+1:4*len,(k-1)*num+9)+data(:,2*len+1:3*len,(k-1)*num+10)+data(:,len+1:2*len,(k-1)*num+11))/4;
    ping(((k-1)*horizontal+1):k*horizontal,12*len+1:13*len)=(data(:,4*len+1:5*len,(k-1)*num+9)+data(:,3*len+1:4*len,(k-1)*num+10)+data(:,2*len+1:3*len,(k-1)*num+11))/3;
    ping(((k-1)*horizontal+1):k*horizontal,13*len+1:14*len)=(data(:,4*len+1:5*len,(k-1)*num+10)+data(:,3*len+1:4*len,(k-1)*num+11))/2;
    ping(((k-1)*horizontal+1):k*horizontal,14*len+1:15*len)=data(:,4*len+1:5*len,(k-1)*num+11);   %%40= 400/10
    
    kerry_testunfold(t1,:,:)=ping;      
end

%% Inverse wavelet transform
load('S.mat')
load('C.mat')
kerry_full = zeros(60,400, 150);
kerry_full(1:40,:,:) = kerry_testunfold(:,:,:);
C = permute(C, [3, 2,1]);
kerry_full(41:60,:,:) = C(41:60, :,:);
kerry_W_recover = permute(kerry_full, [3, 2, 1]);

d0 = permute(Kerry3D_40_400_150,[3, 2, 1]); 
sz = size(d0);
for i = 1:sz(1)
    for j = 1:sz(2)
        [temp] = waverec(reshape(kerry_W_recover(i,j,:),[1,60]),reshape(S(i,j,:),[1,5]),'sym4');  
        kerry_recover(i,j,:) = reshape(temp,[1,1,40]);  % final result
    end
end

%% draw pictures
Kerry3D_150_400_40 = permute(Kerry3D_40_400_150, [3, 2, 1]); % original data
noise = Kerry3D_150_400_40-kerry_recover;  % noisy data
our_recover = kerry_recover; % recover data
our_noise = noise;
