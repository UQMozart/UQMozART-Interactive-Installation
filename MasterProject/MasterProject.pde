/******************************************************************************
 Copyright (c) 2016, Astrid Farmer, Daniel Fraser, Melinda Piper, Naomi Mason
 *
 * Project Site: https://uqmozart.github.io ***
 *
 * Permission is hereby granted, free of charge, to any person obtaining a 
 * copy of this software and associated documentation files (the "Software"), 
 * to deal in the Software without restriction, including without limitation 
 * the rights to use, copy, modify, merge, publish, distribute, sublicense, 
 * and/or sell copies of the Software, and to permit persons to whom the 
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included 
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
 * THE SOFTWARE.
 *
 * ****************************************************************************/ 

import org.openkinect.processing.*;
import blobDetection.*;
import processing.video.*;
import oscP5.*;
import netP5.*;
import themidibus.*;

//Create the midibus ports
MidiBus midi1;
MidiBus midi2;
MidiBus midi3;
MidiBus midi4;
MidiBus midi5;
MidiBus midi6;

//Kinect object
KinectData kinect;
//Image that holds each frame from the kinect
PImage displayKinect;
//Create instance of blobdetection
BlobDetection newBlobList;

//Set up osc location
OscP5 oscP5Location1;
//Set up osc net address
NetAddress location2;
//New OSC location & net address for averaged values
OscP5 oscP5Averages;
NetAddress netAddressAverages;

//Total number of blobs so far, we use this as an identifier
int currentBlobID = 1;

//Arraylist of persisting blobs
ArrayList<TrackedBlob> blobList;

// Depth data
int[] depth;

void setup() {
    frameRate(30);
    size(512, 424, P2D);
    kinect = new KinectData(this);
    blobList = new ArrayList<TrackedBlob>();
    
    oscP5Location1 = new OscP5(this, 3334);
    location2 = new NetAddress("127.0.0.1", 3333);
    oscP5Averages = new OscP5(this, 32000);
    netAddressAverages = new NetAddress("127.0.0.1", 12000);
    
    //May need to change this for your computer, look at the outputs from the
    //line above, and change the third parameter to the port you want
    midi1 = new MidiBus(this, 3, "midi1");
    midi2 = new MidiBus(this, 4, "midi2");
    midi3 = new MidiBus(this, 5, "midi3");
    midi4 = new MidiBus(this, 6, "midi4");
    midi5 = new MidiBus(this, 7, "midi5");
    midi6 = new MidiBus(this, 8, "midi6");
    midi1.list();
}

void draw() {
    background(0);
    //Display the Kinect image
    kinect.display();
    
    //Display Blob Info
    for (TrackedBlob blob : blobList) {
        blob.display();
    }
    //Send MIDI data for the blobs
    blobsToMidi();
    //Send TUIO data for the blobs to the visuals
    sendTUIO();
    //Display the threshold on the screen
    int threshold = kinect.getThreshold();
    fill(235);
    text("threshold: " + threshold, 30, 400);
}

// Adjust the threshold with key presses
void keyPressed() {
  int t = kinect.getThreshold();
  if (key == CODED) {
    if (keyCode == UP) {
      t +=5;
      kinect.setThreshold(t);
    } else if (keyCode == DOWN) {
      t -=5;
      kinect.setThreshold(t);
    }
  }
}

