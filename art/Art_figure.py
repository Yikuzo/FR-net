import h5py
import numpy as np
import matplotlib.pyplot as plt

# draw original figure
data=h5py.File('ori.mat')
datax=data['ori']      #
print(datax.shape)
fig = plt.figure(3)
plt.imshow(datax[20,:,:].squeeze().T, aspect='auto', cmap='seismic')
plt.clim(-0.4, 0.4)
plt.xlabel('Inline')
plt.ylabel('Crossline')
plt.colorbar()
plt.show()

# draw recover data
our_recover=h5py.File('our_recover.mat')
our_recover=our_recover['our_recover']      #
print(our_recover.shape)
fig3 = plt.figure(1)
plt.imshow(our_recover[:,:,20].squeeze(), aspect='auto', cmap='seismic')
plt.clim(-0.4, 0.4)
plt.xlabel('Inline')
plt.ylabel('Crossline')
plt.colorbar()
plt.show()

# draw noisy data
our_noise=h5py.File('our_noise.mat')
our_noise=our_noise['our_noise']
fig4 = plt.figure(1)
plt.imshow(our_noise[:,:,20].squeeze(), aspect='auto', cmap='seismic')
plt.clim(-0.2, 0.2)
plt.xlabel('Inline')
plt.ylabel('Crossline')
plt.colorbar()
plt.show()