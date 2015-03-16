echo $1
echo $2
#2 0.03125 47.5358
#for cross_validation $2 = all_hog/sift
svm-scale.exe -l -1 -u 1 ../../corpus/vis$1catfiles/train_$2 > ../../corpus/vis$1catfiles/train_$2.scale
svm-scale.exe -l -1 -u 1 ../../corpus/vis$1catfiles/test_$2 > ../../corpus/vis$1catfiles/test_$2.scale

svm-train.exe -c 2 -g 0.03125 ../../corpus/vis$1catfiles/train_$2.scale ../../corpus/vis$1catfiles/$2_model
svm-predict.exe ../../corpus/vis$1catfiles/test_$2.scale ../../corpus/vis$1catfiles/$2_model ../../corpus/vis$1catfiles/$2_output


#cross validation
#svm-train.exe -c 2 -g 0.03125 -v 5 ../../corpus/vis$1catfiles/train_$2.scale
#python gridregression.py v-log2c -5,5,1 -log2g -4,0,1 -v 5 ../../corpus/vis$1catfiles/train_$2.scale 
