//Soucrces: https://www.geeksforgeeks.org/breadth-first-search-or-bfs-for-a-graph/
//Sources: https://docs.google.com/presentation/d/1_PFcKPQS5BDTEpIdGvDIW9M-vm2EWYxohHyCRSrWw1M/edit#
//Sources: BFS code from class
//Sources: https://www.youtube.com/watch?v=mhjuuHl6qHM
//https://www.red3d.com/cwr/boids/

        float steeringx;
        float steeringy;
        float avglocx;
        float avglocy;

        int radiusOfPercep = 50;  //align for radius within this distance
                                  //if the radius of perception is the size of the canvas then the boids start having the same velocity
BOID boid1;
BOID boid2;
AGENT[] agent1; //stores agents
int numAgents =  200


; //100; //3; //50; //10; //10; //100;

float agentxposit = 50;
float agentyposit = 750;

float goalx = 750;
float goaly = 50;
int radius = 100;
int agentAndTargetRadius = 25;
float xsphere = 400;
float ysphere = 400;
float xpoint;
float ypoint;
//int numpoints = 13; //first two elements are agents; the last 1 elment is the goal. The other 10 are the nodes //play around with num of points; more points leads to possibility of finding the ideal path
int numpoints = 25; //25; //These make up the "pit stops" 
float[] xpoints = new float[numpoints]; 
float[] ypoints = new float[numpoints];


void setup(){
    size(800, 800, P3D);
    agent1 = new AGENT[numAgents];
  
    // findpoints();
    
    //float boid1vx = random(-20, 20);
    //float boid1vy = random(-20, 20);
     float boid1vx = random(-5, 5);
    float boid1vy = random(-5, 5);
    //boid1 = new BOID( 400, 600, boid1vx, boid1vy);
    //boid2 = new BOID(425, 650, boid1vx, boid1vy );
    
    //start boids at random spots; they want to find each other
    boid1 = new BOID( random(width), 25, boid1vx, boid1vy);
   // boid1 = new BOID( mouseX, mouseY, boid1vx, boid1vy);
    boid2 = new BOID(random(width), 650, boid1vx, boid1vy);
    
    boid1.c = #8CD9F0;
    boid2.c = #B931C9; //purple
    
    //boid1.speed  = 15;
    for(int i = 0; i < numAgents; i++){
      
     
      //agent1[i] = new AGENT(xpoints, ypoints, agentxposit, agentyposit);
      //agent1[i] = new AGENT(xpoints, ypoints, random(50,750), random(50, 750));
    // agent1[i] = new AGENT(xpoints, ypoints, random(width), random(height));
      agent1[i] = new AGENT(random(width), random(height));

     // agent1[i] = new AGENT(xpoints, ypoints, random(0,600), random(0, 600));
      //agent1[i] = new AGENT(xpoints, ypoints, random(50,750), random(400, 750));

     
      println(agent1[i].xP);
      println(agent1[i].yP);
      println(agent1[i].arrayofXpoints);
      agent1[i].bfs();
      agent1[i].nextNode = agent1[i].path.size()-2;
  }
}

void draw() {

  background(255, 255, 255);
  
        if(mousePressed){
              boid1.xP = mouseX;
              boid1.yP = mouseY;
          
          }
  
    pushMatrix();
    fill(boid1.c);
    //translate(mouseX, mouseY);
    //circle(mouseX, mouseY,  agentAndTargetRadius*.95);
     circle(boid1.xP, boid1.yP,  agentAndTargetRadius*.95);
    popMatrix();
    
    pushMatrix();
    fill(boid2.c);
    circle(boid2.xP, boid2.yP,  agentAndTargetRadius*.75);
    popMatrix();
    
    boid1.edges();
    boid2.edges();
    //align1(boid1); 
    //cohesion1(boid1);
    separation1(boid1);
    
    //align1(boid2); 
    //cohesion1(boid2);
    separation1(boid2);

    boid1.updateposit(1/frameRate);
    boid2.updateposit(1/frameRate);
    updateboidvel();
    
    
  //if( distance(boid1.xP, boid1.yP, boid2.xP, boid2.yP) > 100 ){
 
  //             //boid1.xP = boid2.xP - 25;
  //             //boid1.yP = boid2.yP - 25;
  //               boid1.vx = boid1.xP - boid2.xP;
  //               boid1.vy = boid1.yP - boid2.yP;
  //              float len = sqrt(boid1.vx*boid1.vx + boid1.vy*boid1.vy);
                       
  //                boid1.vx = boid1.vx/len;
  //                boid1.vy = boid1.vy/len;
                  
  //                boid1.xP += boid1.vx*boid1.speed*frameRate;
  //                boid1.yP += boid1.vy*boid1.speed*frameRate;
                 
  //                //vx += xAcc*dt;
  //                //vy += yAcc*dt;
                
  //            }

    
    
  
  
  //if( nextNode >= 0){
  for(int i = 0; i < numAgents; i++){
       
      agent1[i].edges();
      align(agent1[i]); 
      cohesion(agent1[i]);
      separation(agent1[i]);

      agent1[i].updateposit(1/frameRate);
      
      //agent1[i].updatevelocity(1/frameRate, agent1[i].nextNode);

      //agent1[i].updateposit(1/frameRate, agent1[i].nextNode);
      
    
   //}
  }
  //draw the paths
  //for(int h = 0; h < numAgents
  //; h++){
  //      for (int i = 0; i < numpoints; i++)
  //      {
      
          
  //          //for (int j = 0; j < agent1[0].neighbors[i].size(); j++)
  //         for (int j = 0; j < agent1[h].neighbors[i].size(); j++)
  //          {
             
  //            if(h == 0){
  //               pushMatrix();
  //               fill(200);
  //               line(agent1[h].arrayofXpoints[i], agent1[h].arrayofYpoints[i], agent1[h].arrayofXpoints[agent1[h].neighbors[i].get(j)], agent1[h].arrayofYpoints[agent1[h].neighbors[i].get(j)]);
  //               popMatrix();
  //            }
  //            else{
  //               pushMatrix();
  //               fill(100);
  //               line(agent1[h].arrayofXpoints[i], agent1[h].arrayofYpoints[i], agent1[h].arrayofXpoints[agent1[h].neighbors[i].get(j)], agent1[h].arrayofYpoints[agent1[h].neighbors[i].get(j)]);
  //               popMatrix();
  //            }  
  //            //line(agent1[h].arrayofXpoints[i], agent1[h].arrayofYpoints[i], agent1[h].arrayofXpoints[agent1[h].neighbors[i].get(j)], agent1[h].arrayofYpoints[agent1[h].neighbors[i].get(j)]);
  
  //            //line(agent1[0].arrayofXpoints[i], agent1[0].arrayofYpoints[i], agent1[0].arrayofXpoints[agent1[0].neighbors[i].get(j)], agent1[0].arrayofYpoints[agent1[0].neighbors[i].get(j)]);
            
  //        }

  //     }
  //}      
  for (int i = 1; i < numpoints-1; i++) {

    pushMatrix();
    fill(0, 0, 255);
    circle(agent1[0].arrayofXpoints[i], agent1[0].arrayofYpoints[i], agentAndTargetRadius*.5);
    popMatrix();
  }  
  //pushMatrix();
  //fill(0, 0, 255);
  //circle(xsphere, ysphere, radius);
  //popMatrix();

  //first agent is RED
  for(int i = 0; i < numAgents; i ++){
     if(i == 0){
       //  fill(0,0,255);
      pushMatrix();
      fill(0, 0, 0);
      translate(agent1[i].xP, agent1[i].yP);
      circle(0,0, agentAndTargetRadius*.5);
      popMatrix();
     } else{  
        pushMatrix();
        fill(255, 0, 0);
        translate(agent1[i].xP, agent1[i].yP);
        circle(0,0, agentAndTargetRadius*.5);
        popMatrix();
     }
}
  //Draw the Goal
  //pushMatrix();
  //fill(0, 255, 0);
  //circle(750, 50, agentAndTargetRadius);
  //popMatrix();
  
  // draw the individual goals
  //for(int i = 0; i < numAgents; i ++){
  //      int num = agent1[i].num;
  //      fill(125, 180, 125);
  //        circle(agent1[i].arrayofXpoints[num - 1], agent1[i].arrayofYpoints[num - 1], 50);
    
    
  //}
  
  
}

//this finds the points and includes the goal in the last index
void findpoints() {
  
  xpoints[numpoints-1] = goalx;
  ypoints[numpoints-1] = goaly;  
   
  println(xpoints[numpoints-1]);
  println(ypoints[numpoints-1]);
  
 for (int i = 0; i < numpoints-1; i++)
  { 
   xpoint = random(0, 800);
   ypoint = random(0, 800);

   while((xpoint - xsphere)*(xpoint - xsphere) + (ypoint - ysphere)*(ypoint - ysphere) <= (radius)*(radius))
    {

      xpoint += 5;
      ypoint += 5;
    }

    xpoints[i] = xpoint;
    ypoints[i] = ypoint;;   //println(xpoints[i]);
//    println(ypoints[i]);
//  }
}

}


void chase() {
  
  xpoints[numpoints-1] = goalx;
  ypoints[numpoints-1] = goaly;  
   
  println(xpoints[numpoints-1]);
  println(ypoints[numpoints-1]);
  
 for (int i = 0; i < numpoints-1; i++)
  { 
   xpoint = random(0, 800);
   ypoint = random(0, 800);

   while((xpoint - xsphere)*(xpoint - xsphere) + (ypoint - ysphere)*(ypoint - ysphere) <= (radius)*(radius))
    {

      xpoint += 5;
      ypoint += 5;
    }

    xpoints[i] = xpoint;
    ypoints[i] = ypoint;;   //println(xpoints[i]);
//    println(ypoints[i]);
//  }
}

}




float distance(float x, float y, float u, float v)
{
  
 return sqrt((x-u)*(x-u) + (y-v)*(y-v));
  
}
              
void align(AGENT agent){
        //int radiusOfPercep = 100;  //align for radius within this distance
        float xavg = 0;
        float yavg = 0;
        int total = 0;
        agent.xAcc = 0;
        agent.yAcc= 0;
        
        
        for(int i = 0; i < numAgents; i++){
        // try with first agent first     
        //if( distance(agent1[0].xP, agent1[0].yP, agent1[i].xP, agent1[i].yP) <= radiusOfPercep){
            if( distance(agent.xP, agent.yP, agent1[i].xP, agent1[i].yP) <= radiusOfPercep){
    
                xavg += agent1[i].vx;
                yavg += agent1[i].vy;
                total++;
              }             
        }  
  
       if(total > 0){
            xavg = xavg/(total);
            yavg = yavg/(total);
             
            steeringx = xavg - agent.vx;
            steeringy = yavg - agent.vy;
       }
        //println("the agvg is:", xavg, yavg); 
        agent.xAcc = steeringx;
        agent.yAcc = steeringy;
        
}

//cohesion is the same concept as align, but it uses position instead of velocity
void cohesion(AGENT agent){
        ////int radiusOfPercep = 100;  //align for radius within this distance

        float xavg = 0;
        float yavg = 0;
        int total = 0;
        
        for(int i = 0; i < numAgents; i++){
        // try with first agent first     
        //if( distance(agent1[0].xP, agent1[0].yP, agent1[i].xP, agent1[i].yP) <= radiusOfPercep){
            if( distance(agent.xP, agent.yP, agent1[i].xP, agent1[i].yP) <= radiusOfPercep ){
    
                xavg += agent1[i].xP;
                yavg += agent1[i].yP; 
                total++;
              }             
        }  
        if(total > 0){
            xavg = xavg/(total);
            yavg = yavg/(total);
        
            steeringx = xavg - agent.xP;
            steeringy = yavg - agent.yP;

        }
     
        agent.xAcc += steeringx;
        agent.yAcc += steeringy;
  
}

void separation(AGENT agent){
        ////int radiusOfPercep = 100;  //align for radius within this distance
        //agent.xAcc = 0;
        //agent.yAcc = 0;

        float xavg = 0;
        float yavg = 0;
        int total = 0;

        float d;
        for(int i = 0; i < numAgents; i++){
        // try with first agent first     
        //if( distance(agent1[0].xP, agent1[0].yP, agent1[i].xP, agent1[i].yP) <= radiusOfPercep){
           d = distance(agent.xP, agent.yP, agent1[i].xP, agent1[i].yP); 
           if( d <= radiusOfPercep && agent != agent1[i]){
           //if( d <= radiusOfPercep){
                float diffx;
                float diffy;    
                //the strength of the force should be proportional to the distance. That is, a boid should work harder to 
                //stay away from a closer boid than a farther boid.
                diffx = (agent.xP - agent1[i].xP)/d; 
                diffy = (agent.yP - agent1[i].yP)/d;

                    xavg += diffx;
                    yavg += diffy;

                    total++;      
              }    
              
              //if(distance(agent.xP, agent.yP, xsphere, ysphere) < 75 && agent.atEnd == true){
              //        float diffx;
              //        float diffy; 
              //        //diffx = (agent.xP - xsphere)/d; 
              //        //diffy = (agent.yP - ysphere)/d;
                      
              //        diffx = (agent.xP - xsphere); 
              //        diffy = (agent.yP - ysphere);
      
              //            xavg += diffx;
              //            yavg += diffy;
      
              //            total++;
                
              //}
        
      
    
      }
      
      d = distance(boid1.xP, boid1.yP, agent.xP, agent.yP);
      if(d < radiusOfPercep){
        
                float diffx;
                float diffy;    
                //the strength of the force should be proportional to the distance. That is, a boid should work harder to 
                //stay away from a closer boid than a farther boid.
                diffx = (agent.xP - boid1.xP)/d; 
                diffy = (agent.yP - boid1.yP)/d;

                    xavg += diffx;
                    yavg += diffy;

                    total++;  
        
        
      }  
      
      
      
      d = distance(boid2.xP, boid2.yP, agent.xP, agent.yP);
      if(d < radiusOfPercep){
        
                float diffx;
                float diffy;    
                //the strength of the force should be proportional to the distance. That is, a boid should work harder to 
                //stay away from a closer boid than a farther boid.
                diffx = (agent.xP - boid2.xP)/d; 
                diffy = (agent.yP - boid2.yP)/d;

                    xavg += diffx;
                    yavg += diffy;

                    total++;  
        
        
      }  
       
        if(total > 0){
            xavg = xavg/(total);
            yavg = yavg/(total);
        
            steeringx = xavg - agent.vx;
            steeringy = yavg - agent.vy;        
        }

        agent.xAcc += 50*(steeringx);
        agent.yAcc += 50*(steeringy);      
      
}
////////////****************************************************************************************************////////////////////////////////////////////////////
void align1(BOID agent){
        //int radiusOfPercep = 100;  //align for radius within this distance
        float xavg = 0;
        float yavg = 0;
        int total = 0;
        agent.xAcc = 0;
        agent.yAcc= 0;
        
        
        for(int i = 0; i < numAgents; i++){
        // try with first agent first     
        //if( distance(agent1[0].xP, agent1[0].yP, agent1[i].xP, agent1[i].yP) <= radiusOfPercep){
            if( distance(agent.xP, agent.yP, agent1[i].xP, agent1[i].yP) <= radiusOfPercep){
    
                xavg += agent1[i].vx;
                yavg += agent1[i].vy;
                total++;
              }             
        }  
  
       if(total > 0){
            xavg = xavg/(total);
            yavg = yavg/(total);
             
            steeringx = xavg - agent.vx;
            steeringy = yavg - agent.vy;
       }
        //println("the agvg is:", xavg, yavg); 
        agent.xAcc = steeringx;
        agent.yAcc = steeringy;
        
}



//cohesion is the same concept as align, but it uses position instead of velocity
void cohesion1(BOID agent){
        ////int radiusOfPercep = 100;  //align for radius within this distance

        float xavg = 0;
        float yavg = 0;
        int total = 0;
        
        for(int i = 0; i < numAgents; i++){
        // try with first agent first     
        //if( distance(agent1[0].xP, agent1[0].yP, agent1[i].xP, agent1[i].yP) <= radiusOfPercep){
            if( distance(agent.xP, agent.yP, agent1[i].xP, agent1[i].yP) <= radiusOfPercep ){
    
                xavg += agent1[i].xP;
                yavg += agent1[i].yP; 
                total++;
              }             
        }  
        if(total > 0){
            xavg = xavg/(total);
            yavg = yavg/(total);
        
            steeringx = xavg - agent.xP;
            steeringy = yavg - agent.yP;

        }
     
        agent.xAcc += steeringx;
        agent.yAcc += steeringy;
  
}

void separation1(BOID agent){
        ////int radiusOfPercep = 100;  //align for radius within this distance
        //agent.xAcc = 0;
        //agent.yAcc = 0;

        float xavg = 0;
        float yavg = 0;
        int total = 0;

        float d;
        for(int i = 0; i < numAgents; i++){
        // try with first agent first     
        //if( distance(agent1[0].xP, agent1[0].yP, agent1[i].xP, agent1[i].yP) <= radiusOfPercep){
           d = distance(agent.xP, agent.yP, agent1[i].xP, agent1[i].yP); 
           //if( d <= radiusOfPercep ){
           if( d <= 50 ){
           //if( d <= radiusOfPercep){
                float diffx;
                float diffy;    
                //the strength of the force should be proportional to the distance. That is, a boid should work harder to 
                //stay away from a closer boid than a farther boid.
                diffx = (agent.xP - agent1[i].xP)/d; 
                diffy = (agent.yP - agent1[i].yP)/d;

                    xavg += diffx;
                    yavg += diffy;

                    total++;      
              }    
              
              //if(distance(agent.xP, agent.yP, xsphere, ysphere) < 75){
              //        float diffx;
              //        float diffy; 
              //        //diffx = (agent.xP - xsphere)/d; 
              //        //diffy = (agent.yP - ysphere)/d;
                      
              //        diffx = (agent.xP - xsphere); 
              //        diffy = (agent.yP - ysphere);
      
              //            xavg += diffx;
              //            yavg += diffy;
      
              //            total++;
                
              //}
  }
               //boid2 wants to separate from boid1
              // if(agent == boid2 && distance(boid1.xP, boid1.yP, boid2.xP, boid2.yP) > radiusOfPercep){
              //        float diffx;
              //        float diffy; 
              //        //diffx = (agent.xP - xsphere)/d; 
              //        //diffy = (agent.yP - ysphere)/d;
                      
              //        diffx = (boid2.xP - boid1.xP); 
              //        diffy =(boid2.yP - boid1.yP); 
      
              //            xavg += diffx;
              //            yavg += diffy;
      
              //            total++;
                
              //}
              
                  d = distance(boid1.xP, boid1.yP, boid2.xP, boid2.yP);
              
                if(agent == boid2 &&  d > 50){
                      float diffx;
                      float diffy; 
                      //diffx = (agent.xP - xsphere)/d; 
                      //diffy = (agent.yP - ysphere)/d;
                      
                      diffx = -(boid2.xP - boid1.xP)/d; 
                      diffy = -(boid2.yP - boid1.yP)/d; 
      
                          xavg += diffx;
                          yavg += diffy;
      
                          total++;
                
              }
              
            d = distance(boid1.xP, boid1.yP, boid2.xP, boid2.yP);  
            if(agent == boid1 && d > 50){
                      float diffx;
                      float diffy; 
                      //diffx = (agent.xP - xsphere)/d; 
                      //diffy = (agent.yP - ysphere)/d;
                      
                      diffx = -(boid1.xP - boid2.xP)/d; 
                      diffy = -(boid1.yP - boid2.yP)/d; 
      
                          xavg += diffx;
                          yavg += diffy;
      
                          total++;
                
              }
              
                //boid1 wants to get closer to boid2              
              //   if(agent == boid1 && distance(boid1.xP, boid1.yP, boid2.xP, boid2.yP) > radiusOfPercep ){
              //        float diffx;
              //        float diffy; 
              //        //diffx = (agent.xP - xsphere)/d; 
              //        //diffy = (agent.yP - ysphere)/d;
                      
              //        diffx = -(boid1.xP - boid2.xP); 
              //        diffy = -(boid1.yP - boid2.yP); 
      
              //            xavg += diffx;
              //            yavg += diffy;
      
              //            total++;
                          
                
              //}
  
  
       
        if(total > 0){
            xavg = xavg/(total);
            yavg = yavg/(total);
        
            steeringx = xavg - agent.vx;
            steeringy = yavg - agent.vy;        
        }

        agent.xAcc += 50*(steeringx);
        agent.yAcc += 50*(steeringy);      
      
}

void updateboidvel(){


  boid1.vx = boid1.vx - boid2.vx;
  boid1.vx = boid1.vy - boid2.vy;




}
