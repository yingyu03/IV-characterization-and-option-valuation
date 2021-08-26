%% 读预测数据 read data 
data_test = xlsread('2020_10.xlsx');
range_test = 2:size(data_test);
Strike_test = data_test(range_test, 1);
MarketPrice_test= data_test(range_test,2);
AssetPrice_test= data_test(range_test, 11);
Time_test=data_test(range_test, 9);
Rate_test= data_test(range_test, 10);
T_test = data_test(range_test,8);
% BS_HV
HV1_test= data_test(range_test, 15);%21天
HV2_test= data_test(range_test, 16);%63天
HV3_test= data_test(range_test, 17);%126天
HV4_test= data_test(range_test, 18);%189天
HV5_test= data_test(range_test, 19);%252天
HV6_test= data_test(range_test, 20);%100天
Call1_test = blsprice(AssetPrice_test,Strike_test, Rate_test, Time_test, HV1_test);
Call2_test = blsprice(AssetPrice_test,Strike_test, Rate_test, Time_test, HV2_test);
Call3_test = blsprice(AssetPrice_test,Strike_test, Rate_test, Time_test, HV3_test);
Call4_test = blsprice(AssetPrice_test,Strike_test, Rate_test, Time_test, HV4_test);
Call5_test = blsprice(AssetPrice_test,Strike_test, Rate_test, Time_test, HV5_test);
Call6_test = blsprice(AssetPrice_test,Strike_test, Rate_test, Time_test, HV6_test);
% BS_IV
Call7_test = blsprice(AssetPrice_test,Strike_test, Rate_test, Time_test,f(Strike_test,Time_test) );
% HESTON
t_test = zeros(size(Time_test));
q_test = zeros(size(Time_test));
PC_test = ones(size(Time_test));
Call8_test = Heston1993KahlJaeckelLordRev3(PC_test,AssetPrice_test,Strike_test,Time_test,t_test,Rate_test,q_test,xopt(1),xopt(2),xopt(3),xopt(4),xopt(5));
Call_test = [Call1_test,Call2_test,Call3_test,Call4_test,Call5_test,Call6_test,Call7_test,Call8_test];
ME_test = ones(8,1); MRE_test = ones(8,1) ; MSE_test = ones(8,1);
RMSE_test = ones(8,1);  MAE_test=ones(8,1);   MARE_test =ones(8,1);   SMAPE_test=ones(8,1); 
for i=1:8
    ME_test(i)=mean(Call_test(:,i)-MarketPrice_test);
    MRE_test(i)=mean((Call_test(:,i)-MarketPrice_test)./MarketPrice_test);
    MSE_test(i)=mean((Call_test(:,i)-MarketPrice_test).^2);
    RMSE_test(i)=sqrt(mean((Call_test(:,i)-MarketPrice_test).^2));
    MAE_test(i)=mean(abs(Call_test(:,i)-MarketPrice_test));
    MARE_test(i)=mean(abs((Call_test(:,i)-MarketPrice_test)./MarketPrice_test));
    SMAPE_test(i)=mean(abs(Call_test(:,i)-MarketPrice_test)./(abs(Call_test(:,i)+abs(MarketPrice_test))./2));
end
ERROR1_8_test= [ME_test,MRE_test,MSE_test,RMSE_test,MAE_test,MARE_test,SMAPE_test];%选择最优的期限
Call_test = [Call1_test,Call2_test,Call3_test,Call4_test,Call5_test,Call6_test,Call7_test,Call8_test];
ME_test1 = ones(10,8); MRE_test1= ones(10,8); MSE_test1 = ones(10,8) ;
RMSE_test1 =  ones(10,8); MAE_test1 = ones(10,8); MARE_test1 = ones(10,8) ; SMAPE_test1 = ones(10,8);
%% 画预测曲线
A=[1,40,79,118,157,196,235,274,313,352,389];
%分不同执行价计算ERROR (Table 6)
for i=1:10
    for j = 1:8
    %MM = ones(length(Call_test(A(i):A(i+1)-1,j)),1).*MarketPrice_test
    ME_test1(i,j)=mean(Call_test(A(i):A(i+1)-1,j)-MarketPrice_test(A(i):A(i+1)-1));
    MRE_test1(i,j)=mean((Call_test(A(i):A(i+1)-1,j)-MarketPrice_test(A(i):A(i+1)-1))./MarketPrice_test(A(i):A(i+1)-1));
    MSE_test1(i,j)=mean((Call_test(A(i):A(i+1)-1,j)-MarketPrice_test(A(i):A(i+1)-1)).^2);
    RMSE_test1(i,j)=sqrt(mean((Call_test(A(i):A(i+1)-1,j)-MarketPrice_test(A(i):A(i+1)-1)).^2));
    MAE_test1(i,j)=mean(abs(Call_test(A(i):A(i+1)-1,j)-MarketPrice_test(A(i):A(i+1)-1)));
    MARE_test1(i,j)=mean(abs((Call_test(A(i):A(i+1)-1,j)-MarketPrice_test(A(i):A(i+1)-1))./MarketPrice_test(A(i):A(i+1)-1)));
    SMAPE_test1(i,j)=mean(abs(Call_test(A(i):A(i+1)-1,j)-MarketPrice_test(A(i):A(i+1)-1))./(abs(Call_test(A(i):A(i+1)-1,j)+abs(MarketPrice_test(A(i):A(i+1)-1)))./2));
    end
end
%分虚实值算RMSE(Table 7)
sum_DOTM_test =zeros(8,1);sum_OTM_test = zeros(8,1); sum_ATM_test = zeros(8,1); sum_ITM_test =zeros(8,1); sum_DITM_test = zeros(8,1); 
num_DOTM_test = zeros(8,1);num_OTM_test =zeros(8,1); num_ATM_test = zeros(8,1); num_ITM_test = zeros(8,1); num_DITM_test = zeros(8,1);
for i=1:length(Strike_test)
    for j=1:8  
        if AssetPrice_test(i)./Strike_test(i)<0.85
            sum_DOTM_test(j) = sum_DOTM_test(j) + (Call_test(i,j)-MarketPrice_test(i)).^2;
            num_DOTM_test(j) = num_DOTM_test(j) + 1;
        elseif AssetPrice_test(i)./Strike_test(i)>=0.85 && AssetPrice_test(i)./Strike_test(i)<0.97
            sum_OTM_test (j)= sum_OTM_test(j) + (Call_test(i,j)-MarketPrice_test(i)).^2;
            num_OTM_test (j)= num_OTM_test(j) + 1;
        elseif AssetPrice_test(i)./Strike_test(i)>=0.97 && AssetPrice_test(i)./Strike_test(i)<1.03
            sum_ATM_test(j) = sum_ATM_test(j) + (Call_test(i,j)-MarketPrice_test(i)).^2;
            num_ATM_test(j) = num_ATM_test(j)+ 1;
        elseif AssetPrice_test(i)./Strike_test(i)>=1.03 && AssetPrice_test(i)./Strike_test(i)<1.15
            sum_ITM_test(j) = sum_ITM_test(j) +(Call_test(i,j)-MarketPrice_test(i)).^2;
            num_ITM_test(j) = num_ITM_test(j) + 1;
        elseif AssetPrice_test(i)./Strike_test(i)>=1.15
            sum_DITM_test(j) = sum_DITM_test(j) +(Call_test(i,j)-MarketPrice_test(i)).^2;
            num_DITM_test(j) = num_DITM_test(j) + 1;
        end
    end
end
RMSE_test=[sqrt(sum_DOTM_test./num_DOTM_test),sqrt(sum_OTM_test./num_OTM_test),sqrt(sum_ATM_test./num_ATM_test),sqrt(sum_ITM_test./num_ITM_test),sqrt(sum_DITM_test./num_DITM_test)];
% B=[2.95,3,3.1,3.2,3.3,3.4,3.5,3.6,3.7,3.8];
% Moneyness_test=AssetPrice_test./Strike_test;
%% 画波动率图 figure 18
BS_IV_test=f(Strike_test,Time_test);
Heston_IV_test=blsimpv(AssetPrice_test,Strike_test,Rate_test,Time_test, Call8_test);
ImpliedVolatility_test=blsimpv(AssetPrice_test,Strike_test,Rate_test,Time_test, MarketPrice_test);
% 各历史波动率
plot(ImpliedVolatility_test,'.-');hold on;plot(HV1_test);hold on;plot(HV2_test);hold on;plot(HV3_test);hold on;plot(HV4_test);hold on;plot(HV5_test);hold on;
legend({'Market-IV', 'HV(21)', 'HV(63)', 'HV(126)', 'HV(189)','HV(252)'});xlabel('All Data');ylabel('Volatility');
% 市场IV,HV(252),BS-IV,Heston-IV
plot(ImpliedVolatility_test,'b.-');hold on;plot(HV5_test,'r--');hold on;plot(BS_IV_test,'g-.');hold on;plot(Heston_IV_test,'k-');hold on;
legend({'Market-IV', 'HV(252)', 'BS-IV','Heston-IV'});xlabel('All Data');ylabel('Volatility');
%% 2020-09-17的各波动率 figure 19
Strike_test_7_7=[];HV5_test_7_7=[];BS_IV_test_7_7=[]; Heston_IV_test_7_7=[];ImpliedVolatility_test_7_7=[];
for i=1:length(Time_test)
    if Time_test(i)==30./252
        Strike_test_7_7=[Strike_test_7_7,Strike_test(i)]
        HV5_test_7_7=[HV5_test_7_7,HV5_test(i)];
        BS_IV_test_7_7=[BS_IV_test_7_7,BS_IV_test(i)];
        Heston_IV_test_7_7=[Heston_IV_test_7_7,Heston_IV_test(i)];
        ImpliedVolatility_test_7_7=[ImpliedVolatility_test_7_7,ImpliedVolatility_test(i)];
    end
end
plot(Strike_test_7_7,ImpliedVolatility_test_7_7,'b.-');
hold on
plot(Strike_test_7_7,HV5_test_7_7,'r--');
hold on
plot(Strike_test_7_7,BS_IV_test_7_7,'g-.');
hold on
plot(Strike_test_7_7,Heston_IV_test_7_7,'k-');
hold on
legend('Market-IV', 'HV-252', 'BS-IV','Heston-IV' ,'location','best');
xlabel('Strike');ylabel('Volatility');  
title('Date:2020-09-17');
%% 画价格拟合图 figure 20
for k=1:length(A)-1
    subplot(5,2,k);
    plot(Time_test(A(k):A(k+1)-1),MarketPrice_test(A(k):A(k+1)-1),'b.-');
    hold on
    plot(Time_test(A(k):A(k+1)-1),Call5_test(A(k):A(k+1)-1),'--g');
    hold on
    plot(Time_test(A(k):A(k+1)-1),Call7_test(A(k):A(k+1)-1),'--r');
    hold on
    plot(Time_test(A(k):A(k+1)-1),Call8_test(A(k):A(k+1)-1),'-k');
    hold on
    %xlabel('Time');ylabel('Prices');
    a=Strike_test(A(k));
   title(['K= ',  num2str(a)])

end
legend({'MarketPrice','BS-HV(252)','BS-IV','Heston','location','best'});
