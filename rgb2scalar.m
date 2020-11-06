function rgb2scalar(fnm)
%Convert Siemens color scheme to scalar
% fnm : image to parcel
%Example
% rgb2scalar('cbfd.png')
% rgb2scalar('ttd.png')
% rgb2scalar('cbvd.png')

if ~exist('fnm','var')  %no files specified
    [files,pth] = uigetfile({'*.png;';'*.*'},'Choose Siemens color scheme', 'MultiSelect', 'off');
    fnm = strcat(pth,char(files));
end

im = imread(fnm);
if size(im,1) ~= 254
    error('rgb2scalar expects images with 254 columns');
end
if size(im,3) ~= 3
    error('rgb2scalar expects rgb images');
end
hmid = ceil(size(im,2) / 2); %horizontal middle
r = im(:,hmid,1);
g = im(:,hmid,2);
b = im(:,hmid,3);
x = [1:numel(r)];
r = flip(r);
g = flip(g);
b = flip(b);

plot(x,r,'r', x, g, 'g', x, b, 'b', 'LineWidth',2);
ylabel('RGB Intensity','fontweight','bold','fontsize',16);
xlabel('Scalar Intensity','fontweight','bold','fontsize',16);
set(gca,'FontWeight','bold');

axis([0 255 0 255])
%rgb = [0,0,0; r,g,b];
rgb = [r,g,b];
[p,n] = fileparts(fnm);
save(fullfile(p,[n, '.mat']), 'rgb');

