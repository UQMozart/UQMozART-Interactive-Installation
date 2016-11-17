# UQ MozART Interactive Installation

This is the official open-source repository for the MozART project completed by four undergraduate students at The University of Queensland during 2016. Here you will find the source code files for the project and instructions on how to run it. 

For more information about MozART, visit our Github Pages site here: https://uqmozart.github.io

## Requirements:
- Laptop or PC running Windows with a USB 3.0 port for the Kinect
- A Microsoft Kinect for Windows V2
- A frame and spandex built to the specifications listed on the website
- Adequate speakers compatible with your machine
- A tripod to support the Kinect
- A short-throw projector to display the visuals on the spandex
- Ableton Live 9.0 or above
- loopMidi running 6 virtual MIDI ports
- Processing 2.x (NOTE: Processing 3 is incompatible)

###Processing Requirements & Setup
To install the required libraries in Processing, follow these steps:
  1. Click 'Sketch'
  2. Hit 'Import Library'
  3. Go to 'Add Library...' at the top
  4. Search for the libraries and install them

All libraries are accessible by typing in the following names:
- Open Kinect for Processing
- MSAFluid
- BlobDetection
- TUIO Client
- The MidiBus
- oscP5

###File Structure
Contained within this repository are a number of different folders. In order to successfully run the project the files will need to remain within these folders due to Processing's requirements.

####MasterKinectSimulated
This folder contains the files required to run the master project without the use of a Kinect. Included in the inner data folder is an MP4 video which mimics touches with the Kinect. It is useful for testing and debugging without needing to set up the entire frame.

####MasterProject
This folder is the final version of the project developed by the team, it requires the Kinect to be set up at the very minimum, though also requires the frame setup for full testing.

####MasterVisuals
This folder contains the files for the visuals side of the project. Running these files in Processing whilst also running either MasterProject or MasterProjectSimulated will allow dynamic visuals to be generated in response to the blob detections.

