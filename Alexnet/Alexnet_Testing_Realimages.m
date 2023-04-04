Testing=imageDatastore("C:\Users\Hp\Desktop\Dataset\proc Testing");
imageSize = [227 227 ]; % you can use here the original dataset size
global GinputSize
GinputSize = imageSize;
resizeTest = augmentedImageDatastore([imageSize 1],Testing);

[Predicted_Label,Probability]=classify(net,resizeTest);
index=randperm(numel(Testing.Files),4);
figure
for i = 1:4
    subplot(2,2,i)
    I=readimage(Testing,index(i));
    imshow(I)
    label=Predicted_Label(index(i));
    title(string(label)+","+num2str(100*max(Probability(index(i),:)),3)+"%");
end