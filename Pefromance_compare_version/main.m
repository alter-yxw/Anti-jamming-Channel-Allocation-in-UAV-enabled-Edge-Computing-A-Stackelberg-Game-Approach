%% 参数初始化
clear;clc
global T
N = [8];%,8,8];%[8,8,8,8,8,8];  用户个数
M = [4];%,4,4];%[4,4,4,4,4,4];  可用信道个数
J = [3];%,2,3];%[1,1,1,3,3,3];  干扰机个数
cishu = length(N);
times = 50;
[hla_user,rand_user,no_jam,hla_jamming,rand_jamming]= ...
                        deal(zeros(times+1,cishu),zeros(times+1,cishu),zeros(times+1,cishu),zeros(times+1,cishu),zeros(times+1,cishu));
%% 算法对比
for g = 1:cishu
    distance = data_initial(N(g),J(g),M(g)); %INPIUT: USER_NUM, JAMMER_NUM, CHANNEL_NUM
    for i = 1:times
        [epoch,action_user,jam_channel,theta_user,theta_jam] = stackelberg(distance);
        fprintf('Epoch: %d/%d    Completed: %.0f%%\n',g,cishu,i/times*100);
        [hla_user(i,g),rand_user(i,g),no_jam(i,g),hla_jamming(i,g),rand_jamming(i,g)]= ...
        peformance_compare(action_user,jam_channel,distance,epoch);
    end
    hla_user(times+1,g) = sum(hla_user(1:times,g))/times;
    rand_user(times+1,g) = sum(rand_user(1:times,g))/times;
    no_jam(times+1,g) = sum(no_jam(1:times,g))/times;
    hla_jamming(times+1,g) = sum(hla_jamming(1:times,g))/times;
    rand_jamming(times+1,g) = sum(rand_jamming(1:times,g))/times;
end
figure
bar([hla_user(times+1,1:cishu);rand_user(times+1,1:cishu);no_jam(times+1,1:cishu)]')
legend('Proposed Algorithm','Random','No Jammer')
xlabel('User Number')
ylabel('Total Inteference and jamming of the System')
% figure
% plot(1:cishu,hla_user(times+1,1:cishu),'*-b');hold on
% plot(1:cishu,rand_user(times+1,1:cishu),'*-r');hold on
% plot(1:cishu,no_jam(times+1,1:cishu),'*-k');
% xlabel('Scenarios')
% ylabel('Inteference and jamming')
% legend('Proposed','RANDOM','NO-Jamming')
figure
plot(1:cishu,hla_jamming(times+1,1:cishu),'*-r');hold on
plot(1:cishu,rand_jamming(times+1,1:cishu),'*-k');
xlabel('scenarios')
ylabel('Jamming')
legend('PROPOSED','RANDOM')
%% 数据展示
figure
subplot(2,2,1)
plot(1:epoch+1,theta_jam(:,1,1),'.-g');hold on
plot(1:epoch+1,theta_jam(:,2,1),'.-b');hold on
plot(1:epoch+1,theta_jam(:,3,1),'.-r');hold on
plot(1:epoch+1,theta_jam(:,4,1),'.-k');%hold on
% plot(1:epoch+1,theta_jam(:,5,1),'.-c');hold on
% plot(1:epoch+1,theta_jam(:,6,1),'.-m');
xlabel('Epochs')
ylabel('Channel Selection Probability of Jammer')
legend('Channel-1','Channel-2','Channel-3','Channel-4');%),'channel-5','channel-6'
subplot(2,2,2)
plot(1:epoch+1,theta_jam(:,1,2),'.-g');hold on
plot(1:epoch+1,theta_jam(:,2,2),'.-b');hold on
plot(1:epoch+1,theta_jam(:,3,2),'.-r');hold on
plot(1:epoch+1,theta_jam(:,4,2),'.-k');%hold on
% plot(1:epoch+1,theta_jam(:,5,2),'.-y ');hold on
% plot(1:epoch+1,theta_jam(:,6,2),'.-m');
legend('channel-1','channel-2','channel-3','channel-4');%),'channel-5','channel-6'
subplot(2,2,3)
plot(1:epoch+1,theta_jam(:,1,3),'.-g');hold on
plot(1:epoch+1,theta_jam(:,2,3),'.-b');hold on
plot(1:epoch+1,theta_jam(:,3,3),'.-r');hold on
plot(1:epoch+1,theta_jam(:,4,3),'.-k');%hold on
% plot(1:epoch+1,theta_jam(:,5,3),'.-c');hold on
% plot(1:epoch+1,theta_jam(:,6,3),'.-m');
legend('Channel-1','Channel-2','Channel-3');%),'channel-4','channel-5','channel-6'
subplot(2,2,4)
plot(1:T+1,theta_user(:,1,1),'.-g');hold on
plot(1:T+1,theta_user(:,2,1),'.-b');hold on
plot(1:T+1,theta_user(:,3,1),'.-r');hold on
plot(1:T+1,theta_user(:,4,1),'.-k');%hold on
% plot(1:T+1,theta_user(:,5,1),'.-c');hold on
% plot(1:T+1,theta_user(:,6,1),'.-m');
xlabel('Slots')
ylabel('Channel Selection Probability of User')
legend('Channel-1','Channel-2','Channel-3','Channel-4');%,),'channel-5','channel-6'