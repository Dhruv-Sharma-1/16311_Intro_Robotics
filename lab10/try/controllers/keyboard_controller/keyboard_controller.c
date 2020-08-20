/*
 * File:          epuck_go_forward.c
 * Date:
 * Description:
 * Author:
 * Modifications:
 */

/*
 * You may need to add include files like <webots/distance_sensor.h> or
 * <webots/motor.h>, etc.
 */
#include <webots/robot.h>
#include <webots/motor.h>
#include <webots/gps.h>
#include <webots/camera.h>
#include <webots/keyboard.h>
#include <stdio.h>

#define SPEED 5

int main(int argc, char **argv) {
  /* necessary to initialize webots stuff */
  wb_robot_init();
  int timestep = (int)wb_robot_get_basic_time_step();

 
  WbDeviceTag front_left_wheel = wb_robot_get_device("left wheel");
  WbDeviceTag front_right_wheel = wb_robot_get_device("right wheel");
  WbDeviceTag cam = wb_robot_get_device("camera");
  
  wb_camera_enable(cam, timestep);
  wb_keyboard_enable(timestep);
  
  int key;
  int left_speed=0;
  int right_speed=0;
  
  // init motors
  wb_motor_set_position(front_left_wheel,INFINITY);
  wb_motor_set_position(front_right_wheel, INFINITY);
  wb_motor_set_velocity(front_left_wheel, left_speed);
  wb_motor_set_velocity(front_right_wheel, right_speed);
  
  // Wait one second.
  while (wb_robot_step(timestep) != -1) {
    if (wb_robot_get_time() > 1.0)
      break;
  }
  
  while (wb_robot_step(timestep) != -1) {
    key = wb_keyboard_get_key();
    switch (key) {
      case WB_KEYBOARD_UP:
        left_speed = SPEED;
        right_speed = SPEED;
        break;
      case WB_KEYBOARD_LEFT:
        left_speed = -SPEED;
        right_speed = SPEED;
        break;
      case WB_KEYBOARD_RIGHT:
        left_speed = SPEED;
        right_speed = -SPEED;
        break;
      case WB_KEYBOARD_DOWN:
        left_speed = -SPEED;
        right_speed = -SPEED;
        break;
      case -1:
        left_speed = 0;
        right_speed = 0;
     }
     wb_motor_set_velocity(front_left_wheel, left_speed);
     wb_motor_set_velocity(front_right_wheel, right_speed);
  }
  
  wb_robot_cleanup();

  return 0;
}
