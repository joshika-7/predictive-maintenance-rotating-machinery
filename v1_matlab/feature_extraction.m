actnames={'vibgood', 'vibbad'}
meanFE = signalTimeFeatureExtractor("Mean",true,"SampleRate",fs);
timeFE = signalTimeFeatureExtractor("RMS",true,...
    "ShapeFactor",true,...
    "PeakValue",true,...
    "CrestFactor",true,...
    "ClearanceFactor",true,...    
    "ImpulseFactor",true,...
    "SampleRate",fs);
freqFE = signalFrequencyFeatureExtractor("PeakAmplitude",true,...
    "PeakLocation",true,...
    "MeanFrequency",true,...
    "BandPower",true,...
    "PowerBandwidth",true,...
    "SampleRate",fs);
fftLength = 1024;
window = rectwin(size(atx,1));
setExtractorParameters(freqFE,"WelchPSD","FFTLength",fftLength,"Window",window);
mindist_xunits = 0.25;
minpkdist = floor(mindist_xunits/(fs/fftLength));
setExtractorParameters(freqFE,"PeakAmplitude","MaxNumExtrema",5,"MinSeparation",minpkdist);
setExtractorParameters(freqFE,"PeakLocation","MaxNumExtrema",5,"MinSeparation",minpkdist);
meanFeatureDs = arrayDatastore(atx,"IterationDimension",2);
meanFeatureDs = transform(meanFeatureDs,@(x)meanFE.extract(x{:}));
timeFeatureDs = arrayDatastore(atx,"IterationDimension",2);
timeFeatureDs = transform(timeFeatureDs,@(x)timeFE.extract(x{:}));
freqFeatureDs = arrayDatastore(atx,"IterationDimension",2);
freqFeatureDs = transform(freqFeatureDs,@(x)freqFE.extract(x{:}));

meanFeatures = readall(meanFeatureDs,"UseParallel",true);
timeFeatures = readall(timeFeatureDs,"UseParallel",true);
freqFeatures = readall(freqFeatureDs,"UseParallel",true);
features = [meanFeatures timeFeatures freqFeatures];
featureTable = array2table(features);
actioncats = categorical(actnames)';
featureTable.ActivityID = actioncats(actid);
head(featureTable)

predictors = featureTable(:, 1:end-1);
response = featureTable.ActivityID;
rng default