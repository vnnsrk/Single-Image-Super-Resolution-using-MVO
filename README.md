# Single-Image-Super-Resolution-using-MVO
Image super-resolution using matrix valued operations

Matrix valued image super-resolution is a novel topic of research that uses the spatial dependencies when finding the mapping between low and high resolution images. This project implements this [paper](https://www.hindawi.com/journals/tswj/2016/8306342/), and provides a proof-of-concept.

We train the model using `trainingPatchExtraction.m` and the test scripts are provided in `testingPatchExtraction.m`.

The scripts `psnrCalc.m` and `ssim_wl.m` are provided for model evaluation.

The paper is provided at [Single Image SISR](https://github.com/vnnsrk/Single-Image-Super-Resolution-using-MVO/blob/master/Single_Image_SISR.pdf)
