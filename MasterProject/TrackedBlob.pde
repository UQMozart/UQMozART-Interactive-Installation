
class TrackedBlob {
    private PApplet parent;
    
    //Need an ID for each blob to track them
    int id;
    
    //Store co-ordinates of centre point of blob
    int trackedBlobX;
    int trackedBlobY;
    
    //Store the distance travelled by the blob
    int distanceTravelled;
    
    //Store the number of frames the blob has been alive for
    int aliveTime;
    
    //Store the average speed of the blob (distance/aliveTime)
    int averageSpeed;
    
    //Co-ordinates 
    int blobX;
    int blobY;

    //Co-ordinates from the previous frame
    int previousXpos;
    int previousYpos;
    
    //Lifespan of blob after disappearing
    private int initTimer = 3;
    //Used to track the countdown
    public int timer;
    
    //Has the blob been matched or is it available?
    public boolean available;
    //Has the blob been marked to be deleted?
    public boolean delete;

    TrackedBlob(PApplet parent, int id, int trackedBlobX, int trackedBlobY) {
        this.parent = parent;
        this.id = id;
        //Set alive time to 1, since this is the first frame
        this.aliveTime = 1;
        //Set distance and speed to 0;
        this.distanceTravelled = 0;
        this.averageSpeed = 0;
        
        blobX = trackedBlobX;
        blobY = trackedBlobY;
        
        //Set the previous coordinates, since this is the first frame
        previousXpos = trackedBlobX;
        previousYpos = trackedBlobY;
        
        //All blobs should start as available
        available = true;
        //No blob should start already marked to be deleted
        delete = false;
        //Set the timer
        timer = initTimer;
    }
    
    void display() {
        textSize(18);
        //Add the ID label, offset so we can see it
        text("ID: " + this.id, blobX, blobY);
        textSize(14);
        text("x: " + getBlobX() + " y: " + getBlobY(), blobX + 10, blobY + 15);
        text("Speed: " + averageSpeed, blobX + 10, blobY + 35);
        text("Alive: " + aliveTime, blobX + 10, blobY + 55);
    }
    
    //Update location
    void update(int updateBlobX, int updateBlobY) {
        //Reset timer
        timer = initTimer;
        //increment the alivetime
        aliveTime++;
        //increment the distance travelled using previous and current blob locations
        distanceTravelled += dist(previousXpos, previousYpos, updateBlobX, updateBlobY);
        //set the new average speed
        averageSpeed = distanceTravelled/aliveTime;
        //Update the position
        blobX = updateBlobX;
        blobY = updateBlobY;
        //Store the current position so it can be reused
        previousXpos = getBlobX();
        previousYpos = getBlobY();
    }
    
    void countDown() {    
        timer--;
    }

    boolean dead() {
        if (timer < 0){
            return true;
        }
        else {
            return false;
        }
    }
    
    //Return the X centre point of the blob
    public int getBlobX() {
        return blobX;
    }
    
    //Return the Y centre point of the blob
    public int getBlobY() {
        return blobY;
    }    
    
    //Return the X centre point of the blob
    public int getID() {
        return id;
    }
 
    //Return the average speed of the blob
    public int getBlobSpeed() {
        return averageSpeed;
    }   
    
    //Return the alive Time of the blob
    public int getAliveTime() {
        return aliveTime;
    }
    
    //Return the depth of the centre point in the blob (semi-reliable)
    public int getDepth() {
        int x = getBlobX();
        int y = getBlobY();
        int rawDepth = depth[displayKinect.width - x - 1 + y * displayKinect.width];
        return rawDepth;
    }

}

