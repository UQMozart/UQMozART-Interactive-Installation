//Draw the blobs on the screen which are detected from the blurred kinect depth image
void drawBlobsAndEdges(boolean drawBlobs, boolean drawEdges, BlobDetection newBlobList) {
    noFill();
    Blob b;
    EdgeVertex eA, eB;
    for (int n = 0; n < newBlobList.getBlobNb(); n++) {
        b = newBlobList.getBlob(n);
        if (b != null && (b.h  > 0)) {
            if (drawEdges) {
                strokeWeight(3);
                stroke(0, 0, 255);
                for (int m = 0; m < b.getEdgeNb(); m++) {
                    eA = b.getEdgeVertexA(m);
                    eB = b.getEdgeVertexB(m);
                    if (eA != null && eB != null) {
                        line(eA.x * width, eA.y * height, eB.x * width, eB.y * height);
                    }
                }
            }
            if (drawBlobs) {
                strokeWeight(1);
                stroke(255, 0, 0);
                rect(b.xMin * width, b.yMin * height, b.w * width, b.h * height);
            }
        }
    }
}
