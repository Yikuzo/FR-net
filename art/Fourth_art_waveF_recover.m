clear all
close all
clc
%% Splicing according to the original track
% Start splicing according to the original track

load('recover_440_400_50_1f_W.mat')  
qiege = permute(recover, [2,3,1]);
art_testunfold=zeros(40,400,150);
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
    ping(((k-1)*horizontal+1):k*horizontal,14*len+1:15*len)=data(:,4*len+1:5*len,(k-1)*num+11);   
    
    art_testunfold(t1,:,:)=ping;
     
end

art_full = zeros(20,400, 150);
art_W_recover = cat(1, art_testunfold, art_full);
art_W_recover = permute(art_W_recover, [3, 2, 1]);

%% Inverse wavelet transform
load('Sf.mat')
load('df.mat')
d0 = permute(df,[2, 1, 3]);         
sz = size(d0);
for i = 1:sz(1)
    for j = 1:sz(2)
        [temp] = waverec(reshape(art_W_recover(i,j,:),[1,60]),reshape(Sf(i,j,:),[1,5]),'sym4');  
        art_recover(i,j,:) = reshape(temp,[1,1,40]);
    end
end

%save('test_our_recover.mat','test_our_recover')

%% draw pictures
df = permute(df,[2, 1, 3]);     
cancha=df-art_recover;
our_recover=art_recover;
%save('our_recover.mat','our_recover')
our_noise = cancha;
%save('our_noise.mat','our_noise')
figure;
imagesc(squeeze(df(:,:,2)))
figure;
imagesc(squeeze(art_recover(:,:,2)))
figure;
imagesc(squeeze(cancha(:,:,2)))
figure;
imagesc(squeeze(df(145,:,:))')
figure;
imagesc(squeeze(art_recover(145,:,:))')
figure;
imagesc(squeeze(cancha(145,:,:))')