# assisting-watershed-segmentation

The sample image is generated through the reconstruction of a oil droplet hologram. Note that the objects in the image is size randomized and the image is noisy due to the hologram reconstruction (basically a convolution of the image, please refer to Katz and Sheng 2010 Annual Rev. of Fluid Mechanics, Toloui and Hong 2015 Optic Express for more details). Further, the aggregation of the objects poses the difficulties in automatic recognition of the individual droplet. Through  the assisted marker controlled watershed segmentation, large droplets can be recognized and segmented from the image. The tiny object (less than 5 pixels in the image size or 22 microns in the physical size) could be recognized through minimum intensity metric (not included in this repository). 

This algorithm should works for the images with low SNR, clustered particle images, cell/bacterial microscopic images, MRI images with artifacts etc. and images with spacial or temporal variation in intensity.
