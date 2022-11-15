import h5py
import numpy as np
import matplotlib.pyplot as plt

# draw original figure
data=h5py.File('Kerry3D_40_400_150_ori.mat')
datax=data['Kerry3D_40_400_150']      #
print(datax.shape)
fig = plt.figure(3)
plt.imshow(datax[:,:,1].squeeze(), aspect='auto', cmap='seismic_r')
plt.clim(-1.1, 0.3)
plt.xlabel('Inline')
plt.ylabel('Crossline')
plt.colorbar()
plt.show()

# draw recover data
our_recover=h5py.File('our_recover.mat')
our_recover=our_recover['our_recover']      #
print(our_recover.shape)
fig3 = plt.figure(1)
plt.imshow(our_recover[1,:,:].squeeze().T, aspect='auto', cmap='seismic_r')
plt.clim(-1.1, 0.3)
plt.xlabel('Inline')
plt.ylabel('Crossline')
plt.colorbar()
plt.show()

# draw noisy data
our_noise=h5py.File('our_noise.mat')
our_noise=our_noise['our_noise']
fig4 = plt.figure(1)
plt.imshow(our_noise[1,:,:].squeeze().T, aspect='auto', cmap='seismic_r')
plt.clim(-0.25, 0.25)
plt.xlabel('Inline')
plt.ylabel('Crossline')
plt.colorbar()
plt.show()