
class KinectData {
    // Depth threshold
    int depthThreshold = 750;
    
    //Kinect2 class
    Kinect2 kinect2;

    KinectData(PApplet pa) {
        kinect2 = new Kinect2(pa);
        //Initialise the depth and device
        kinect2.initDepth();
        kinect2.initDevice();
        //Create a new image to hold the depth data
        displayKinect = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);
        //Create a new list of blobs to store the blob detection results in
        newBlobList = new BlobDetection(kinect2.depthWidth, kinect2.depthHeight);
        newBlobList.setPosDiscrimination(true);
        newBlobList.setThreshold(0.3f);
    }
    
    void display() {
        // Retrieve array of depth integers
        depth = kinect2.getRawDepth();
        // Retrieve depth image from Kinect
        PImage depthImg = kinect2.getDepthImage();
        // Being overly cautious here
        if (depth == null || depthImg == null) return;
        // Loads the pixel data for the display window into the pixels[] array
        displayKinect.loadPixels();
        // For each pixel horizontally...
        for (int x = 0; x < kinect2.depthWidth; x++) {
            // Check each pixel in the corrosponding vertical row
            for (int y = 0; y < kinect2.depthHeight; y++) {
                // Mirror the image
                int offset = (kinect2.depthWidth - x - 1) + y * kinect2.depthWidth;
                // Raw depth
                int rawDepth = depth[offset];
                int pix = x + y * displayKinect.width;
                // If infront of the threshold, change the colour of the pixel
                // Since we are only using this for blob detection, you will never actually see this colour
                if (rawDepth > 0 && rawDepth < depthThreshold) {
                    displayKinect.pixels[pix] = color(150, 50, 50);
                } 
                // If not infront of threshold, just make it black
                else {
                    displayKinect.pixels[pix] = color(0);
                }
            }
        }
        // Updates the display window with the data in the pixels[] array
        displayKinect.updatePixels();
        blurAlgorithm(displayKinect, 10);
        //Compute the blobs for the current frame after the blur has been applied
        newBlobList.computeBlobs(displayKinect.pixels);
        drawBlobsAndEdges(true, true, newBlobList);
        detectBlobs(newBlobList);
    }
    
    // Return the depth threshold
    int getThreshold() {
        return depthThreshold;
    }
    // Change the depth threshold
    void setThreshold(int t) {
        depthThreshold = t;
    }
}
