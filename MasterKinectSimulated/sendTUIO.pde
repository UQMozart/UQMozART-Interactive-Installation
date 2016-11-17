
int frameNum = 0;
float[][] sendBlobs;
OscBundle oSCBundle;
float countDepth = 0;

float avgDepth = 0;
float avgTime = 0;
float avgSpeed = 0;

void sendTUIO() {
    oSCBundle = new OscBundle();
    OscMessage oSCMessage2 = null;
    OscMessage oSCMessage4 = null;
    OscMessage oSCMessage5 = null;
    OscMessage oSCMessage = new OscMessage("/tuio/2Dcur");
    oSCMessage.add("alive");

    //Iterate through every blob detected
    for (TrackedBlob blob : blobList) {
        oSCMessage.add(blob.getID());
    }

    oSCBundle.add(oSCMessage);

    for (TrackedBlob blob : blobList) {
        //Get the current blob
        float currentX = float(blob.getBlobX())/width;
        float currentY = float(blob.getBlobY())/height;

        float blobSpeed = 0;
        if (blob.getBlobSpeed() > 28) {
            blobSpeed = 28;
        } else {
            blobSpeed = blob.getBlobSpeed();
        }  
        avgSpeed += blobSpeed;

        float blobLifeSpan = 0f;
        if (blob.getAliveTime() > 127) {
            blobLifeSpan = 127;
        } else {
            blobLifeSpan = blob.getAliveTime();
        }     
        avgTime += blobLifeSpan;
        
        if (countDepth > 127){
            countDepth = 0;
        }
        avgDepth += countDepth;

        //currentY = (((currentY * 424f) - 150f) /274f);

        oSCMessage2 = new OscMessage("/tuio/2Dcur");
        oSCMessage2.add("set");
        oSCMessage2.add(blob.getID());
        oSCMessage2.add(currentX);
        oSCMessage2.add(currentY);
        oSCMessage2.add(0f);
        oSCMessage2.add(0f);
        oSCMessage2.add(float(2));
        oSCBundle.add(oSCMessage2);
        
        countDepth++;
    }

    OscMessage oSCMessage3 = new OscMessage("/tuio/2Dcur");
    oSCMessage3.add("fseq");
    oSCMessage3.add(frameNum);
    oSCBundle.add(oSCMessage3);
    oscP5Location1.send(oSCBundle, location2);
    frameNum++;
    
    if (blobList.size() > 0) {
        avgDepth = avgDepth / blobList.size();
        avgTime = avgTime / blobList.size();
        avgSpeed = avgSpeed / blobList.size();
    }
    
    oscP5Averages.send("/blobdata", new Object[] {avgSpeed, avgTime, avgDepth}, netAddressAverages);
    
    avgDepth = 0;
    avgTime = 0;
    avgSpeed = 0;
}

