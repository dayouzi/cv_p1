#!/usr/bin/python
# -*- coding: utf-8 -*-
from __future__ import division
import cv2,sys,os
import numpy as np
from util import getArgMap
from collections import *
import sklearn
from sklearn.cluster import KMeans
argMap = getArgMap(sys.argv[1:])
suffix = argMap.get('-s','')
base_path = '../corpus/vis'+suffix+'catfiles/'
def reformat():
    cats = [];label = defaultdict(int)
    for cat in os.listdir(base_path):
    	if os.path .isfile(base_path+cat):
    	    continue
    	for img in os.listdir(base_path+cat):
    	    imID = img.split('.')[0]
    	    if img.split('.')[1] == 'gif' or  img.split('.')[1] == 'x-ms-bmp' :
    	    	continue
    	    if not imID.isdigit():
    	    	continue
    	    print base_path+cat+'/'+img
    	    img1 = cv2.resize(cv2.imread(base_path+cat+'/'+img),(128,128))
    	    img2= cv2.cvtColor(img1,cv2.COLOR_BGR2GRAY)
    	    cv2.imwrite(base_path+cat+'/'+img,img2)
#http://nbviewer.ipython.org/gist/kislayabhi/abb68be1b0be7148e7b7
def sift():
    descriptor_mat=[]
    k=200
    sift = cv2.SIFT()
    kp,des = sift.detectAndCompute(gray,None)
    descriptor_mat.append(des)
    descriptor_mat=np.double(np.vstack(descriptor_mat))
    descriptor_mat=descriptor_mat.T
    distance=EuclideanDistance(sg_descriptor_mat_features, sg_descriptor_mat_features)
    kmeans=KMeans(k, distance)
    kmeans.train()
    cluster_centers=(kmeans.get_cluster_centers())
    
if __name__ == "__main__":
    reformat()