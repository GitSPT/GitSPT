#if (ARDUINO >=100)
 #include <Arduino.h>
#else
 #include <WProgram.h>
 #endif

 #include <ros.h>
 #include <std_msgs/String.h>
 #include <geometry_msgs/Twist.h>
 #include "math.h"

 ros::NodeHandle nh;

 void motor1(const geometry_msgs::Twist& msg){
  float a = msg.angular.z;
  float v = msg.linear.x;
  int angle = 83 +msg.angular.z*40;
  int vel = abs(510*msg.linear.x);

  if(a==0 && v==0.5){  //CRAWLER 2EA 전진 
    digitalWrite(7,HIGH);
    digitalWrite(8,LOW);
    analogWrite(6,vel);
    digitalWrite(12,LOW);
    digitalWrite(13,HIGH);
    analogWrite(11,vel);
  }
  else if(a==0 && v==-0.5){//CRAWLER 2EA 후진
    digitalWrite(7,LOW);
    digitalWrite(8,HIGH);
    analogWrite(6,vel);
    digitalWrite(12,HIGH);
    digitalWrite(13,LOW);
    analogWrite(11,vel);
  }
  else if(a==0 && v==0){//모두정지
    digitalWrite(7,LOW);
    digitalWrite(8,LOW);
    analogWrite(6,vel);
    digitalWrite(12,LOW);
    digitalWrite(13,LOW);
    analogWrite(11,vel);
    digitalWrite(2,LOW);
    digitalWrite(4,LOW);
  }
  else if(a==-1 && v==0.5){//사이렌 ON
    digitalWrite(2,HIGH);
    digitalWrite(4,LOW);
  }
  else if(a==-1 && v==-0.5){//CRANK 1EA 전진
    digitalWrite(7,HIGH);
    digitalWrite(8,LOW);
    analogWrite(6,vel);
  }
  else if(a==1 && v==-0.5){//CRANK 1EA 전진
    digitalWrite(12,HIGH);
    digitalWrite(13,LOW);
    analogWrite(11,vel);
  }
 }

 ros::Subscriber<geometry_msgs::Twist> sub("cmd_vel",motor1);

  void setup(){
    pinMode(7, OUTPUT);//crawler a1
    pinMode(8, OUTPUT);//
    pinMode(9, OUTPUT);//crawler pa
    pinMode(2, OUTPUT);//crank al
    pinMode(4, OUTPUT);//
    pinMode(5, OUTPUT);//crank pa
    pinMode(13, OUTPUT);//crank_2 a1
    pinMode(12, OUTPUT);//
    pinMode(11, OUTPUT);//crank_2 pa

    nh.initNode();
    nh.subscribe(sub);
  }

  void loop(){
    nh.spinOnce();
    delay(1);
  }
