%Reading images from the folder
src = dir('~/Desktop/ML-project/emotionDetection/jaffe/*.tiff');

%Displaying the images
%{
for i =  1 : length(src)
    filename = strcat('~/Desktop/ML-project/emotionDetection/attFace/s1/', src(i).name);
    I = imread(filename);
    figure, imshow(I);
end
%}

%defining a system object which detect face using Viola-Jones algorithm
detect = vision.CascadeObjectDetector;
val = zeros(length(src), 4);
for i = 1 : length(src)
    filename = strcat('~/Desktop/ML-project/emotionDetection/jaffe/', src(i).name);
    I = imread(filename);
    %Getting the co-ordinate of the rectangle block around the face
    temp = step(detect, I);
    for j = 1 : 4
        val(i, j) = temp(j);
    end
    
    %Annotating the image around the face
    Ifaces = insertObjectAnnotation(I, 'rectangle', val(i,:), 'Face');
    figure, imshow(Ifaces);
    
    %For cropping the image around the face
    Icrop = imcrop(I, val(i, :));
    imshow(Icrop);
end
