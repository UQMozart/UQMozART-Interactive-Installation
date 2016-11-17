//IN MSAfluidTUIO Demo
//add these variables
//  int sw = width/2 - 30;
//  int sh = height/2;

//make the if statement like this
//    if(millis() - lastTimeMovementDetected > 1000){ //1000 = 1 second, 10000=10 seconds
//    fluidSolver.reset();
//    textWrite(sw, sh);   
//   } 

int sw = width + 950;
int sh = height + 490;

void textWrite(int swidth, int sheight){
  
   sw = swidth;
   sh = sheight;
  //E at the end of Ensemble
        for(int x=sw-550; x < sw-490; x++){ particleSystem.addParticle(x,sh-30);
       } for(int x= sw-550; x < sw-490; x++){ particleSystem.addParticle(x,sh);
       } for(int x= sw-550; x < sw-490; x++){ particleSystem.addParticle(x,sh+30); 
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw-490,x); 
       };
       
         //second last letter, L
         for(int x= sw-480; x < sw-420; x++){ particleSystem.addParticle(x,sh+30); 
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw-420,x); 
       };
       
       //B
       for(int x=sw-410; x < sw-350; x++){ particleSystem.addParticle(x,sh-30);
       } for(int x= sw-410; x < sw-350; x++){ particleSystem.addParticle(x,sh);
       } for(int x= sw-410; x < sw-350; x++){ particleSystem.addParticle(x,sh+30); 
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw-410,x);
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw-350,x); 
       };
       
       //M
         for(int x=sw-340; x < sw-280; x++){ particleSystem.addParticle(x,sh-30);
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw-340,x);
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw-310,x); 
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw-280,x); 
       };
       
       //Middle E of ensemble
         for(int x=sw-270; x < sw-210; x++){ particleSystem.addParticle(x,sh-30);
       } for(int x= sw-270; x < sw-210; x++){ particleSystem.addParticle(x,sh);
       } for(int x= sw-270; x < sw-210; x++){ particleSystem.addParticle(x,sh+30); 
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw-210,x); 
       };
       
       //ensemble S
       for(int x=sw-200; x < sw-140; x++){ particleSystem.addParticle(x,sh-30);
       } for(int x= sw-200; x < sw-140; x++){ particleSystem.addParticle(x,sh);
       } for(int x= sw-200; x < sw-140; x++){ particleSystem.addParticle(x,sh+30); 
       } for(int x= sh; x < sh+30; x++){ particleSystem.addParticle(sw-200,x);
       } for(int x= sh-30; x < sh; x++){ particleSystem.addParticle(sw-140,x); 
       };
       
       //N
       for(int x=sw-130; x < sw-70; x++){ particleSystem.addParticle(x,sh-30);
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw-130,x);
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw-70,x); 
       };
       
       //First E in Ensemble
        for(int x=sw-60; x < sw; x++){ particleSystem.addParticle(x,sh-30);
       } for(int x= sw-60; x < sw; x++){ particleSystem.addParticle(x,sh);
       } for(int x= sw-60; x < sw; x++){ particleSystem.addParticle(x,sh+30); 
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw,x); 
       };
       
       //H
       for(int x=sw+60; x < sw+120; x++){ particleSystem.addParticle(x,sh);
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw+60,x); 
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw+120,x); 
       };
       
       //C
         for(int x=sw+130; x < sw+190; x++){ particleSystem.addParticle(x,sh-30);
       } for(int x= sw+130; x < sw+190; x++){ particleSystem.addParticle(x,sh+30); 
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw+190,x); 
       };
       
       //U
        for(int x=sw+200; x < sw+260; x++){ particleSystem.addParticle(x,sh+30);
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw+200,x); 
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw+260,x); 
       };
       
       //O
         for(int x=sw+270; x < sw+330; x++){ particleSystem.addParticle(x,sh-30);
       } for(int x=sw+270; x < sw+330; x++){ particleSystem.addParticle(x,sh+30);
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw+270,x); 
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw+330,x); 
       };
       
       //T
         for(int x=sw+340; x < sw+400; x++){ particleSystem.addParticle(x,sh-30);
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw+370,x); 
       };
       
       //Q
       for(int x=sw+460; x < sw+520; x++){ particleSystem.addParticle(x,sh-30);
       } for(int x=sw+460; x < sw+520; x++){ particleSystem.addParticle(x,sh+30);
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw+460,x); 
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw+520,x); 
       };
       
       int counter = sw+448;
       for(int x=sh+40; x > sh+10;x-=1){
         particleSystem.addParticle(counter,x);
         counter ++;
       };
       
        //U
        for(int x=sw+530; x < sw+590; x++){ particleSystem.addParticle(x,sh+30);
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw+530,x); 
       } for(int x= sh-30; x < sh+30; x++){ particleSystem.addParticle(sw+590,x); 
       }; 
       
}


//
//For hori}zontal, the x=the start of your line from the right, the number in x < number must be your x + line length (80).
//Then, add particle, the first number x, that is one again the start point of the line.  it has to be half the length of the line because of math but it will always be the 
//first particle from the right on the horizontal line.  The second number, the y is just the vertical height of this. it will usually be height/2 + or - something. 
//


//For vertical the first number x, that is the start point of the line going down vertically.  For example, an x=10 would start 10 pixels from the top of the screen.  The number
//in the x<number is the length of the line, so it will usually be +80 in this case, x+80, it has no control on the position only the length.
//Fir the add particle, the first number, the x-cordinate is literally just the horizontal position the line is on. Because it is a vertical it will be exact, eg you start at sw/2
//for a completed middle vertical line. The next number is just the start point of the line and it draws the length that you specifed earlier.
//ALL YOU NEED TO CHANGE IS THE X in addparticle(x,y)


//for a diagonal, take the same equation as the line that the verticle starts at and make the first number also an x. 

//opposite diagonal dont lose this shit its annoying as hell
// int counter = 100;
//       for(int x=100; x > 40;x-=1){
//         particleSystem.addParticle(counter,x);
//         counter ++;
//       };
//       counter = 100;
//       println(counter);
