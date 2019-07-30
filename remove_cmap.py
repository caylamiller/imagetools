import matplotlib.pyplot as plt
import numpy as np
import sys, os

def remove_cmap(filein, cmap):
	cmap = plt.get_cmap(cmap)
	image = plt.imread(filein)[:,:,:3] #RGB image

	#calculate an image that contains the distance of each pixel 
	#in the image to each point on the colormap line in 1000 increments
	def cmap_dist(img):
		colorspace = cmap(np.linspace(0,1,1000))[:,:3]
		cspace1 = np.repeat([colorspace],img.shape[1],axis=0)
		colorspaceim = np.repeat([cspace1],img.shape[0],axis=0)
		colorspaceim = colorspaceim.transpose(2,0,1,3)
		cmap_dist_im = np.sum((img-colorspaceim)**2,axis=3)
	argmins = cmap_dist(image)

	#for each pixel, find the minimum-distance point 
	#and pick that point.
	argmins = 1./1000*np.argmin(cmap_dist_im,axis=0)
		return argmins
	return argmins

if __name__=='__main__':
	#command line argument stuff
	if len(sys.argv)>0:
	    filein = sys.argv[1]
	    if len(sys.argv)>2:
	    	cmap = sys.argv[2]
	    else:
	    	cmap = 'jet'
	    #get the gray image from the helper function above.
	    gray_im = remove_cmap(filein,cmap)
	    #save it as a tiff
	    plt.imsave(arr=gray_im,fname='out.tif' cmap='Greys')
	else:
		print('Error: no file specified\nUsage: \n >> python3 remove_cmap.py filein [cmap]')