#!/usr/bin/python
# -*- coding: utf-8 -*-
from __future__ import division
from prepro import *
import collections, os, sys
from util import getArgMap
from collections import *
from sklearn.metrics import confusion_matrix

argMap = getArgMap(sys.argv[1:])
suffix = argMap.get('-s','')#suffix of training and testing files
number = argMap.get('-n','')#number of cats
base_path = '../corpus/vis'+number+'catfiles/'
feat_suffix = argMap.get('-f','')


def genFeatFile(numCenter):
    label = genLabels()
    r = open(base_path+'assg_'+feat_suffix+'.dat','r')
    w = open(base_path+'features_'+feat_suffix,'w')
    feat = defaultdict(lambda: defaultdict(int))
    for line in r:
    	if len(line.split('\t')) < 2:
    	    continue
    	imgID = int(line.split('\t')[0]);centerID = int(line.split('\t')[1].strip())
    	feat[imgID][centerID-1] = feat[imgID][centerID-1]+1
    
    for i in sorted(feat.keys()):
    	if i not in label.keys():
    	    continue
    	w.write( str(label[i])+'\t')
    	w.write('\t'.join(str(feat[i][c]) for c in xrange(numCenter)))
    	w.write('\n')
    	
#target is specified as number of images classes in binary classification
#default '' in multi-classification
def genTrainTestFiles(x,y,target='',samplingMethod = 'oversampling',folds=3):
    train_file = base_path + 'train_'+'all_'+feat_suffix
    test_file = base_path + 'test_'+'all_'+feat_suffix
    lnew = sampling(y,samplingMethod)
    X_new,y_new = [],[]
    for l in lnew:
    	for i in lnew[l]:
    	    X_new.append(x[i])
    	    y_new.append(y[i])
    saveFile2(train_file,test_file,X_new,[],y_new,[],1)  #write file in svm-light format
    skf = StratifiedKFold(y, n_folds=folds, shuffle = True)
    k=0
    for train_index, test_index in skf:
    	train_file = base_path + 'train_'+str(k)+target+'_'+feat_suffix
    	test_file = base_path + 'test_'+ str(k)+target+'_'+feat_suffix
    	k=k+1
    	X_test =  x[test_index]
    	y_train, y_test = y[train_index], y[test_index]
    	lnew_train = sampling(y_train,samplingMethod)
    	X_train, y_train = [],[]
    	for l in lnew_train:
    	    for i in lnew_train[l]:
    	    	X_train.append(x[train_index][i])
    	    	y_train.append(y[train_index][i])
    	
    	saveFile2(train_file,test_file,X_train,X_test,y_train,y_test,1)   
#generate binary classification training/testing files
def genBinTrainTestFiles(x,y):
    for yy in set(y):
    	c1,c2=0,0
    	y_new = multi2bin(yy,y)
    	for k in y_new:
    	    if k==1:
    	    	c1=c1+1
    	    elif k==0:
    	    	c2=c2+1
    	genTrainTestFiles(x,y_new,'_'+str(int(yy)))
    	
if __name__ == "__main__":
    
    genFeatFile(200) #numbers of centers
    data_file = base_path+'features_'+feat_suffix
    x,y,labels = readFile(data_file,'\t',0)
    genTrainTestFiles(x,y,'','None')
    #genBinTrainTestFiles(x,y)
   
   