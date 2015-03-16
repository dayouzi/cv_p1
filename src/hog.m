% resize.m   
%         resize the image using vlfeat
%        
%
% Author: Shuting Wang

%=================================================================
% function sift_feat=resize(base)
base = '../corpus/vis10catfiles/';
catnames = dir(base);
dirIndex = find([catnames.isdir]);
sift_file = '../corpus/vis10catfiles/hog.dat';
center_file = '../corpus/vis10catfiles/hog_centers.dat';
assg_file = '../corpus/vis10catfiles/hog_assg.dat';
fid=fopen(sift_file,'w+');
count=0;


for i = 1:length(dirIndex)
    dirName = catnames(dirIndex(i)).name;
   if strcmp(dirName,'.')== 1 | strcmp(dirName,'..')== 1
        continue;
    end
    imgNames = dir([base,dirName]);
    for j = 1: length(imgNames)
       imgPath = [base,dirName,'/',imgNames(j).name];
       C = strread(imgNames(j).name,'%s','delimiter','.');
       if size(C,1)<2 || (strcmp(C(2),'jpeg') == 0 && strcmp(C(2),'png') == 0)
        continue;
    end
   
       count = count+1;
    end
    
end

 des=zeros(31,16*16*count);
%  idx=zeros(16*16*count);
% des=[];
idx=[];
total = 0;
cnum=0;
for i = 1:length(dirIndex)
    dirName = catnames(dirIndex(i)).name;
     
    if strcmp(dirName,'.')== 1 | strcmp(dirName,'..')== 1
        continue;
    end
   
    imgNames = dir([base,dirName]);
    for j = 1: length(imgNames)
       imgPath = [base,dirName,'/',imgNames(j).name];
       C = strread(imgNames(j).name,'%s','delimiter','.');
       if size(C,1)<2 || (strcmp(C(2),'jpeg') == 0 && strcmp(C(2),'png') == 0)
           continue
       end
       imgID = cell2mat(C(1));
       I = imread(imgPath);
       
       I = single(I);
       disp(imgPath);
       h = vl_hog(I, 8);
       disp(size(h));
       %line = strcat('=====\t',imgID,'\n');
       %fprintf(fid, [repmat('%f\t', 1, size(d, 2)) '\n'], d');
       for p = 1:size(h,1)
           for q = 1:size(h,2)
%                 des = [des,double(h(p,q,:))];
                des(:,256*cnum+16*(p-1)+q) = reshape(double(h(p,q,:)),[1,size(h(p,q,:),3)]);
           end
       end
       %temp_h = reshape(h,[256,size(h,3)])';
       
       %des = [des,temp_h];
%        for p = 1:size(h,1)
%             for q = 1:size(h,2)
%                  des = [des,double(h(p,q,:))];
%             end
%        end
       temp=ones(1,size(h,2)*size(h,2))*str2num(imgID);
       total = total+size(h,2)*size(h,2);
%        for t = 1:size(temp)
%            idx(1,256*c+t) = temp(t);
%        end
       idx = [idx,temp];
       cnum=cnum+1;
    end
    
end
disp(total);
disp(size(des));
fclose(fid);
fid_center=fopen(center_file,'w+');
% disp(size(des));
numClusters = 200;
[centers, assg] = vl_kmeans(des, numClusters);
% disp(centers);
for i = 1: size(centers,2)
    for j = 1: size(centers,1)
        fprintf(fid_center,num2str(centers(j,i)));
        fprintf(fid_center,'\t');
    end
    fprintf(fid_center,'\n');
end
fclose(fid_center);
disp(size(idx));
disp(size(assg));
fid_assg=fopen(assg_file,'w+');
for i = 1: size(assg,2)
    fprintf(fid_assg,num2str(idx(1,i)));
    fprintf(fid_assg,'\t');
    fprintf(fid_assg,num2str(assg(1,i)));
    fprintf(fid_assg,'\n');
end
fclose(fid_center);

               