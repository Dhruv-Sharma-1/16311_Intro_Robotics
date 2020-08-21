#!/usr/bin/env python3
# import math
# import pickle
# import numpy as np
# import matplotlib.pyplot as plt
import arm

def main():
	myArm = arm.RNArm(basePoint=[0, 0], linkLengths=[3.75, 2.5])
	thetaData, locs = myArm.configSpaceChecker(myArm.naiveCollisionChecker, 300)
	t1Arr = []
	t2Arr = []
	for item in thetaData:
		t1Arr.append(item[0])
		t2Arr.append(item[1])
	return thetaData

	# myArm.plotData(t1Arr, t2Arr)

if __name__ == '__main__':
	main()


