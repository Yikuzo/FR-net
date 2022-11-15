clear all
close all
clc

%% generate synthetic data
%plane1
n1=400;n2=150;n3=40;
t1=150;p11=0;p12=0;
plane1=zeros(n1,n2,n3);
for i2=1:n2
    for i3=1:n3
        
        t=floor(t1+p11*i2+p12*i3);
        plane1(t,i2,i3)=1;
    end
end
plane1=ricker_mada(plane1,0.002,10);
%plane2
n1=400;n2=150;n3=40;
t2=20;p21=2;p22=2;
plane2=zeros(n1,n2,n3);
for i2=1:n2
    for i3=1:n3
        
        t=floor(t2+p21*i2+p22*i3);
        plane2(t,i2,i3)=1;
    end
end
plane2=ricker_mada(plane2,0.002,10);
%%plane3
n1=400;n2=150;n3=40;
t3=400;p31=-2;p32=-2;
plane3=zeros(n1,n2,n3);
max=0;
for i2=1:n2
    for i3=1:n3
        
        t=floor(t3+p31*i2+p32*i3);
        if max<t
            max=t;
        end
        plane3(t,i2,i3)=1;

    end
end
plane3=ricker_mada(plane3,0.002,10);  
dc=plane1+plane2+plane3;
dc=yc_scale(dc,3);
%figure;imagesc(squeeze(dc(:,:,1))');     %%clean image

%% adding random noise
% randn('state',201314);
% var=0.2;
% n=0.02*randn(size(dc));

%% adding footprint noise
[nt,nx,ny]=size(dc);
x=[0:nx-1];
y=sin(10*x);
noise2d=y(:)*ones(1,ny);
noise3d=zeros(nt,nx,ny);
for it=0:nt-1
    noise3d(it+1,:,:) = noise2d*0.1^(it/(nt-1));
end

df=dc+noise3d*0.1;     % Add noise data      
save('df.mat','df')

%% Wavelet transform

d0 = permute(df, [2, 1, 3]);%150 400 40
C = zeros(150,400,60);%xline Inline timeline
Sf = zeros(150,400,5);
sz = size(d0);
for i = 1:sz(1)
    for j = 1:sz(2)
        [a,b] = wavedec(reshape(d0(i,j,:),[1,40]),3,'sym4');
        C(i,j,:) = reshape(a,[1,1,60]);
        Sf(i,j,:) = reshape(b,[1,1,5]);
    end
end

A_40_400_150_W = permute(C(:,:,1:40), [3, 2, 1]);
save('Sf.mat','Sf')
index=1;
art_440_400_50_W=zeros(440,400,50);     

for t=1:40      
    df=squeeze(A_40_400_150_W(t,:,:));
    for j=1:10:101     
        art_440_400_50_W(index,:,:)=df(:,j:j+49);
        index=index+1;
    end
end
art_440_400_50_Wf = art_440_400_50_W; % Wavelet transform results
save('art_440_400_50_Wf.mat','art_440_400_50_Wf')
figure;imagesc(-squeeze(art_440_400_50_Wf(1,:,:)));%colormap(gray)




