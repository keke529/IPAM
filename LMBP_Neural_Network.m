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
indices=crossvalind('Kfold',P_data(1:M,N),5);%10 5�۽�����֤
%%
for k=1:5
    countTrain=0;
    countTest=0;
    test = (indices == k);
    train_ = ~test; 
    train_data=P_data(train_,:);
    test_data=P_data(test,:);
    train_t=train_data(:,1);%ѵ��Ŀ�꼯
    train_p=train_data(:,2:end);%ѵ�����ݼ�
    test_t=test_data(:,1);%����Ŀ�꼯
    test_p=test_data(:,2:end);%�������ݼ�
    train_t=train_t';%ת�þ���
    train_p= train_p';
    test_t=test_t';
    test_p=test_p';
    
    
    %% BP����ѵ��
    %��ʼ������ṹ
    net=newff(train_p,train_t,15);
    %������˫������ṹ��ƣ�������ȷ�ʲ���ʱ����һ��
    %net=newff(train_p,train_t,[15,6],{'tansig','purelin'});
    %�����趨
    net.trainParam.epochs=1000;
    net.trainParam.goal=0.0000001;
    % validation check�������޸ģ������ģ��׼ȷ�ʲ��ߣ��͸�
    net.trainParam.max_fail = 20;
    % ����ѵ��
    net=train(net,train_p,train_t); 
    %����ģ��
    [normTrainOutput] = sim(net,train_p);
    %��һ�� 
    normTrainOutput = round(normTrainOutput);
    ValidateTrain=normTrainOutput-train_t;
    n=max(size(ValidateTrain));%nΪValidateTrain����ĳ���
    %����ValidateTrain����0ֵ����ȷѵ������1
    for i=1:n 
        if ValidateTrain(i)==0
            countTrain=countTrain+1;
        end
    end
    accuracyTrain=countTrain/n;
    disp(['ѵ��������',num2str(n),' ѵ����������ȷ������:',num2str(countTrain), ' ��ȷ��:',num2str(accuracyTrain)]);
    averageAccuracyTrain=accuracyTrain+averageAccuracyTrain;
    [normTestOutput] = sim(net,test_p);
    %AUC����
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
    disp(['����������',num2str(n),' ������������ȷ������:',num2str(countTest), ' ��ȷ��:',num2str(accuracyTest),' AUC��',num2str(auc)]);
    averageAUC=auc+averageAUC;
    averageAccuracyTest=accuracyTest+averageAccuracyTest;
end
averageAccuracyTrain=averageAccuracyTrain/5;
averageAccuracyTest=averageAccuracyTest/5;
averageAUC=averageAUC/5;
disp(['ѵ������ƽ��׼ȷ�ʣ�',num2str(averageAccuracyTrain),' ��������ƽ��׼ȷ��:',num2str(averageAccuracyTest), ' ƽ��AUC:',num2str(averageAUC)]);

save model net
