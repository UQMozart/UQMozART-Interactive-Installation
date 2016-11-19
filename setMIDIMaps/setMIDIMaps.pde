import themidibus.*;
import controlP5.*;
ControlP5 cp5;
MidiBus midi1;
MidiBus midi2;
MidiBus midi3;
MidiBus midi4;
MidiBus midi5;
MidiBus midi6;

void setup() {
    midi1 = new MidiBus(this, 3, "midi1");
    midi2 = new MidiBus(this, 4, "midi2");
    midi3 = new MidiBus(this, 5, "midi3");
    midi4 = new MidiBus(this, 6, "midi4");
    midi5 = new MidiBus(this, 7, "midi5");
    midi6 = new MidiBus(this, 8, "midi6");
    midi1.list();
    
  size(450,450);
  noStroke();
  cp5 = new ControlP5(this);
  
  //MIDI Track 1
  cp5.addButton("depth1").setLabel("Map Depth").setPosition(20,30);
  cp5.addButton("lifespan1").setLabel("Map Lifespan").setPosition(100,30);
  cp5.addButton("speed1").setLabel("Map Speed").setPosition(180,30);
  cp5.addButton("x1").setLabel("Map X axis").setPosition(260,30);
  cp5.addButton("y1").setLabel("Send Test Note").setPosition(340,30);
  
  //MIDI Track 2
  cp5.addButton("depth2").setLabel("Map Depth").setPosition(20,100);
  cp5.addButton("lifespan2").setLabel("Map Lifespan").setPosition(100,100);
  cp5.addButton("speed2").setLabel("Map Speed").setPosition(180,100);
  cp5.addButton("x2").setLabel("Map X axis").setPosition(260,100);
  cp5.addButton("y2").setLabel("Send Test Note").setPosition(340,100);
  
  //MIDI Track 3
  cp5.addButton("depth3").setLabel("Map Depth").setPosition(20,170);
  cp5.addButton("lifespan3").setLabel("Map Lifespan").setPosition(100,170);
  cp5.addButton("speed3").setLabel("Map Speed").setPosition(180,170);
  cp5.addButton("x3").setLabel("Map X axis").setPosition(260,170);
  cp5.addButton("y3").setLabel("Send Test Note").setPosition(340,170);
  
  //MIDI Track 4
  cp5.addButton("depth4").setLabel("Map Depth").setPosition(20,240);
  cp5.addButton("lifespan4").setLabel("Map Lifespan").setPosition(100,240);
  cp5.addButton("speed4").setLabel("Map Speed").setPosition(180,240);
  cp5.addButton("x4").setLabel("Map X axis").setPosition(260,240);
  cp5.addButton("y4").setLabel("Send Test Note").setPosition(340,240);  
  
  //MIDI Track 5
  cp5.addButton("depth5").setLabel("Map Depth").setPosition(20,310);
  cp5.addButton("lifespan5").setLabel("Map Lifespan").setPosition(100,310);
  cp5.addButton("speed5").setLabel("Map Speed").setPosition(180,310);
  cp5.addButton("x5").setLabel("Map X axis").setPosition(260,310);
  cp5.addButton("y5").setLabel("Send Test Note").setPosition(340,310);
  
  //MIDI Track 6
  cp5.addButton("depth6").setLabel("Map Depth").setPosition(20,380);
  cp5.addButton("lifespan6").setLabel("Map Lifespan").setPosition(100,380);
  cp5.addButton("speed6").setLabel("Map Speed").setPosition(180,380);
  cp5.addButton("x6").setLabel("Map X axis").setPosition(260,380);
  cp5.addButton("y6").setLabel("Send Test Note").setPosition(340,380);  
}

void draw() {
  background(255);
  text("MIDI 1 Mappings", 20, 20);
  text("MIDI 2 Mappings", 20, 90);
  text("MIDI 3 Mappings", 20, 160);
  text("MIDI 4 Mappings", 20, 230);
  text("MIDI 5 Mappings", 20, 300);
  text("MIDI 6 Mappings", 20, 370);
  fill(50);
}
//Depth Mappings
public void depth1() {
    for (int i = 1; i <= 127; i++) {
        midi1.sendControllerChange(0, 1, i); 
    }
}
public void depth2() {
    for (int i = 1; i <= 127; i++) {
        midi2.sendControllerChange(1, 1, i); 
    }
}
public void depth3() {
    for (int i = 1; i <= 127; i++) {
        midi3.sendControllerChange(2, 1, i); 
    }
}
public void depth4() {
    for (int i = 1; i <= 127; i++) {
        midi4.sendControllerChange(3, 1, i); 
    }
}
public void depth5() {
    for (int i = 1; i <= 127; i++) {
        midi5.sendControllerChange(4, 1, i); 
    }
}
public void depth6() {
    for (int i = 1; i <= 127; i++) {
        midi6.sendControllerChange(5, 1, i); 
    }
}

//Lifespan Mappings
public void lifespan1() {
    for (int i = 1; i <= 127; i++) {
        midi1.sendControllerChange(0, 2, i); 
    }
}
public void lifespan2() {
    for (int i = 1; i <= 127; i++) {
        midi2.sendControllerChange(1, 2, i); 
    }
}
public void lifespan3() {
    for (int i = 1; i <= 127; i++) {
        midi3.sendControllerChange(2, 2, i); 
    }
}
public void lifespan4() {
    for (int i = 1; i <= 127; i++) {
        midi4.sendControllerChange(3, 2, i); 
    }
}
public void lifespan5() {
    for (int i = 1; i <= 127; i++) {
        midi5.sendControllerChange(4, 2, i); 
    }
}
public void lifespan6() {
    for (int i = 1; i <= 127; i++) {
        midi6.sendControllerChange(5, 2, i); 
    }
}

//Speed Mappings
public void speed1() {
    for (int i = 1; i <= 127; i++) {
        midi1.sendControllerChange(0, 3, i); 
    }
}
public void speed2() {
    for (int i = 1; i <= 127; i++) {
        midi2.sendControllerChange(1, 3, i); 
    }
}
public void speed3() {
    for (int i = 1; i <= 127; i++) {
        midi3.sendControllerChange(2, 3, i); 
    }
}
public void speed4() {
    for (int i = 1; i <= 127; i++) {
        midi4.sendControllerChange(3, 3, i); 
    }
}
public void speed5() {
    for (int i = 1; i <= 127; i++) {
        midi5.sendControllerChange(4, 3, i); 
    }
}
public void speed6() {
    for (int i = 1; i <= 127; i++) {
        midi6.sendControllerChange(5, 3, i); 
    }
}

//X axis Mappings
public void x1() {
    for (int i = 1; i <= 127; i++) {
        midi1.sendControllerChange(0, 4, i); 
    }
}
public void x2() {
    for (int i = 1; i <= 127; i++) {
        midi2.sendControllerChange(1, 4, i); 
    }
}
public void x3() {
    for (int i = 1; i <= 127; i++) {
        midi3.sendControllerChange(2, 4, i); 
    }
}
public void x4() {
    for (int i = 1; i <= 127; i++) {
        midi4.sendControllerChange(3, 4, i); 
    }
}
public void x5() {
    for (int i = 1; i <= 127; i++) {
        midi5.sendControllerChange(4, 4, i); 
    }
}
public void x6() {
    for (int i = 1; i <= 127; i++) {
        midi6.sendControllerChange(5, 4, i); 
    }
}

//Y axis test note
public void y1() {
    midi1.sendNoteOn(1, 50, 50); 
}
public void y2() {
    midi2.sendNoteOn(1, 50, 50); 
}
public void y3() {
    midi3.sendNoteOn(1, 50, 50); 
}
public void y4() {
    midi4.sendNoteOn(1, 50, 50); 
}
public void y5() {
    midi5.sendNoteOn(1, 50, 50); 
}
public void y6() {
    midi6.sendNoteOn(1, 50, 50); 
}

