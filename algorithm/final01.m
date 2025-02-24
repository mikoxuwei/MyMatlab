%% ANN Cycle Preparation
ANNRMSE=9999;
ANNRunNum=0;
ANNRMSEMatrix=[];
ANNrAllMatrix=[];
while ANNRMSE>1000

%% ANN
x=TrainVARI';
t=TrainYield';
trainFcn = 'trainlm';
hiddenLayerSize = [10 10 10];
ANNnet = fitnet(hiddenLayerSize,trainFcn);
ANNnet.input.processFcns = {'removeconstantrows','mapminmax'};
ANNnet.output.processFcns = {'removeconstantrows','mapminmax'};
ANNnet.divideFcn = 'dividerand';
ANNnet.divideMode = 'sample';
ANNnet.divideParam.trainRatio = 0.6;
ANNnet.divideParam.valRatio = 0.4;
ANNnet.divideParam.testRatio = 0.0;
ANNnet.performFcn = 'mse';
ANNnet.trainParam.epochs=5000;
ANNnet.trainParam.goal=0.01;
% For a list of all plot functions type: help nnplot
ANNnet.plotFcns = {'plotperform','plottrainstate','ploterrhist','plotregression','plotfit'};
[ANNnet,tr] = train(ANNnet,x,t);
y = ANNnet(x);
e = gsubtract(t,y);
performance = perform(ANNnet,t,y);
% Recalculate Training, Validation and Test Performance
trainTargets = t .* tr.trainMask{1};
valTargets = t .* tr.valMask{1};
testTargets = t .* tr.testMask{1};
trainPerformance = perform(ANNnet,trainTargets,y);
valPerformance = perform(ANNnet,valTargets,y);
testPerformance = perform(ANNnet,testTargets,y);
% view(net)
% Plots
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
%figure, plotregression(t,y)
%figure, plotfit(net,x,t)
% Deployment
% See the help for each generation function for more information.
if (false)
    % Generate MATLAB function for neural network for application
    % deployment in MATLAB scripts or with MATLAB Compiler and Builder
    % tools, or simply to examine the calculations your trained neural
    % network performs.
    genFunction(ANNnet,'myNeuralNetworkFunction');
    y = myNeuralNetworkFunction(x);
end
if (false)
    % Generate a matrix-only MATLAB function for neural network code
    % generation with MATLAB Coder tools.
    genFunction(ANNnet,'myNeuralNetworkFunction','MatrixOnly','yes');
    y = myNeuralNetworkFunction(x);
end
if (false)
    % Generate a Simulink diagram for simulation or deployment with.
    % Simulink Coder tools.
    gensim(ANNnet);
end

%% Accuracy of ANN
ANNPredictYield=sim(ANNnet,TestVARI')';
ANNRMSE=sqrt(sum(sum((ANNPredictYield-TestYield).^2))/size(TestYield,1));
ANNrMatrix=corrcoef(ANNPredictYield,TestYield);
ANNr=ANNrMatrix(1,2);
ANNRunNum=ANNRunNum+1;
ANNRMSEMatrix=[ANNRMSEMatrix,ANNRMSE];
ANNrAllMatrix=[ANNrAllMatrix,ANNr];
disp(ANNRunNum);
end
disp(ANNRMSE);

%% ANN Model Storage
ANNModelSavePath='G:\CropYield\02_CodeAndMap\00_SavedModel\';
save(sprintf('%sRF0417ANN0399.mat',ANNModelSavePath),'AreaPercent','InputOutput','nLeaf','nTree',...
    'RandomNumber','RFModel','RFPredictConfidenceInterval','RFPredictYield','RFr','RFRMSE',...
    'TestVARI','TestYield','TrainVARI','TrainYield','ANNnet','ANNPredictYield','ANNr','ANNRMSE',...
    'hiddenLayerSize');