# Task A: Segment left ventricle endocardium

## To run on testset:
1. Download the Pretrained_Model_Weights folder. (link: https://livejohnshopkins-my.sharepoint.com/:f:/g/personal/ychen506_jh_edu/Et80TpzqJ3NApfD6x9vhgHoB4k8G1pEPLNIxWmp4-YfVUg?e=vVqStb)
2. Open Project1_TaskA_RunTest.ipynb.
2. Set testset path.
3. Set the the pretrained model weights path.
4. Set the number of chamber view you plan to run (set it as 2 or 4).
5. Run the cells in code in order.


## Code and Folder
Project1_TaskA_RunTest.ipynb:
- Code to run the code on the testset

Pretrained_Model_Weights:
- Project1_Model_2CH.pth: Pretrained model weights to predict the 2 chamber view
- Project1_Model_4CH.pth: Pretrained model weights to predict the 4 chamber view

Project1_TaskA_Train.ipynb: 
- Code to run the training procedure of UNet to segment the left ventricle endocardium as required in Task A
- The code was written and trained on google colab
- Citation for the UNet Model library: A Python library, segmentation_models_pytorch, with Neural Networks for Image Segmentation based on PyTorch was used to help build the UNet model.



# Task B & C: Cardiac 3D Reconstruction

## Introduction

This MATLAB project is designed to take two input ultrasound cardiac images and generate a 3D model of the left ventricle and estimate the stroke volume and ejection fraction.

## Installation

To install this project, you will need to have MATLAB installed on your computer. You can download MATLAB from the MathWorks website.

You will also need to install the following dependencies:
- Image Processing Toolbox
- Computer Vision Toolbox
- Curve Fitting Toolbox
- Image Toolbox

## Usage

To use this project:

1. Open MATLAB and navigate to the project directory.
2. Run the main.m script.
3. The 3D animation, stroke volume and ejection fraction will be calculated and displayed.
