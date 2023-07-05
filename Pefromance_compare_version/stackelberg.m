function [epoch,action_user,jam_channel,theta_user,theta_jam] = stackelberg(distance)
%% 参数初始化
global channel_num jammer_num user_num L T
epoch = 99; % 训练轮次
T = 99; % 每轮次时隙个数
b_1 = 0.18; % 学习步长
tao = 0.000001; % 折扣因子
k_jam = 0.08; % 干扰机Q-学习的学习率
theta_user = 1/channel_num .* ones(T+1,channel_num,user_num);
theta_jam  = 1/channel_num .* ones(epoch+1,channel_num,jammer_num);
action_user = zeros(user_num,T); % 用户n在时隙t选择的信道
utility_user = zeros(user_num,T); % 用户n在时隙t的效用值
utility_jammer = zeros(jammer_num,T); %干扰机再时隙t的效用值
Q_table = zeros(channel_num,epoch+1,jammer_num);
jam_channel = zeros(jammer_num,epoch); % 干扰机每个轮次选择干扰的信道
%% 迭代开始
for episode = 1:epoch
    for j = 1:jammer_num
        jam_channel(j,episode) = randsrc(1,1,[1:channel_num;theta_jam(episode,:,j)]); % 干扰机根据概率分布选择要干扰的信道
    end
   %% 跟随者子博弈: 用户的迭代过程
    for t = 1:T
        %% 每个用户先选择信道
        for i = 1:user_num
            % 用户i基于概率选择信道
            action_user(i,t) = randsrc(1,1,[1:channel_num;theta_user(t,:,i)]);
        end
        %% 再更新每个用户的效用值
        for j = 1:user_num
            % 用户j逐个更新效用
            utility_user(j,t) = utility_user_update(action_user(:,t),jam_channel(:,episode),distance,j);
        end
        %% 每个用户更新策略----信道选择概率
        for i = 1:user_num
            for m = 1:channel_num
                if action_user(i,t)==m
                    theta_user(t+1,m,i) = theta_user(t,m,i) + b_1*utility_user(i,t)/L * (1-theta_user(t,m,i));
                    if theta_user(t+1,m,i) > 1
                        theta_user(t+1,m,i) = 1;
                    end
                else
                    theta_user(t+1,m,i) = theta_user(t,m,i) - b_1 * utility_user(i,t)/L * theta_user(t,m,i);
                    if theta_user(t+1,m,i) < 0
                        theta_user(t+1,m,i) = 0;
                    end
                end
            end
            % 根据权重归一化概率
            sum_theta_user = sum(theta_user(t+1,:,i));
            for n = 1:channel_num
                theta_user(t+1,n,i) = theta_user(t+1,n,i) / sum_theta_user;
            end
        end
    end
    %% 领导者子博弈：干扰机迭代
    %% 干扰机更新效用值
    for j = 1:jammer_num
        utility_jammer(j,episode) = utility_jammer_update(action_user(:,T),jam_channel,distance,episode,j);
        Q_table(jam_channel(j,episode),episode+1,j) = (1-k_jam)*Q_table(jam_channel(j,episode),episode,j) + k_jam*utility_jammer(j,episode);
    end
	%% 干扰机更新选择概率
    for k = 1: jammer_num
        for i = 1:channel_num
            theta_jam(episode+1,i,k) = exp(Q_table(i,episode,k)/tao) / sum(exp(Q_table(:,episode,k)/tao));
        end
        sum_theta_jam = sum(theta_jam(episode+1,:,k));
        for j = 1:channel_num
            theta_jam(episode+1,j,k) = theta_jam(episode+1,j,k) / sum_theta_jam;
        end
    end
end
% save data
end