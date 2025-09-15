# Predictive Maintenance for Bearing Fault Detection

## Project Overview

This project focuses on **predictive maintenance for bearings** in
rotating machinery using **vibration analysis and machine learning**. We
developed a Support Vector Machine (SVM)-based model in **MATLAB** to
detect whether a bearing is in a **good** or **faulty** condition.

The approach enables **early fault detection**, helping to prevent
unexpected breakdowns and reduce downtime in utility equipment like
motors and pumps.


## 🛠️ Current vs Proposed Maintenance

-   **Traditional method:** Preventive maintenance (scheduled
    lubrication/replacement, reactive replacement upon failure).
-   **Proposed solution:** Predictive maintenance using **SVM
    classification** on vibration data, enabling early detection of
    bearing faults.

------------------------------------------------------------------------

## 📊 Data Collection & Preprocessing

-   **Method:** Experimental data collection

-   **Feature Extraction:**

    -   **Time-domain features:** RMS, Shape Factor, Peak Value, Crest
        Factor, Clearance Factor, Impulse Factor, Mean
    -   **Frequency-domain features:** Mean Frequency, Band Power, Power
        Bandwidth, Peak Amplitude, Peak Location

-   **Total Features Extracted:** 14 per sample

-   **Data Split:** 80% training, 20% testing

-   **Storage:** Features saved as `featureTable.mat` (training) and
    `ftable.mat` (testing) - files generated in runtime

------------------------------------------------------------------------

## 🤖 Machine Learning Model

-   **Algorithm:** Support Vector Machine (SVM) with Gaussian Kernel
-   **Training Function:** `trainClassifiersvm()`
-   **Validation:** 5-fold cross-validation

### Model Performance

-   **Training Accuracy:** 92%
-   **Testing Accuracy:** 91%
-   **Confusion Matrix:** Generated using `confusionchart()`

------------------------------------------------------------------------

## 🚀 Usage

1.  **Collected  vibration data** using ADXL335 sensor is stored inside /Dataset folder

2.  **Run feature extraction in on the given dataset**:

    ``` matlab
    run('v1_matlab/feature_extraction.m')
    ```

3.  **Train SVM model**:

    ``` matlab
    run('v1_matlab/machin_learning.m')

    [trainedClassifier, validationAccuracy] = trainClassifiersvm(trainingData);
    ```

4.  **Test model accuracy**:

    ``` matlab
    yfit = trainedClassifier.predictFcn(testData);
    confusionchart(testData.ActivityID, yfit);
    ```

------------------------------------------------------------------------

## 💡 Novelty of the Approach

-   Moves from **traditional signal processing** to **machine
    learning-based detection**.
-   SVM is robust to **noise and outliers**, making it well-suited for
    real-world vibration data.
-   Enables **real-time monitoring** and early failure prediction to
    minimize machine downtime.


