% clear all; close all; clc

input = 'images/suit.jpg';
I = imread(input);

% function [ S, map ] = cartoon( I, smoothness, detail, bitdepth, thickness, morph_len, morph_ang  )
% [out] = cartoon(I, 0.02, 900, 24, 2, 9, 90);

figure
% imshow(out)
BnW( I, 900, .6, 2, 3, 90, 1 ) 
