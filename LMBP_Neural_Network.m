clear
clc
data=importdata("LMBP_Neural_Network_test_data.txt");
A = data.data;
A = mapminmax(A', 0, 1)';
P_data = A;
averageAccuracyTrain=0;
averageAccuracyTest=0;
averageAUC=0;
%%
[M,N]=size(P_data);
indices=crossvalind('Kfold',P_data(1:M,N),5);
%%
for k=1:5
    countTrain=0;
    countTest=0;
    test = (indices == k);
    train_ = ~test; 
    train_data=P_data(train_,:);
    test_data=P_data(test,:);
    train_t=train_data(:,1);
    train_p=train_data(:,2:end);
    test_t=test_data(:,1);
    test_p=test_data(:,2:end);
    train_t=train_t';
    train_p= train_p';
    test_t=test_t';
    test_p=test_p';
    
    
    
    
    net=newff(train_p,train_t,15);
    
    
    
    net.trainParam.epochs=1000;
    net.trainParam.goal=0.0000001;
    
    net.trainParam.max_fail = 20;
    
    net=train(net,train_p,train_t); 
    
    [normTrainOutput] = sim(net,train_p);
     
    normTrainOutput = round(normTrainOutput);
    ValidateTrain=normTrainOutput-train_t;
    n=max(size(ValidateTrain));
    
    for i=1:n 
        if ValidateTrain(i)==0
            countTrain=countTrain+1;
        end
    end
    accuracyTrain=countTrain/n;
    disp(['Number of training samples:',num2str(n),' Number of correct training samples:',num2str(countTrain),' Accuracy:',num2str(accuracyTrain)]);
    averageAccuracyTrain=accuracyTrain+averageAccuracyTrain;
    [normTestOutput] = sim(net,test_p);
    
    auc = AUC(test_t,normTestOutput);
    normTestOutput=round(normTestOutput);
    ValidateTest=normTestOutput-test_t;
    n=max(size(ValidateTest));
    for i=1:n
        if ValidateTest(i)==0
            countTest=countTest+1;
        end
    end
    accuracyTest=countTest/n;
    disp(['Number of test samples:',num2str(n),' Number of correct test samples:',num2str(countTest),' Accuracy:',num2str(accuracyTest),' AUC£º',num2str(auc)]);
    averageAUC=auc+averageAUC;
    averageAccuracyTest=accuracyTest+averageAccuracyTest;
end
averageAccuracyTrain=averageAccuracyTrain/5;
averageAccuracyTest=averageAccuracyTest/5;
averageAUC=averageAUC/5;
disp(['Average accuracy of training samples:',num2str(averageAccuracyTrain),' Test sample average accuracy:',num2str(averageAccuracyTest),' Average AUC:',num2str(averageAUC)]);

save model net
