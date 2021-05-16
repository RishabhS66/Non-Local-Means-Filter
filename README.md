# Non-Local Means Filter
```
Coded By: Rishabh Srivastava
```
Non-Local Means is an algorithm in image processing for image denoising. The method is based on a simple principle: replacing the color of a pixel with an average of the colors of similar pixels. Non-Local Means filtering takes a mean of all pixels in the image, weighted by how similar these pixels are to the target pixel. 

To speed up execution of the algorithm, one can restrict the computation of the mean for each pixel to a search window centred on the pixel itself, instead of the whole image. 

This repository includes codes for implementing the Non-Local Means filter on the image _lenna.noise.jpg_.

The **results** are displayed below:

<div align = "center">
  <kbd>
    <img src = "https://user-images.githubusercontent.com/39689610/118402483-a9c48180-b687-11eb-8a98-5142b09afeca.png" width = "355.5" height = "360">
    <img src = "https://user-images.githubusercontent.com/39689610/118402497-bd6fe800-b687-11eb-9f52-a2f67756d496.png" width = "349.3" height = "360">
  </kbd>
</div>
