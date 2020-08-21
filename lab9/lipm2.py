import math
import numpy as mp
import pygame
import time
import random

class Walker():
    def __init__(self):

        mass_xpos = 0.1 # m
        mass_ypos = 1 # m
        mass_xvel = random.random()+3 # m/s
        self.flag = 1
        mass_yvel = 0 # m/s

        # essentially front foot x-pos is all that matters
        frontFoot_xpos = 0.4 # m
        frontFoot_ypos = 0 # m
        backFoot_xpos = 0 # m
        backFoot_ypos = 0 # m
        self.state = [mass_xpos, mass_ypos, mass_xvel, mass_yvel, frontFoot_xpos, frontFoot_ypos, backFoot_xpos, backFoot_ypos]

        self.vdes = 3 #m/s

        self.gravity = 9.8 #m/s^2

        self.mass = 1 # kg

        self.footLength = 0.2 # m

        self.dt = 0.02

        self.total = 7
        self.curr = 7

        self.red = (255, 0, 0)
        self.green = (0, 255, 0)
        self.blue = (0, 0, 255)
        self.white = (255, 255, 255)
        self.black = (0, 0, 0)

        self.screenWidth = 1000
        self.screenHeight = 600

        self.display = pygame.display.set_mode((self.screenWidth, self.screenHeight))
        self.display.fill(self.white)
        pygame.draw.line(self.display,self.black, (0, self.screenHeight/2), (self.screenWidth, self.screenHeight/2),5)

    def update(self):

        if (self.state[0] >= self.state[4]): # Step 1: Decide when to take a step. This should be when the robot is about to fall forwards
            print('Taking step at ')
            print(self.state[0])
            print('\n')

            time.sleep(0.5)
            self.step()
            self.curr -= 1

        cx = self.state[0]
        cy = self.state[1]
        cvx = self.state[2]
        cvy = self.state[3]
        fx = self.state[4]
        fy = self.state[5]
        bx = self.state[6]
        by = self.state[7]

        dt = self.dt

        # Step 3: Calculate the change in states 

        m = self.mass
        g = self.gravity 
        x = cx
        y = cy
    
        # acceleration
        ax = (g*x - g * fx) / y

        # Step 4: Integrate the changes in states and update the state variables.

        self.state[0] = x + (cvx * dt)
        self.state[2] = cvx + (ax * dt)


        self.draw()

    def step(self):
        
        cx = self.state[0]
        cy = self.state[1]
        cvx = self.state[2]
        cvy = self.state[3]
        fx = self.state[4]
        fy = self.state[5]
        bx = self.state[6]
        by = self.state[7]

        # Step 2: Calculate the step and update the state variables

        g = self.gravity
        vi = cvx
        vf = self.vdes * self.curr / self.total

        xf = math.sqrt((cy/g) * (vi**2 - vf**2))

        self.state[4] = self.state[4] + xf
        self.state[6] = self.state[4] - self.footLength







    def draw(self):

        cx = self.state[0]*200 # m to pixels
        cy = self.screenHeight/2-self.state[1]*200 # m to pixels
        fx = self.state[4]*200 # m to pixels
        fy = self.screenHeight/2-self.state[5]*200 # m to pixels
        bx = self.state[6]*200 # m to pixels
        by = self.screenHeight/2-self.state[7]*200 # m to pixels

        self.display.fill(self.white)
        pygame.draw.line(self.display,self.black, (0, self.screenHeight/2), (self.screenWidth, self.screenHeight/2),5)

        pygame.draw.line(self.display, self.blue, (cx, cy), (fx, fy),5)
        pygame.draw.line(self.display, self.blue, (cx, cy), (bx, by),5)
        pygame.draw.circle(self.display, self.red, (round(cx), round(cy)), 20)

        speedString = ("%.2f" % self.state[2])
        print(speedString)
        textSurface = pygame.font.Font('freesansbold.ttf',50).render(speedString, True, self.black)
        textRect = textSurface.get_rect()
        textRect.center = (cx, cy-50)
        self.display.blit(textSurface, textRect)

        pygame.display.update()
        time.sleep(.03) # just makes it easier to see


if __name__ == '__main__':
    pygame.init()
    walker = Walker()

    sim = True
    
    while sim==True:
        walker.update()
        for event in pygame.event.get():
            if event.type == pygame.QUIT: 
                pygame.quit()
                sim = False
