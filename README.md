# "Crack-Detection-with-AlexNet

Deep Learning CNN Model for Crack Detection Using AlexNet Architecture
This repository contains code for building a deep learning CNN model to predict crack in images using the famous AlexNet architecture. The model was built and trained using MATLAB.
Dataset
The dataset used for training, validation, and testing the model is stored in the proc Dataset folder. The images are organized into subfolders, with each subfolder representing a different class.
Dependencies
•	MATLAB R2021a or later
•	Deep Learning Toolbox
•	File Descriptions
train.m
This file contains the code for training the deep learning CNN model using the AlexNet architecture. It loads the dataset, preprocesses the images, creates and adds layers to the network, defines the training options, and trains the model using the trainNetwork function. The trained model is saved to disk as net.mat.
test.m
This file contains the code for testing the trained model using a set of images from the proc Testing folder. It loads the saved model, preprocesses the test images, and applies the trained model to make predictions on the test data. The predicted labels and classification probabilities are displayed for a random sample of four test images.
evaluate.m
This file contains the code for evaluating the performance of the trained model on a separate set of test images from the proc Dataset folder. It loads the saved model, preprocesses the test images, applies the trained model to make predictions on the test data, and computes the classification accuracy. The predicted labels and classification probabilities are displayed for a random sample of four test images.
Usage
Clone or download this repository to your local machine.
Open MATLAB and navigate to the folder where the repository was downloaded.
Run the train.m script to train the model and save it to disk.
Run the test.m script to test the model on a set of test images.
Run the evaluate.m script to evaluate the performance of the model on a separate set of test images.
Credits
This code was written by Aiman as part of a  final year project at NEDUET.


