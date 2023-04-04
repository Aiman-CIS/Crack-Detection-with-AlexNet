[Predicted_Label,Probability]=classify(net,augimdsTest);
accuracy=mean(Predicted_Label==imdsTest.Labels);
index=randperm(numel(imdsTest.Files),4);
figure
for i = 1:4
    subplot(2,2,i)
    I=readimage(imdsTest,index(i));
    imshow(I)
    label=Predicted_Label(index(i));
    title(string(label)+","+num2str(100*max(Probability(index(i),:)),3)+"%");
end