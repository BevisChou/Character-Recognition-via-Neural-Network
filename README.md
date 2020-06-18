# Character Recognition via Neural Network

The repository contains all the codes as well as an example dataset to implement neural network learning to recognize hand-written characters.

## Table of Contents

- [Background](#background)
- [Usage](#usage)
- [Disclaimer](#disclaimer)
- [License](#license)

## Background

Among all the machine learning algorithms, neural network learning is one of the most popular. After learning the basics of neural network learning on Coursera, I decided to apply the knowledge to the task of hand-written character recognition.

## Usage

### Initialization

Please unzip the RAR file to the directory. Note that you should not rename the folder as well as the folders inside. Before running the codes please add the folder as well as all the files inside to path.

### Getting Started

At the Octave/MATLAB command line, type *example* to run the codes.

### Explore

You could try out different sets of parameters to see how the results differ. You could also add your own hand-written characters to corresponding folders. Please note that the number of images of each character should be approximately the same, and you're encouraged to add as many images as possible.
Please note that some parameters are interconnected. For example, the first element in *layerSizes* should be equal to the product of the two elements in *compressSize*, and the last element in *layerSizes* should be equal to *labelsSize*.

### Warning

Please do not press *enter* until you're asked to, or errors might occur because of missing parameters.

## Disclaimer

Due to the unsatisfactory performance of *fminunc* in Optimization Toolbox, another optimization function *fmincg*, provided by Stanford University in Machine Learning course on Coursera, is used in the process. To use it in your own work, please do check your eligibility first.

## License

Copyright (c) 2020 Zhou, Zheng. Licensed under the MIT license.
