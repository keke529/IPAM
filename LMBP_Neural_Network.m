clear
clc
data=importdata("C:\Users\12698\Desktop\The-LAST-LAST\THCA");
A = data.data;
A = mapminmax(A', 0, 1)';
P_data = A;
averageAccuracyTrain=0;
averageAccuracyTest=0;
averageAUC=0;
%%
[M,N]=size(P_data);
indices=crossvalind('Kfold',P_data(1:M,N),5);%10 5折交叉验证
%%
for k=1:5
    countTrain=0;
    countTest=0;
    test = (indices == k);
    train_ = ~test; 
    train_data=P_data(train_,:);
    test_data=P_data(test,:);
    train_t=train_data(:,1);%训练目标集
    train_p=train_data(:,2:end);%训练数据集
    test_t=test_data(:,1);%测试目标集
    test_p=test_data(:,2:end);%测试数据集
    train_t=train_t';%转置矩阵
    train_p= train_p';
    test_t=test_t';
    test_p=test_p';
    
    
    %% BP网络训练
    %初始化网络结构
    net=newff(train_p,train_t,15);
    %下面是双层网络结构设计，可在正确率不高时抢救一下
    %net=newff(train_p,train_t,[15,6],{'tansig','purelin'});
    %参数设定
    net.trainParam.epochs=1000;
    net.trainParam.goal=0.0000001;
    % validation check不建议修改，但如果模型准确率不高，就改
    net.trainParam.max_fail = 20;
    % 网络训练
    net=train(net,train_p,train_t); 
    %网络模拟
    [normTrainOutput] = sim(net,train_p);
    %归一化 
    normTrainOutput = round(normTrainOutput);
    ValidateTrain=normTrainOutput-train_t;
    n=max(size(ValidateTrain));%n为ValidateTrain矩阵的长度
    %遍历ValidateTrain若有0值则正确训练数加1
    for i=1:n 
        if ValidateTrain(i)==0
            countTrain=countTrain+1;
        end
    end
    accuracyTrain=countTrain/n;
    disp(['训练总数：',num2str(n),' 训练样本中正确的总数:',num2str(countTrain), ' 正确率:',num2str(accuracyTrain)]);
    averageAccuracyTrain=accuracyTrain+averageAccuracyTrain;
    [normTestOutput] = sim(net,test_p);
    %AUC计算
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
    disp(['测试总数：',num2str(n),' 测试样本中正确的总数:',num2str(countTest), ' 正确率:',num2str(accuracyTest),' AUC：',num2str(auc)]);
    averageAUC=auc+averageAUC;
    averageAccuracyTest=accuracyTest+averageAccuracyTest;
end
averageAccuracyTrain=averageAccuracyTrain/5;
averageAccuracyTest=averageAccuracyTest/5;
averageAUC=averageAUC/5;
disp(['训练样本平均准确率：',num2str(averageAccuracyTrain),' 测试样本平均准确率:',num2str(averageAccuracyTest), ' 平均AUC:',num2str(averageAUC)]);

save model net
