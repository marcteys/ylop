Ylop
====

Triangulate your pictures and give them a nice polygonish look.

![Ylop](https://pbs.twimg.com/media/B2PiFSMIcAAtSdh.jpg:large)

> This software is stiff in Work In Progress

##How to

###Getting started
1. Put your image on the data folder
2. Rename *baseImage* on line 71 to match the file name
3. Change the size() on line 64 values to match your image dimensions

You can now create some points on your canvas ! When you are ready, play with the settings !


### Debug displays 
* Display circles : *Display the points*
* Display color : *Show the average color of the current triangle*
* Triangles only : *Display only the triangles*
* Display epicenter : *Display the point used as reference for
### Modes
1 : Triangle creation - *Click on the picture to create some points, they are automatically linked to each other to create a triangle.*
2 : Auto triangle - *Click one time on the picture, a new triangle is created, linked to the two nearst points*
3 : Move - *Select a point and drag to move it*
4 : Delete  - *Delete a point (and the triangles connected to this one)*

### Visual options

-

### Other major options
* Save : *Saves the current points/triangles positions (WARNING : didn't save the settings)*
* Load : *Load the last data saved*
* Save as PDf : *well... save as pdf!*

## Dependencies

This sketch uses [ControlP5](http://www.sojamo.de/libraries/controlP5/) by Andreas Schlegel. 

##To do

###Debug

* new random seed
* zoom function( ducplication in bigger the 100px around)