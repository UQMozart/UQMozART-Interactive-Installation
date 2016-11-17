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

import blobDetection.*;
import processing.video.*;
import themidibus.*;
import oscP5.*;
import netP5.*;

//Create the midibus port
MidiBus midi1;
MidiBus midi2;
MidiBus midi3;
MidiBus midi4;
MidiBus midi5;
MidiBus midi6;

//Create the video object
Movie video;

//Create instance of blobdetection
BlobDetection newBlobList;

//Set up osc location
OscP5 oscP5Location1;

//Set up osc net address
NetAddress location2;

//New OSC location & net address for averaged values
OscP5 oscP5Averages;
NetAddress netAddressAverages;

//Image which will contain each frame of the video
PImage videoinput;

//Total number of blobs so far, we use this as an identifier
int currentBlobID = 1;

//Arraylist of persisting blobs
ArrayList<TrackedBlob> blobList;

void setup() {
    size(512, 428, P2D);
    
    video = new Movie(this, "c.mp4");
    video.loop();  
    video.play();
    
    videoinput = createImage(512, 428, RGB);

    newBlobList = new BlobDetection(512, 428);
    newBlobList.setPosDiscrimination(true);
    newBlobList.setThreshold(0.1f);
    blobList = new ArrayList<TrackedBlob>();
    
    oscP5Location1 = new OscP5(this, 3334);
    location2 = new NetAddress("127.0.0.1", 3333);
    oscP5Averages = new OscP5(this, 32000);
    netAddressAverages = new NetAddress("127.0.0.1", 12000);
    
    //May need to change this for your computer
    midi1 = new MidiBus(this, 3, "midi1");
    midi2 = new MidiBus(this, 4, "midi2");
    midi3 = new MidiBus(this, 5, "midi3");
    midi4 = new MidiBus(this, 6, "midi4");
    midi5 = new MidiBus(this, 7, "midi5");
    midi6 = new MidiBus(this, 8, "midi6");
    midi1.list();
}

void draw() {
    //Just use a white background, you can change it and be more funky if you like...
    background(0);

    //If the video is available, copy the current frame into the image, accounting for the
    //extra white space at the top
    if (video.available()) {
        video.read();
        videoinput.copy(video, 0, 15, 512, 428, 0, 15, 512, 428);
    }
    
    //Appy the blur algorithm to the video so that tiny blobs don't cause problems
    blurAlgorithm(videoinput, 10);
    //Compute the blobs for the current frame after the blur has been applied
    newBlobList.computeBlobs(videoinput.pixels);

    detectBlobs(newBlobList);
    drawBlobsAndEdges(true, true, newBlobList);
    
    //Display Blob Info
    for (TrackedBlob blob : blobList) {
        blob.display();
    }
    
    blobsToMidi();
    sendTUIO();
}

