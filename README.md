# Predictive Maintenance for Rotating Machinery

## Project Overview

This project was done collaboratively by three college students for a National Level Hackathon - i4.0 Maxbyte - PSG Tech Hackathon. It is split into two versions - v1_matlab where the data was analysed using MATLAB and v2_python where Python's classic Machine Learning models were used on the obtained dataset. 

------------------------------------------------------------------------

## ⚙️ Machine & Setup


The experimental set up was designed and built to study the vibrations effects of a bearing related to machine productivity. The experimental rig consisted of: 
-   **Machine:** 0.5 HP Monoblock Electric Motor
-   **Load:** 3.5 kg applied using a load cell
-   **Component Monitored:** Bearing
-   **Sensor:** ADXL335 Accelerometer mounted at 45° on bearing cover
-   **Parameter Collected:** Vibration (measured in *g*)

------------------------------------------------------------------------

## DATASET

The dataset folder consists the data which was extracted out of the experimental rig. A supervised dataset was taken with faulty and non faulty bearings. It has over 9000 data points which was used for analysis for both versions of the project

The dataset is stored in an excel file named DATASET.xslx with folders including,

- **RAW-1** - Raw dataset - 1 means classified as Good Data.

- **FAULT-2** Classified fault data

**Train** - 80% Train split

**Test** - 20% Test split

------------------------------------------------------------------------

## 📜 License

This project is released under the **MIT License**.
