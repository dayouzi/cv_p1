echo $1
echo $2
svm-train.exe ../../corpus/vis$1catfiles/train_$2_$3 ../../corpus/vis$1catfiles/$2_$3_model
svm-predict.exe ../../corpus/vis$1catfiles/test_$2_$3 ../../corpus/vis$1catfiles/$2_$3_model ../../corpus/vis$1catfiles/$2_$3_output

