# Perspective Rectification Toolkit

###  Andrea Fusiello, 2020

![banner](https://fusiello.github.io/demo/rect/bannerraddrizza.jpg)

This toolkit is a collection of Matlab functions and scripts implementing perspective rectification (or control, or correction) of an image ("raddrizzamento": in Italian).  

It requires functions contained in the [Computer Vision Toolkit] (http://www.diegm.uniud.it/fusiello/demo/toolkit/ComputerVisionToolkit.zip) by the same author.

After installing the abovementioned dependencies, cd to the toolkit main directory and type `runPRectif`.

Perspective rectification transforms the original image with a homography such that the image of a reference plane chosen by the user becomes a similarity transform of the real one (instead of a perspective projection). As a result:

- all lines that are vertical/horizontal in reality are vertical/horizontal in the rectified image (of the plane) ;
- all lines that are parallel in reality are parallel in the rectified image (of the plane);
- angles are preserved (i.e. can be measured in the image of the plane);
- distances can be measured in the image (of the plane) as soon as the scale is known. 

The reference plane is typically the ground or a facade. 

As emphasized above, the similarity is valid *only* for the reference plane. The image of all the other object points (excluding other planes parallel to the reference one) is distorted. This rectified (or controlled) photo is *not the same as an orthophoto*.

Two input modes are implemented (selectable by changing a string in the script): 

1. (default) Select 4 pair of points that determine 4 lines (two horizontal and two vertical). The distance between pair of lines can be given in order to scale the image correctly.

2. Select 4 points on a rectangle. The dimensions of the rectangle can be given in order to scale the image correctly.

See also `SelectionOrder.png`

In any case horizontal and vertical scales are guessed, so that a default  is submitted to the user that does not have access to any measure.  An independent scaling of the two axes can be easily applied a-posteriori.

The folders contain also a sample image with saved point selection, so that  the script runs out-of-the-box without user intervention. To activate the point selection  uncomment the appropriate lines in the script `runPRectif`.


References:

* H.P. Bhar. Digital Rectification of a Facade. Presented paper, ISP Commission III Symposium, Moscow, 1978

* H.P. Bhar. Analog Versus Digital Image Processing of Photogrammetric Imagery. XVI Congress of ISPRS, Hamburg 1980


---
Andrea Fusiello                
Dipartimento Politecnico di Ingegneria e Architettura (DPIA)  
Università degli Studi di Udine, Via Delle Scienze, 208 - 33100 Udine  
email: <andrea.fusiello@uniud.it>

---

