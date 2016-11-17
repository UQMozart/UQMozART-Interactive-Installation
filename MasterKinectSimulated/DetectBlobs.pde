
void detectBlobs(BlobDetection newBlobList) {
    //Create a new tracked blob for each of these blobs
            
    //Case 1: The list of blobs is empty, so we either just started or there have been no recent blobs
    //Solution: Track every blob
    if (blobList.isEmpty()) {
        Blob b;
        for (int i = 0; i < newBlobList.getBlobNb(); i++) {
            b = newBlobList.getBlob(i);
            //Add blob to the list
            blobList.add(new TrackedBlob(this, currentBlobID, int(b.x * width), int(b.y * height)));
            //Increment total blobs
            currentBlobID++;
        }
    } 
            
    //Case 2: There are more blobs in the new frame than there were in the last frame, so we have new blobs!
    //Solution: Find the closest ones to the previous blobs and update their locations, then add the rest
    else if (blobList.size() <= newBlobList.getBlobNb()) {
        //Let's record used blobs so they don't get matched twice
        boolean[] used = new boolean[newBlobList.getBlobNb()];
        
        //For each blob in the old list...
        for (TrackedBlob tb : blobList) {
            float record = 50000;
            int index = -1;
            
            //For each blob in the new list....
            for (int i = 0; i < newBlobList.getBlobNb(); i++) {
    
                //Find the distance between the blobs
                float d = dist(int(newBlobList.getBlob(i).x * width), int(newBlobList.getBlob(i).y * height), tb.getBlobX(), tb.getBlobY());
                //If the distance is closer than previous distances and the blob isn't already used
                if (d < record && !used[i]) {
                    //Record the new closest distance
                    record = d;
                    //Record the index of the current closest
                    index = i;
                }
            }
            //Mark the blob as being used
            used[index] = true;
            //Update the blob location
            tb.update(int(newBlobList.getBlob(index).x * width), int(newBlobList.getBlob(index).y * height));
        }
        
        //Draw in any blobs that are new and were not matched
        for (int i = 0; i < newBlobList.getBlobNb(); i++) {
            if (!used[i]) {
                //Add blob to the list
                blobList.add(new TrackedBlob(this, currentBlobID, int(newBlobList.getBlob(i).x * width), int(newBlobList.getBlob(i).y * height)));
               //Increment total blobs
                currentBlobID++;
            }
        }
    } 
            
    //Case 3: There are less blobs in the new frame than there were in the last frame, so some have gone
    //Solution: Find the closest ones to the previous blobs and update their locations, delete the rest
    else {
        for (TrackedBlob tb : blobList) {
            tb.available = true;
        } 
        //For each blob in the new list...
        for (int i = 0; i < newBlobList.getBlobNb(); i++) {
        
            float record = 50000;
            int index = -1;
             
             //For each blob in the old list...
            for (int j = 0; j < blobList.size (); j++) {
                TrackedBlob tb = blobList.get(j);
                 
                //Find the distance between the blobs
                float d = dist(newBlobList.getBlob(i).x * width, newBlobList.getBlob(i).y * height, tb.getBlobX(), tb.getBlobY());
                
                //If the distance is closer than previous distances and the blob is available
                if (d < record && tb.available) {
                    //Record the new closest distance
                    record = d;
                    //Record the index of the current closest
                    index = j;
                }
            }
            //Get the closest blob
            TrackedBlob tb = blobList.get(index);
            //Mark the blob as unavailable
            tb.available = false;
            //Update the blob location
            tb.update(int(newBlobList.getBlob(i).x * width), int(newBlobList.getBlob(i).y * height));
        } 
        //Begin countdown to kill any left over blobs
        for (TrackedBlob tb : blobList) {
            if (tb.available) {
                tb.countDown();
                if (tb.dead()) {
                    tb.delete = true;
                }
            }
        }
    }
            
    //Delete blobs that aren't used
    for (int i = blobList.size ()-1; i >= 0; i--) {
        TrackedBlob tb = blobList.get(i);
        if (tb.delete) {
            if (tb.getID() == blobIDsAndChannels[0][0]) {
                midi1.sendNoteOff(1, 0, 0);
            } 
            else if (tb.getID() == blobIDsAndChannels[1][0]) {
                midi2.sendNoteOff(1, 0, 0);
            } 
            else if (tb.getID() == blobIDsAndChannels[2][0]) {
                midi3.sendNoteOff(1, 0, 0);
            } 
            else if (tb.getID() == blobIDsAndChannels[3][0]) {
                midi4.sendNoteOff(1, 0, 0);
            } 
            else if (tb.getID() == blobIDsAndChannels[4][0]) {
                midi5.sendNoteOff(1, 0, 0);
            } 
            else if (tb.getID() == blobIDsAndChannels[5][0]) {
                midi6.sendNoteOff(1, 0, 0);
            }
            blobList.remove(i);
        }
    }
}
