function [epoch,action_user,jam_channel,theta_user,theta_jam] = stackelberg(distance)
%% ������ʼ��
global channel_num jammer_num user_num L T
epoch = 99; % ѵ���ִ�
T = 99; % ÿ�ִ�ʱ϶����
b_1 = 0.18; % ѧϰ����
tao = 0.000001; % �ۿ�����
k_jam = 0.08; % ���Ż�Q-ѧϰ��ѧϰ��
theta_user = 1/channel_num .* ones(T+1,channel_num,user_num);
theta_jam  = 1/channel_num .* ones(epoch+1,channel_num,jammer_num);
action_user = zeros(user_num,T); % �û�n��ʱ϶tѡ����ŵ�
utility_user = zeros(user_num,T); % �û�n��ʱ϶t��Ч��ֵ
utility_jammer = zeros(jammer_num,T); %���Ż���ʱ϶t��Ч��ֵ
Q_table = zeros(channel_num,epoch+1,jammer_num);
jam_channel = zeros(jammer_num,epoch); % ���Ż�ÿ���ִ�ѡ����ŵ��ŵ�
%% ������ʼ
for episode = 1:epoch
    for j = 1:jammer_num
        jam_channel(j,episode) = randsrc(1,1,[1:channel_num;theta_jam(episode,:,j)]); % ���Ż����ݸ��ʷֲ�ѡ��Ҫ���ŵ��ŵ�
    end
   %% �������Ӳ���: �û��ĵ�������
    for t = 1:T
        %% ÿ���û���ѡ���ŵ�
        for i = 1:user_num
            % �û�i���ڸ���ѡ���ŵ�
            action_user(i,t) = randsrc(1,1,[1:channel_num;theta_user(t,:,i)]);
        end
        %% �ٸ���ÿ���û���Ч��ֵ
        for j = 1:user_num
            % �û�j�������Ч��
            utility_user(j,t) = utility_user_update(action_user(:,t),jam_channel(:,episode),distance,j);
        end
        %% ÿ���û����²���----�ŵ�ѡ�����
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
            % ����Ȩ�ع�һ������
            sum_theta_user = sum(theta_user(t+1,:,i));
            for n = 1:channel_num
                theta_user(t+1,n,i) = theta_user(t+1,n,i) / sum_theta_user;
            end
        end
    end
    %% �쵼���Ӳ��ģ����Ż�����
    %% ���Ż�����Ч��ֵ
    for j = 1:jammer_num
        utility_jammer(j,episode) = utility_jammer_update(action_user(:,T),jam_channel,distance,episode,j);
        Q_table(jam_channel(j,episode),episode+1,j) = (1-k_jam)*Q_table(jam_channel(j,episode),episode,j) + k_jam*utility_jammer(j,episode);
    end
	%% ���Ż�����ѡ�����
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