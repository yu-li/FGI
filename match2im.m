function out_im = match2im( matches, imsize )
%	MATCH2IM 
%   Convert sparse matches to image 

out_im = zeros(imsize);
for i = 1:length(matches)
    out_im(matches(i,2),matches(i,1),1) = matches(i,3)-matches(i,1);
    out_im(matches(i,2),matches(i,1),2) = matches(i,4)-matches(i,2);
    out_im(matches(i,2),matches(i,1),3) = 1;
end


