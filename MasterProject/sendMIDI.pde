
//We need to store the IDs of the blobs so we can match them
//We also need to store the channels they were sending to so we can
//keep sending the data to the right place

//left blob 1, left blob 2, middle blob 1, middle blob 2, right blob 1, right blob 2
//{blobID, MIDI channel/track/whatever should be 1-6 }
int[][] blobIDsAndChannels = {{0,1},{0,2},{0,3},{0,4},{0,5},{0,6}};

IntList leftBlobs = new IntList();
IntList middleBlobs = new IntList();
IntList rightBlobs = new IntList();

int leftCount = 0;
int middleCount = 0;
int rightCount = 0;

void blobsToMidi() {
    //First of all we want to store all the blobs in the right lists
    for (TrackedBlob blob : blobList) {
        //If blob is in left third of canvas
        if (blob.getBlobX() <= (width/3)){
            //Just check incase there are more than 5 blobs, we can ignore
            if(rightCount <= 4){
                //We want to add it's ID so we can check it in the next step
                leftBlobs.append(blob.getID());
                leftCount++;
            }
        }
        //If blob is in the middle
        else if (blob.getBlobX() > (width/3) && blob.getBlobX() <= ((width/3)*2)){
            if(middleCount <= 4){
                middleBlobs.append(blob.getID());
                middleCount++;
            }
        }
        //If blob is in the right third
        else {
            if(rightCount <= 4){
                rightBlobs.append(blob.getID());
                rightCount++;
            }  
        }
    }
    //Reset all the counts
    leftCount = 0;
    middleCount = 0;
    rightCount = 0;

// CHECK LEFT BLOBS
    int[] hasSentLeft = {0, 0};
   
    //For each blob in the leftBlobs list
    for (int i = 0; i < leftBlobs.size() ; i++) {
        for (int j = 0; j < 2; j++) {
            //Check if the blob ID from the leftBlobs list matches the blob ID stored
            if (blobIDsAndChannels[j][0] == leftBlobs.get(i) && leftBlobs.get(i) != 0){
                if (j == 0){
                    sendMIDI(midi1, leftBlobs.get(i), j+1);
                }
                else {
                    sendMIDI(midi2, leftBlobs.get(i), j+1);
                }
                hasSentLeft[j] = 1;
                leftBlobs.set(i, 0);
            }
        }
    }
   
    //Check element 0 and 1 in the blobIDsAndChannels array
    for (int j = 0; j < 2; j++) {
        //For each blob in the leftBlobs list
        for (int i = 0; i < leftBlobs.size() ; i++) {
            //If the track hasn't been sent, send a blob
            if (hasSentLeft[j] != 1 && leftBlobs.get(i) != 0){
                blobIDsAndChannels[j][0] = leftBlobs.get(i);
                hasSentLeft[j] = 1;
                leftBlobs.set(i, 0);
            }
        }
        
    }
    leftBlobs.clear();
    
// CHECK MIDDLE BLOBS    
    int[] hasSentMiddle = {0, 0};
   
    //For each blob in the middleBlobs list
    for (int i = 0; i < middleBlobs.size() ; i++) {
        for (int j = 0; j < 2; j++) {
            //Check if the blob ID from the middleBlobs list matches the blob ID stored
            if (blobIDsAndChannels[j + 2][0] == middleBlobs.get(i) && middleBlobs.get(i) != 0){
                //println(blobIDsAndChannels[j + 2][0] + " middle matches " + blobIDsAndChannels[j + 2][1]);
                if (j == 0){
                    sendMIDI(midi3, middleBlobs.get(i), j+3);
                }
                else {
                    sendMIDI(midi4, middleBlobs.get(i), j+3);
                }
                hasSentMiddle[j] = 1;
                middleBlobs.set(i, 0);
            }
        }
    }
   
    //Check element 2 and 3 in the blobIDsAndChannels array
    for (int j = 0; j < 2; j++) {
        //For each blob in the middleBlobs list
        for (int i = 0; i < middleBlobs.size() ; i++) {
            //If the track hasn't been sent, send a blob
            if (hasSentMiddle[j] != 1 && middleBlobs.get(i) != 0){
                blobIDsAndChannels[j + 2][0] = middleBlobs.get(i);
                hasSentMiddle[j] = 1;
                middleBlobs.set(i, 0);
            }
        }
    }
    middleBlobs.clear();
    
// CHECK RIGHT BLOBS    
    int[] hasSentRight = {0, 0};
   
    //For each blob in the rightBlobs list
    for (int i = 0; i < rightBlobs.size() ; i++) {
        for (int j = 0; j < 2; j++) {
            //Check if the blob ID from the rightBlobs list matches the blob ID stored
            if (blobIDsAndChannels[j + 4][0] == rightBlobs.get(i) && rightBlobs.get(i) != 0){
                //println(blobIDsAndChannels[j + 4][0] + " right matches " + blobIDsAndChannels[j + 4][1]);
                if (j == 0){
                    //midi1.sendNoteOn(1, 50, 50);
                    sendMIDI(midi5, rightBlobs.get(i), j+5);
                }
                else {
                    sendMIDI(midi6, rightBlobs.get(i), j+5);
                }
                hasSentRight[j] = 1;
                rightBlobs.set(i, 0);
            }
        }
    }
   
    //Check element 4 and 5 in the blobIDsAndChannels array
    for (int j = 0; j < 2; j++) {
        //For each blob in the rightBlobs list
        for (int i = 0; i < rightBlobs.size() ; i++) {
            //If the track hasn't been sent, send a blob
            if (hasSentRight[j] != 1 && rightBlobs.get(i) != 0){
                blobIDsAndChannels[j + 4][0] = rightBlobs.get(i);
                hasSentRight[j] = 1;
                rightBlobs.set(i, 0);
            }
        }
    }
    rightBlobs.clear();
}

void sendMIDI(MidiBus midiPort, int id, int channel) {
    for (TrackedBlob blob : blobList) {
        if(blob.getID() == id) {
             //Y axis NOTE
             float blobY = map((blob.getBlobY()-150), 0, 274, 0, 127);
             
             midiPort.sendNoteOn(1, int(blobY), 66); 
             
             //Depth
             int threshold = kinect.getThreshold();
             int blobDepth = blob.getDepth();
             //Need to map threshold as 0, max push in as 127
             //I've put it as 250mm for now, will need to adjust
             float depthVal = map(blobDepth, threshold, threshold - 250, 0, 127);
             midiPort.sendControllerChange(channel, 1, int(depthVal)); 
 
             //Lifespan (check if lifespan over 127 frames)
             int blobLifeSpan = 0;
             if (blob.getAliveTime() > 127) {
                 blobLifeSpan = 127;
             }
             else {
                 blobLifeSpan = blob.getAliveTime();
             }     
             midiPort.sendControllerChange(channel, 2, blobLifeSpan); 
             
             //Lifespan (limiting to 28 atm, will pick a better value when it's stable)
             float blobSpeed = 0;
             if (blob.getBlobSpeed() > 28) {
                 blobSpeed = 28;
             }
             else {
                 blobSpeed = blob.getBlobSpeed();
             }     
             midiPort.sendControllerChange(channel, 3, int(blobSpeed)); 
             
             //X axis position
             float blobX = map(blob.getBlobX(), 0, 512, 0, 127);
             midiPort.sendControllerChange(channel, 4, int(blobX)); 
             
             break;
        }
    }
   
}
