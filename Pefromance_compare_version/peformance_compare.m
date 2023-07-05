function [hla_jam,rand_jam,no_jam,hla_jamming,rand_jamming]=peformance_compare(action_user,jam_channel,distance,epoch)
% action_user : user_num * T
% jamm_channel: jammer_num * epoch
global user_num jammer_num channel_num T
% action_user(:,T)
% jam_channel(:,epoch);
[rand_jam,rand_jamming] = deal(zeros(25,1),zeros(25,1));
hla_jam = sum_user_utility(action_user(:,T),jam_channel(:,epoch),distance); % ���������㷨
hla_jamming = sum_jammer_utility(action_user(:,T),jam_channel(:,epoch),distance); % ������������㷨
no_jam = sum_user_utility(action_user(:,T),zeros(jammer_num,1),distance); % �޸��Ż������

for i = 1:25
    random_user = randsrc(user_num,1,[1:channel_num;1/channel_num * ones(1,channel_num)]); % �û����ѡ���ŵ�
    rand_jam(i) = sum_user_utility(random_user,jam_channel(:,epoch),distance);
    random_jammer = randsrc(jammer_num,1,[1:channel_num;1/channel_num*ones(1,channel_num)]);
    rand_jamming(i) = sum_jammer_utility(action_user(:,T),random_jammer,distance); % ������Ų���
end
rand_jam = sum(rand_jam)/25;
rand_jamming = sum(rand_jamming)/25;
end