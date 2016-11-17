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

void drawBlobsAndEdges(boolean drawBlobs, boolean drawEdges, BlobDetection newBlobList) {
    noFill();
    Blob b;
    EdgeVertex eA, eB;
    for (int n = 0; n < newBlobList.getBlobNb(); n++) {
        b = newBlobList.getBlob(n);
        if (b != null && b.h > 0) {
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
