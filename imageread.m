function [imagedata]=imageread(card)
%%FUNCTION TO READ CARD IMAGE
% - Input: Card- string of card and suit.
% - Output: imagedata- image matrix needed for image show
cardname=[card];%takes in image name
ending='.png'; % ending needed for image
name=[card ending]; % creates image name as a character matrix

imagedata=imread(name);%imread takes in the name of the image and produces the image matrix
 
end