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
sift_file = '../corpus/vis10catfiles/sift.dat';
center_file = '../corpus/vis10catfiles/centers_sift.dat';
assg_file = '../corpus/vis10catfiles/assg_sift.dat';
fid=fopen(sift_file,'w+');
count=0;
des=[];idx=[];
% for i = 1:length(dirIndex)
%     dirName = catnames(dirIndex(i)).name;
%      
%     if strcmp(dirName,'.')== 1 | strcmp(dirName,'..')== 1
%         continue;
%     end
%    
%     imgNames = dir([base,dirName]);
%     for j = 1: length(imgNames)
%        imgPath = [base,dirName,'/',imgNames(j).name];
%        C = strread(imgNames(j).name,'%s','delimiter','.');
%        if size(C,1)<2 || strcmp(C(2),'png') == 0
%            continue
%        end
%        count = count+1;
%     end
%     
% end
% des=zeros();
total = 0;
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
       [rows columns numberOfColorChannels] = size(I);
%        image(I);
       if numberOfColorChannels > 1
           I = single(rgb2gray(I)) ;
       else
%            disp(imgPath);
%            continue;
           I = single(I);
       end
       disp(imgPath);
       [f,d] = vl_sift(I) ;
       
        disp(size(d));
%        perm = randperm(size(f,2)) ;
%         sel = perm(1:20) ;
%        h1 = vl_plotframe(f(:,sel)) ;
%        h2 = vl_plotframe(f(:,sel)) ;
%        set(h1,'color','k','linewidth',3) ;
%        set(h2,'color','y','linewidth',2) ;
       line = strcat('=====\t',imgID,'\n');
       fprintf(fid, [repmat('%f\t', 1, size(d, 2)) '\n'], d');
       des = [des,double(d)];
       temp=ones(1,size(d,2))*str2num(imgID);
       total = total+size(d,2);
       idx = [idx,temp];
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

               