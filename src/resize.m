% resize.m   
%         resize the image using vlfeat
%        
%
% Author: Shuting Wang

%=================================================================
base = '../corpus/vis10catfiles/';
catnames = dir(base);
dirIndex = find([catnames.isdir]);

for i = 1:length(dirIndex)
    dirName = catnames(dirIndex(i)).name;
     
    if strcmp(dirName,'.')== 1 | strcmp(dirName,'..')== 1
        continue;
    end
   
    imgNames = dir([base,dirName]);
    for j = 1: length(imgNames)
       imgPath = [base,dirName,'/',imgNames(j).name];
       C = strread(imgNames(j).name,'%s','delimiter','.');
       if size(C,1)<2 || strcmp(C(2),'png') == 0
           continue
       end
       imgID = C(1);
       disp(imgPath);
       I = imread(imgPath);
       I1 = imresize(I, [300 400]);
       imwrite(I1,[base,dirName,'/',imgNames(j).name]);
       
%          h3 = vl_plotsiftdescriptor(d(:,sel),f(:,sel)) ;
%         set(h3,'color','g') ;
%         break;
    end
end
               