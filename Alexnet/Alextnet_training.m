clear all;
close all; 
clc;
imds = imageDatastore('C:\Users\Hp\Desktop\Dataset\proc Dataset', ...
    'IncludeSubfolders',true, 'LabelSource','foldernames'); % this for labeling by folder names
    
[imdsTrain,imdsValidation,imdsTest] = splitEachLabel(imds,0.7,0.15,0.15);
net = alexnet(); % analyzeNetwork(lgraph)
numClasses = numel(categories(imdsTrain.Labels)); % number of classes = number of folders
imageSize = [227 227 ]; % you can use here the original dataset size
global GinputSize
GinputSize = imageSize;
lgraph = layerGraph(net.Layers);
lgraph = removeLayers(lgraph, 'fc8');
lgraph = removeLayers(lgraph, 'prob');
lgraph = removeLayers(lgraph, 'output');
% create and add layers
inputLayer = imageInputLayer([imageSize 1], 'Name', net.Layers(1).Name,...
    'DataAugmentation', net.Layers(1).DataAugmentation, ...
    'Normalization', net.Layers(1).Normalization);
lgraph = replaceLayer(lgraph,net.Layers(1).Name,inputLayer);
newConv1_Weights = net.Layers(2).Weights;
newConv1_Weights = mean(newConv1_Weights(:,:,1:3,:), 3); % taking the mean of kernal channels
newConv1 = convolution2dLayer(net.Layers(2).FilterSize(1), net.Layers(2).NumFilters,...
    'Name', net.Layers(2).Name,...
    'NumChannels', inputLayer.InputSize(3),...
    'Stride', net.Layers(2).Stride,...
    'DilationFactor', net.Layers(2).DilationFactor,...
    'Padding', net.Layers(2).PaddingSize,...
    'Weights', newConv1_Weights,...BiasLearnRateFactor 
    'Bias', net.Layers(2).Bias,...
    'BiasLearnRateFactor', net.Layers(2).BiasLearnRateFactor);
lgraph = replaceLayer(lgraph,net.Layers(2).Name,newConv1);
lgraph = addLayers(lgraph, fullyConnectedLayer(numClasses,'Name', 'fc2'));
lgraph = addLayers(lgraph, softmaxLayer('Name', 'softmax'));
lgraph = addLayers(lgraph, classificationLayer('Name','output'));
lgraph = connectLayers(lgraph, 'drop7', 'fc2');
lgraph = connectLayers(lgraph, 'fc2', 'softmax');
lgraph = connectLayers(lgraph, 'softmax', 'output');
analyzeNetwork(lgraph)
% -------------------------------------------------------------------------
augmenter = imageDataAugmenter( ...
    'RandRotation',[-20,20], ...
    'RandXReflection',1,...
    'RandYReflection',1,...
    'RandXTranslation',[-3 3], ...
    'RandYTranslation',[-3 3]);
%augimdsTrain = augmentedImageDatastore([224 224],imdsTrain,'DataAugmentation',augmenter);
%augimdsValidation = augmentedImageDatastore([224 224],imdsValidation,'DataAugmentation',augmenter);
augimdsTrain = augmentedImageDatastore(imageSize,imdsTrain);
augimdsValidation = augmentedImageDatastore(imageSize,imdsValidation);
augimdsTest = augmentedImageDatastore(imageSize,imdsTest);

options = trainingOptions('adam', ...
    'MiniBatchSize',10,...
    'MaxEpochs',5, ...
    'InitialLearnRate',3e-4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',augimdsValidation, ...
    'ValidationFrequency',3, ...
    'Verbose',false, ...
    'Plots','training-progress');
net = trainNetwork(augimdsTrain,lgraph,options);
save net


