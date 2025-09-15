function [trainedClassifier, validationAccuracy] = trainClassifiersvm(trainingData)

load trainingData.mat;
inputTable = trainingData;
predictorNames = {'features1', 'features2', 'features3', 'features4', 'features5', 'features6', 'features7', 'features8', 'features9', 'features10', 'features11', 'features12', 'features16', 'features17'};
predictors = inputTable(:, predictorNames);
response = inputTable.ActivityID;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false];


classificationSVM = fitcsvm(...
    predictors, ...
    response, ...
    'KernelFunction', 'gaussian', ...
    'PolynomialOrder', [], ...
    'KernelScale', 3.7, ...
    'BoxConstraint', 1, ...
    'Standardize', true, ...
    'ClassNames', categorical({'vibbad'; 'vibgood'}));

predictorExtractionFcn = @(t) t(:, predictorNames);
svmPredictFcn = @(x) predict(classificationSVM, x);
trainedClassifier.predictFcn = @(x) svmPredictFcn(predictorExtractionFcn(x));


trainedClassifier.RequiredVariables = {'features1', 'features10', 'features11', 'features12', 'features16', 'features17', 'features2', 'features3', 'features4', 'features5', 'features6', 'features7', 'features8', 'features9'};
trainedClassifier.ClassificationSVM = classificationSVM;
trainedClassifier.About = 'This struct is a trained model exported from Classification Learner R2022b.';
trainedClassifier.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');


inputTable = trainingData;
predictorNames = {'features1', 'features2', 'features3', 'features4', 'features5', 'features6', 'features7', 'features8', 'features9', 'features10', 'features11', 'features12', 'features16', 'features17'};
predictors = inputTable(:, predictorNames);
response = inputTable.ActivityID;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false];


KFolds = 5;
cvp = cvpartition(response, 'KFold', KFolds);

validationPredictions = response;
numObservations = size(predictors, 1);
numClasses = 2;
validationScores = NaN(numObservations, numClasses);
for fold = 1:KFolds
    trainingPredictors = predictors(cvp.training(fold), :);
    trainingResponse = response(cvp.training(fold), :);
    foldIsCategoricalPredictor = isCategoricalPredictor;

    
    classificationSVM = fitcsvm(...
        trainingPredictors, ...
        trainingResponse, ...
        'KernelFunction', 'gaussian', ...
        'PolynomialOrder', [], ...
        'KernelScale', 3.7, ...
        'BoxConstraint', 1, ...
        'Standardize', true, ...
        'ClassNames', categorical({'vibbad'; 'vibgood'}));

    
    svmPredictFcn = @(x) predict(classificationSVM, x);
    validationPredictFcn = @(x) svmPredictFcn(x);

    
    validationPredictors = predictors(cvp.test(fold), :);
    [foldPredictions, foldScores] = validationPredictFcn(validationPredictors);

    
    validationPredictions(cvp.test(fold), :) = foldPredictions;
    validationScores(cvp.test(fold), :) = foldScores;
end


correctPredictions = (validationPredictions == response);
isMissing = ismissing(response);
correctPredictions = correctPredictions(~isMissing);
validationAccuracy = sum(correctPredictions)/length(correctPredictions);
fprintf("The SVM classification Validation accuracy on the train partition is %2.1f%%",validationAccuracy*100)
figure
confusionchart(response,validationPredictions,'RowSummary','row-normalized','ColumnSummary','column-normalized');