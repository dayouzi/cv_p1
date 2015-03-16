#run propre.py to generate feature file first and specify sampling method
echo '============================================ BALANCE MUTIPLE ALL'
cat ../../../test/$1/$1.train |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<NF;++i) printf "%s"," "i-1":"$i;print  " "i-1":"$NF}' > ../../../test/$1/$1.train_svm
cat ../../../test/$1/$1.test |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<NF;++i) printf "%s"," "i-1":"$i;print  " "i-1":"$NF}' > ../../../test/$1/$1.test_svm
./svm-train  ../../../test/$1/$1.train_svm ../../../test/$1/$1.model
./svm-predict  ../../../test/$1/$1.test_svm ../../../test/$1/$1.model ../../../test/$1/$1.output

echo '=========================================== BALANCE MULTIPLE LOCAL'

cat ../../../test/$1/$1.train |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<5;++i) printf "%s"," "i-1":"$i;print ""}' > ../../../test/$1/$1.train_svm_local
cat ../../../test/$1/$1.train |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<5;++i) printf "%s",$i;print ""}' > ../../../test/$1/$1.train_local

cat ../../../test/$1/$1.test |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<5;++i) printf "%s"," "i-1":"$i;print ""}' > ../../../test/$1/$1.test_svm_local
cat ../../../test/$1/$1.test |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<5;++i) printf $i;print ""}' > ../../../test/$1/$1.test_local
./svm-train ../../../test/$1/$1.train_svm_local ../../../test/$1/$1.model_local
./svm-predict ../../../test/$1/$1.test_svm_local ../../../test/$1/$1.model_local ../../../test/$1/$1.output_local

echo '================================================ BALANCE MULTIPLE GLOBAL'

cat ../../../test/$1/$1.train |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=5;i<NF;++i) printf "%s"," "i-4":"$i;print  " "i-4":"$NF}' > ../../../test/$1/$1.train_svm_global
cat ../../../test/$1/$1.train |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=5;i<NF;++i) printf "%s",$i;print $NF}' > ../../../test/$1/$1.train_global
cat ../../../test/$1/$1.test |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=5;i<NF;++i) printf "%s"," "i-4":"$i;print  " "i-4":"$NF}' > ../../../test/$1/$1.test_svm_global
cat ../../../test/$1/$1.test |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=5;i<NF;++i) printf "%s",$i;print $NF}' > ../../../test/$1/$1.test_global
./svm-train ../../../test/$1/$1.train_svm_global ../../../test/$1/$1.model_global
./svm-predict ../../../test/$1/$1.test_svm_global ../../../test/$1/$1.model_global ../../../test/$1/$1.output_global


#binary
echo '====================================================== BALANCE BINARY ALL'
cat ../../../test/$1/$1.train_binary |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<NF;++i) printf "%s"," "i-1":"$i;print  " "i-1":"$NF}' > ../../../test/$1/$1.train_svm_binary
cat ../../../test/$1/$1.test_binary |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<NF;++i) printf "%s"," "i-1":"$i;print  " "i-1":"$NF}' > ../../../test/$1/$1.test_svm_binary
./svm-train  ../../../test/$1/$1.train_svm_binary ../../../test/$1/$1.model_binary
./svm-predict  ../../../test/$1/$1.test_svm_binary ../../../test/$1/$1.model_binary ../../../test/$1/$1.output_binary

echo '=================================================== BALANCE BINARY LOCAL'
cat ../../../test/$1/$1.train_binary |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<5;++i) printf "%s"," "i-1":"$i;print ""} ' > ../../../test/$1/$1.train_svm_binary_local
cat ../../../test/$1/$1.train_binary |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<5;++i) printf "%s",$i;print ""} ' > ../../../test/$1/$1.train_binary_local
cat ../../../test/$1/$1.test_binary |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<5;++i) printf "%s"," "i-1":"$i;print ""}' > ../../../test/$1/$1.test_svm_binary_local
cat ../../../test/$1/$1.test_binary |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<5;++i) printf "%s",$i;print ""}' > ../../../test/$1/$1.test_binary_local
./svm-train  ../../../test/$1/$1.train_svm_binary_local ../../../test/$1/$1.model_binary_local
./svm-predict  ../../../test/$1/$1.test_svm_binary_local ../../../test/$1/$1.model_binary_local ../../../test/$1/$1.output_binary_local

echo '==================================================== BALANCE BINARY GLOBAL'
cat ../../../test/$1/$1.train_binary |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=5;i<NF;++i) printf "%s"," "i-4":"$i;print  " "i-4":"$NF} ' > ../../../test/$1/$1.train_svm_binary_global
cat ../../../test/$1/$1.train_binary |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=5;i<NF;++i) printf "%s",$i;print  $NF} ' > ../../../test/$1/$1.train_binary_global
cat ../../../test/$1/$1.test_binary |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=5;i<NF;++i) printf "%s"," "i-4":"$i;print " "i-4":"$NF}' > ../../../test/$1/$1.test_svm_binary_global
cat ../../../test/$1/$1.test_binary |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=5;i<NF;++i) printf "%s",$i;print $NF}' > ../../../test/$1/$1.test_binary_global

./svm-train  ../../../test/$1/$1.train_svm_binary_global ../../../test/$1/$1.model_binary_global
./svm-predict  ../../../test/$1/$1.test_svm_binary_global ../../../test/$1/$1.model_binary_global ../../../test/$1/$1.output_binary_global














#unbalanced
echo '======================================================== UNBALANCE MUTIPLE ALL'
cat ../../../test/$1/$1.train_unbalanced |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<NF;++i) printf "%s"," "i-1":"$i;print  " "i-1":"$NF}' > ../../../test/$1/$1.train_svm_unbalanced
cat ../../../test/$1/$1.test_unbalanced |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<NF;++i) printf "%s"," "i-1":"$i;print  " "i-1":"$NF}' > ../../../test/$1/$1.test_svm_unbalanced
./svm-train  ../../../test/$1/$1.train_svm_unbalanced ../../../test/$1/$1.model_unbalanced
./svm-predict  ../../../test/$1/$1.test_svm_unbalanced ../../../test/$1/$1.model_unbalanced ../../../test/$1/$1.output_unbalanced

echo '===================================================== UNBALANCE MULTIPLE LOCAL'

cat ../../../test/$1/$1.train_unbalanced |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<5;++i) printf "%s"," "i-1":"$i;print ""}' > ../../../test/$1/$1.train_svm_local_unbalanced
cat ../../../test/$1/$1.train_unbalanced |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<5;++i) printf "%s",$i;print ""}' > ../../../test/$1/$1.train_local_unbalanced

cat ../../../test/$1/$1.test_unbalanced |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<5;++i) printf "%s"," "i-1":"$i;print ""}' > ../../../test/$1/$1.test_svm_local_unbalanced
cat ../../../test/$1/$1.test_unbalanced |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<5;++i) printf "%s",$i;print ""}' > ../../../test/$1/$1.test_local_unbalanced

./svm-train ../../../test/$1/$1.train_svm_local_unbalanced ../../../test/$1/$1.model_local_unbalanced
./svm-predict ../../../test/$1/$1.test_svm_local_unbalanced ../../../test/$1/$1.model_local_unbalanced ../../../test/$1/$1.output_local_unbalanced

echo '======================================= UNBALANCE MULTIPLE GLOBAL'

cat ../../../test/$1/$1.train_unbalanced |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=5;i<NF;++i) printf "%s"," "i-4":"$i;print  " "i-4":"$NF}' > ../../../test/$1/$1.train_svm_global_unbalanced
cat ../../../test/$1/$1.train_unbalanced |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=5;i<NF;++i) printf "%s",$i;print  $NF}' > ../../../test/$1/$1.train_global_unbalanced
cat ../../../test/$1/$1.test_unbalanced |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=5;i<NF;++i) printf "%s"," "i-4":"$i;print  " "i-4":"$NF}' > ../../../test/$1/$1.test_svm_global_unbalanced
cat ../../../test/$1/$1.test_unbalanced |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=5;i<NF;++i) printf "%s",$i;print $NF}' > ../../../test/$1/$1.test_global_unbalanced
./svm-train ../../../test/$1/$1.train_svm_global_unbalanced ../../../test/$1/$1.model_global_unbalanced
./svm-predict ../../../test/$1/$1.test_svm_global_unbalanced ../../../test/$1/$1.model_global_unbalanced ../../../test/$1/$1.output_global_unbalanced


#binary
echo '===================================== UNBALANCE BINARY ALL'
cat ../../../test/$1/$1.train_binary_unbalanced |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<NF;++i) printf "%s"," "i-1":"$i;print  " "i-1":"$NF}' > ../../../test/$1/$1.train_svm_binary_unbalanced
cat ../../../test/$1/$1.test_binary_unbalanced |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<NF;++i) printf "%s"," "i-1":"$i;print  " "i-1":"$NF}' > ../../../test/$1/$1.test_svm_binary_unbalanced
./svm-train  ../../../test/$1/$1.train_svm_binary_unbalanced ../../../test/$1/$1.model_binary_unbalanced
./svm-predict  ../../../test/$1/$1.test_svm_binary_unbalanced ../../../test/$1/$1.model_binary_unbalanced ../../../test/$1/$1.output_binary_unbalanced

echo '====================================== UNBALANCE BINARY LOCAL'
cat ../../../test/$1/$1.train_binary_unbalanced |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<5;++i) printf "%s"," "i-1":"$i;print ""} ' > ../../../test/$1/$1.train_svm_binary_local_unbalanced
cat ../../../test/$1/$1.train_binary_unbalanced |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<5;++i) printf "%s",$i;print ""} ' > ../../../test/$1/$1.train_binary_local_unbalanced
cat ../../../test/$1/$1.test_binary_unbalanced |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<5;++i) printf "%s"," "i-1":"$i;print ""}' > ../../../test/$1/$1.test_svm_binary_local_unbalanced
cat ../../../test/$1/$1.test_binary_unbalanced |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=2;i<5;++i) printf "%s",$i;print ""}' > ../../../test/$1/$1.test_binary_local_unbalanced
./svm-train  ../../../test/$1/$1.train_svm_binary_local_unbalanced ../../../test/$1/$1.model_binary_local_unbalanced
./svm-predict  ../../../test/$1/$1.test_svm_binary_local_unbalanced ../../../test/$1/$1.model_binary_local_unbalanced ../../../test/$1/$1.output_binary_local_unbalanced

echo '======================================= UNBALANCE BINARY GLOBAL'
cat ../../../test/$1/$1.train_binary_unbalanced |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=5;i<NF;++i) printf "%s"," "i-4":"$i;print  " "i-4":"$NF} ' > ../../../test/$1/$1.train_svm_binary_global_unbalanced
cat ../../../test/$1/$1.train_binary_unbalanced |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=5;i<NF;++i) printf "%s",$i;print $NF} ' > ../../../test/$1/$1.train_binary_global_unbalanced
cat ../../../test/$1/$1.test_binary_unbalanced |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=5;i<NF;++i) printf "%s"," "i-4":"$i;print  " "i-4":"$NF}' > ../../../test/$1/$1.test_svm_binary_global_unbalanced
cat ../../../test/$1/$1.test_binary_unbalanced |awk 'BEGIN{FS=" "}{printf "%s",$1; for (i=5;i<NF;++i) printf "%s",$i;print $NF}' > ../../../test/$1/$1.test_binary_global_unbalanced
./svm-train  ../../../test/$1/$1.train_svm_binary_global_unbalanced ../../../test/$1/$1.model_binary_global_unbalanced
./svm-predict  ../../../test/$1/$1.test_svm_binary_global_unbalanced ../../../test/$1/$1.model_binary_global_unbalanced ../../../test/$1/$1.output_binary_global_unbalanced





