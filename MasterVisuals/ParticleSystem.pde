/***********************************************************************
 
 Copyright (c) 2008, 2009, Memo Akten, www.memo.tv
 *** The Mega Super Awesome Visuals Company ***
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of MSA Visuals nor the names of its contributors 
 *       may be used to endorse or promote products derived from this software
 *       without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS 
 * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE. 
 *
 * ***********************************************************************/ 

import java.nio.FloatBuffer;
import com.sun.opengl.util.*;
import java.util.*;
import oscP5.*;
import netP5.*;

boolean renderUsingVA = false;

    float x, y;
    
//Average speed of all current blobs
//Will be set to 0 when no blobs
//Otherwise, it will be between 0 and 28 (as a Float)
float speedId = averageSpeed;

    void init(float x, float y) {
        this.x = x;
        this.y = y;

    }

void fadeToColor(GL2 gl, float r, float g, float b, float speed) {
    gl.glBlendFunc(gl.GL_SRC_ALPHA, gl.GL_ONE_MINUS_SRC_ALPHA);
    gl.glColor4f(r, g, b, speed);
    gl.glBegin(gl.GL_QUADS);
    gl.glVertex2f(0, 0);
    gl.glVertex2f(width, 0);
    gl.glVertex2f(width, height);
    gl.glVertex2f(0, height);
    gl.glEnd();
}

class ParticleSystem {
    FloatBuffer posArray;
    FloatBuffer colArray;
    final static int maxParticles = 5000;
    final static int maxParticlesS = 5000;

    int curIndex;
    int curIndexS;
    Particle[] particles;
    Particle[] particlesS;
    
     //make the maxParticlesLeft, because there are technically 2 particle systems they should be half 5000 so 2500 each but I just have them at 1000 cause whatever. 
    final static int maxParticlesleft = 5000;
    final static int maxParticlesleftS = 5000;
    final static int maxParticlesmid = 5000;
    final static int maxParticlesmidS = 5000;
    //create another Index counter
    int curIndexleft;
    int curIndexleftS;
    int curIndexmid;
    int curIndexmidS;
    //create another aprticle array
    Particle[] particlesleft;
    Particle[] particlesleftS;
    Particle[] particlesmid;
    Particle[] particlesmidS;
    
    ParticleSystem() {
        particles = new Particle[maxParticles];
        for(int i=0; i<maxParticles; i++) particles[i] = new Particle();
        curIndex = 0;
        
        particlesS = new Particle[maxParticles];
        for(int i=0; i<maxParticles; i++) particlesS[i] = new Particle();
        curIndexS = 0;
        
        //instantiate the array you just made 
        particlesleft = new Particle[maxParticles];
         //add another checker to see if the new array has reached max particle count
        for(int i=0; i<maxParticles; i++) particlesleft[i] = new Particle();
        //make newIndex to 0
        curIndexleft = 0;
        
        //instantiate the array you just made 
        particlesleftS = new Particle[maxParticles];
         //add another checker to see if the new array has reached max particle count
        for(int i=0; i<maxParticles; i++) particlesleftS[i] = new Particle();
        //make newIndex to 0
        curIndexleftS = 0;
        
        //instantiate the array you just made 
        particlesmid = new Particle[maxParticles];
         //add another checker to see if the new array has reached max particle count
        for(int i=0; i<maxParticles; i++) particlesmid[i] = new Particle();
        //make newIndex to 0
        curIndexmid = 0;
        
        //instantiate the array you just made 
        particlesmidS = new Particle[maxParticles];
         //add another checker to see if the new array has reached max particle count
        for(int i=0; i<maxParticles; i++) particlesmidS[i] = new Particle();
        //make newIndex to 0
        curIndexmidS = 0;
        
        
        posArray = BufferUtil.newFloatBuffer(maxParticles * 2 * 2);// 2 coordinates per point, 2 points per particle (current and previous)
        colArray = BufferUtil.newFloatBuffer(maxParticles * 3 * 2);
    }


    void updateAndDraw(){
        //OPENGL Processing 2.1
        PGL pgl;                                  // JOGL's GL object
        pgl = beginPGL();
        GL2 gl = ((PJOGL)pgl).gl.getGL2();       // processings opengl graphics object               
        
        gl.glEnable( GL2.GL_BLEND );             // enable blending
        
        if(!drawFluid) fadeToColor(gl, 0, 0, 0, 0.05);
        gl.glBlendFunc(GL2.GL_ONE, GL2.GL_ONE);  // additive blending (ignore alpha)
        gl.glEnable(GL2.GL_LINE_SMOOTH);        // make points round
        gl.glLineWidth(1);
        
                if(renderUsingVA) {
            for(int i=0; i<maxParticles; i++) {
                if(particles[i].alpha > 0) {
                    particles[i].update();
                    if (averageSpeed >= 16) {
                    particles[i].updateVertexArrays8(i, posArray, colArray);
                    } else if(averageSpeed < 16 & averageDepth < 70){
                      particles[i].updateVertexArrays6(i, posArray, colArray);
                    }else if(averageSpeed < 16 & averageDepth > 70){
                      particles[i].updateVertexArrays(i, posArray, colArray);
                    }
                }
            }    
            gl.glEnableClientState(GL2.GL_VERTEX_ARRAY);
            gl.glVertexPointer(2, GL2.GL_FLOAT, 0, posArray);
            gl.glEnableClientState(GL2.GL_COLOR_ARRAY);
            gl.glColorPointer(3, GL2.GL_FLOAT, 0, colArray);
            gl.glDrawArrays(GL2.GL_LINES, 0, maxParticles * 2);
        } 
        else {


            gl.glBegin(gl.GL_LINES);               // start drawing points
            for(int i=0; i<maxParticles; i++) {
                if(particles[i].alpha > 0) {
                    particles[i].update();
                    particles[i].drawOldSchool(gl);    // use oldschool renderng
                }
            }
            
            for(int i=0; i<maxParticlesS; i++) {
                if(particlesS[i].alpha > 0) {
                    particlesS[i].update2();
                    particlesS[i].drawOldSchoolS(gl);    // use oldschool renderng
                }
            }
            
        //Add this whole method, basically just adding/updating/drawing for the new, second particle array
        for(int i=0; i<maxParticlesleft; i++) {
            if(particlesleft[i].alpha > 0) {
                particlesleft[i].update();
                particlesleft[i].drawOldSchoolleft(gl); //dont forget to make this new method in Particle
            }
        }
        
         //Add this whole method, basically just adding/updating/drawing for the new, second particle array
        for(int i=0; i<maxParticlesleftS; i++) {
            if(particlesleftS[i].alpha > 0) {
                particlesleftS[i].update2();
                particlesleftS[i].drawOldSchoolleftS(gl); //dont forget to make this new method in Particle
            }
        }
        
        for(int i=0; i<maxParticlesmid; i++) {
            if(particlesmid[i].alpha > 0) {
                particlesmid[i].update();
                particlesmid[i].drawOldSchoolmid(gl); //dont forget to make this new method in Particle
            }
        }
        
       for(int i=0; i<maxParticlesmidS; i++) {
            if(particlesmidS[i].alpha > 0) {
                particlesmidS[i].update2();
                particlesmidS[i].drawOldSchoolmidS(gl); //dont forget to make this new method in Particle
            }
        }
        
        gl.glEnd();
        gl.glDisable(GL2.GL_BLEND);
        endPGL();

  }
    }
    
     void updateAndDraw2(){
        //OPENGL Processing 2.1
        PGL pgl;                                  // JOGL's GL object
        pgl = beginPGL();
        GL2 gl = ((PJOGL)pgl).gl.getGL2();       // processings opengl graphics object               
        
        gl.glEnable( GL2.GL_BLEND );             // enable blending
        
        if(!drawFluid) fadeToColor(gl, 0, 0, 0, 0.05);

        gl.glBlendFunc(GL2.GL_ONE, GL2.GL_ONE);  // additive blending (ignore alpha)
        gl.glEnable(GL2.GL_LINE_SMOOTH);        // make points round
        gl.glLineWidth(1);
        
         if(renderUsingVA) {
            for(int i=0; i<maxParticles; i++) {
                if(particles[i].alpha > 0) {
                    particles[i].update2();
                    if (averageSpeed >= 16) {
                    particles[i].updateVertexArrays5(i, posArray, colArray);
                    } else {
                      particles[i].updateVertexArrays(i, posArray, colArray);
                    }
                
                }
            }    
            gl.glEnableClientState(GL2.GL_VERTEX_ARRAY);
            gl.glVertexPointer(2, GL2.GL_FLOAT, 0, posArray);

            gl.glEnableClientState(GL2.GL_COLOR_ARRAY);
            gl.glColorPointer(3, GL2.GL_FLOAT, 0, colArray);

            gl.glDrawArrays(GL2.GL_LINES, 0, maxParticles * 2);
        } 
        else {
  
            gl.glBegin(gl.GL_LINES);               // start drawing points
            for(int i=0; i<maxParticles; i++) {
                if(particles[i].alpha > 0) {
                    particles[i].update2();
                    particles[i].drawOldSchool(gl);    // use oldschool renderng
                }
            }
            
            for(int i=0; i<maxParticlesS; i++) {
                if(particlesS[i].alpha > 0) {
                    particlesS[i].update2();
                    particlesS[i].drawOldSchoolS(gl);    // use oldschool renderng
                }
            }
            
        //Add this whole method, basically just adding/updating/drawing for the new, second particle array
        for(int i=0; i<maxParticlesleft; i++) {
            if(particlesleft[i].alpha > 0) {
                particlesleft[i].update2();
                  particlesleft[i].drawOldSchoolleft(gl); //dont forget to make this new method in Particle
               
            }
        }
        
         //Add this whole method, basically just adding/updating/drawing for the new, second particle array
        for(int i=0; i<maxParticlesleftS; i++) {
            if(particlesleftS[i].alpha > 0) {
                particlesleftS[i].update2();
                particlesleftS[i].drawOldSchoolleftS(gl); //dont forget to make this new method in Particle
            }
        }
        
        for(int i=0; i<maxParticlesmid; i++) {
            if(particlesmid[i].alpha > 0) {
                particlesmid[i].update2();
                particlesmid[i].drawOldSchoolmid(gl); //dont forget to make this new method in Particle
            }
        }
        
        for(int i=0; i<maxParticlesmidS; i++) {
            if(particlesmidS[i].alpha > 0) {
                particlesmidS[i].update2();
                particlesmidS[i].drawOldSchoolmidS(gl); //dont forget to make this new method in Particle
            }
        }
        
        gl.glEnd();
        gl.glDisable(GL2.GL_BLEND);
        endPGL();
    }  
     }



   void addParticles(float x, float y, int count ){
        for(int i=0; i< count; i++) {
          
         if(x <= (width*1/3)){   
                     
           if(averageSpeed > 12){
             addParticleleftS(x + random(-15, 15), y + random(-15, 15));
           } else {  
          addParticleleft(x + random(-15, 15), y + random(-15, 15));
           }
         } 
         
         else if(x > (width*(1/3)) && x <= (width*2/3)) {
           if(averageSpeed > 12){
           addParticlemidS(x + random(-15, 15), y + random(-15, 15)); 
           } else {
          addParticlemid(x + random(-15, 15), y + random(-15, 15)); 
         } 
         }
         
         else if (x > (width*2/3) && x <= width){
           if(averageSpeed > 12){
             addParticleS(x + random(-15, 15), y + random(-15, 15));
           } else {
          addParticle(x + random(-15, 15), y + random(-15, 15)); 
         }
        
        }  
        } 
    }
    

    void addParticle(float x, float y) {
        particles[curIndex].init(x, y);
        curIndex++;
        if(curIndex >= maxParticles) curIndex = 0;
    }
    
        void addParticleS(float x, float y) {
        particlesS[curIndexS].init(x, y);
        curIndexS++;
        if(curIndexS >= maxParticlesS) curIndexS = 0;
    }
    
     void addParticleleft(float x, float y) {
        particlesleft[curIndexleft].init(x, y);
        curIndexleft++;
        if(curIndexleft >= maxParticlesleft) curIndexleft = 0;
    }
    
         void addParticleleftS(float x, float y) {
        particlesleftS[curIndexleftS].init(x, y);
        curIndexleftS++;
        if(curIndexleftS >= maxParticlesleftS) curIndexleftS = 0;
    }
    
         void addParticlemid(float x, float y) {
        particlesmid[curIndexmid].init(x, y);
        curIndexmid++;
        if(curIndexmid >= maxParticlesmid) curIndexmid = 0;
    }
    
             void addParticlemidS(float x, float y) {
        particlesmidS[curIndexmidS].init(x, y);
        curIndexmidS++;
        if(curIndexmidS >= maxParticlesmidS) curIndexmidS = 0;
    }
}








