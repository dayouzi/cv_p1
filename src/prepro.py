#!/usr/bin/python
# -*- coding: utf-8 -*-
from sklearn.cross_validation import train_test_split
from sklearn import preprocessing
from sklearn.cross_validation import StratifiedShuffleSplit
from sklearn.cross_validation import StratifiedKFold
from sklearn.cross_validation import KFold
from sklearn.cross_validation import LeavePLabelOut
import numpy as np
import random,sys
from collections import *
from util import getArgMap
import random 
#example: http://sebastianraschka.com/Articles/2014_scikit_dataprocessing.html
#f_set: feature number
argMap = getArgMap(sys.argv[1:])
bookname = argMap.get('-b','')


#byID: data is continous, e.g., queries from same chapter are put together
# if byID == 1: 0:label ID: the ID that shuffle and split is based on
def readFile(data_file,deli='\t',byID=1,f_set=[],libsvm=-1):
    all_data = np.loadtxt(open(data_file,"r"),
    delimiter=deli,
    dtype=np.float64
    )
    labels=[]
    y = np.array(all_data[:,0])
    if f_set==[]:
        if byID == 1:
            #involve chapter id as a prior
            x = np.array(all_data[:,2:])
            labels = np.array(all_data[:,1])
        else:
            x = np.array(all_data[:,1:])
    else:
        for f in f_set:
            x = np.array(all_data[:,f_set])
    return x,y,labels
    
def multi2bin(target,y):
    print target
    y_new=[]
    for i in xrange(len(y)):
    	if int(y[i]) == int(target):
    	    y_new.append(1)
    	else:
    	    y_new.append(0)
    return np.array(y_new)
    
def splitFile(y,test_size=0.20,random_state=0):    
    #x_train, x_test, y_train, y_test = train_test_split(x, y, test_size, random_state)
    sss = StratifiedShuffleSplit(y, 3, 0.2,0.8)
    train_index,test_index = [],[]
    for idx1,idx2 in sss:
        train_index = idx1
        test_index = idx2
    return train_index,test_index
    
#use data file with section number
def splitFileByID(labels,test_size=0.2):
    pl = int(len(set(labels))*test_size)
    rs = random.sample(set(labels),pl)
    #print rs
    train_index,test_index,ids_train, ids_test = [],[],[],[]
    for i,label in enumerate(labels):
        if label in rs:
            test_index.append(i)
            ids_test.append(label)
        else:
            train_index.append(i) 
            ids_train.append(label)
    return train_index,test_index,ids_train,ids_test
#num: target  number 
def sampleHelper(num,c_num):
    if num == len(c_num):
    	return c_num
    ret = []
    if num > len(c_num):
    	for i in xrange(min(int(num/len(c_num)),10000)):
    	    for j in c_num:
    	    	ret.append(j)
        ks = random.sample(xrange(len(c_num)-1),num%len(c_num))
        for k in ks:
            ret.append(c_num[k])
    if num < len(c_num):
    	ks = random.sample(xrange(len(c_num)-1),num)
    	for k in ks:
    	    ret.append(c_num[k])
    return ret
def sampling(y,sampleMethod = 'oversampling'):
    class_num = defaultdict(int)
    lorg = defaultdict(list)
    lnew = defaultdict(list)
    
    for i,l in enumerate(y):
        class_num[l] = class_num[l]+1
        lorg[l].append(i)
    if sampleMethod == 'undersampling':
        min_num = min([class_num[x] for x in class_num])
        for l in class_num.keys():
            	ret = sampleHelper(min_num,lorg[l])
                for r in ret:
                    lnew[l].append(r)
        
    elif sampleMethod == 'oversampling':
        max_num = max([class_num[x] for x in class_num])
        for l in class_num:
            ret = sampleHelper(max_num,lorg[l])
            for r in ret:
            	lnew[l].append(r)
    elif sampleMethod == 'middlesampling':
    	num = sorted(class_num.items(), key=lambda x: x[1] )[int(len(class_num)/2)][1]
    	for l in class_num:
    	    ret = sampleHelper(num,lorg[l])
    	    for r in ret:
    	    	lnew[l].append(r)
    else:
        return lorg
    return lnew
            
def normalize(x_train,x_test):
    minmax_scale = preprocessing.MinMaxScaler(feature_range=(0, 1)).fit(x_train)
    x_train = minmax_scale.transform(x_train)
    x_test = minmax_scale.transform(x_test)
    return x_train,x_test

def saveFile(train_result,test_result,x_train,x_test,y_train,y_test): 
    training_data = np.hstack((y_train.reshape(y_train.shape[0], 1), x_train))
    test_data = np.hstack((y_test.reshape(y_test.shape[0], 1), x_test))
    np.savetxt(train_result, training_data, delimiter=' ')
    np.savetxt(test_result, test_data, delimiter=' ')
    
def saveFile2(train_result,test_result,x_train,x_test,y_train,y_test,svm_light = -1):
    w_train = open(train_result,'w')
    #w_train_binary = open(train_result+'_binary','w')
    for i,x in enumerate(x_train):
    	if svm_light == 1:
    	    w_train.write(str(int(y_train[i]))+' '+' '.join(str(i+1)+':'+str(xx) for i,xx in enumerate(x))+'\n')
    	else:
    	    w_train.write(str(int(y_train[i]))+' '+' '.join(str(xx) for xx in x)+'\n')
    w_test = open(test_result,'w')
    #w_test_binary = open(test_result+'_binary','w')
    for i,x in enumerate(x_test):
    	if svm_light == 1:
    	    w_test.write(str(int(y_test[i]))+' '+' '.join(str(i+1)+':'+str(xx) for i,xx in enumerate(x))+'\n')
    	else:
    	    w_test.write(str(int(y_test[i]))+' '+' '.join(str(xx) for xx in x)+'\n')
    	    

