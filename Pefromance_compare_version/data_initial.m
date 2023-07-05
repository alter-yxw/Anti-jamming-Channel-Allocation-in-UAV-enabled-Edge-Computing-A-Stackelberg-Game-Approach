function [distance] = data_initial(N,J,M)
global channel_num user_num jammer_num power_user power_jammer ...
       alpha_1 alpha_2 beita beita_jam L
user_num = N; % �û��ĸ���
channel_num = M; % �ŵ�����
jammer_num = J; % ���Ż�����
power_user = 2; % �û�����: 2W
power_jammer = 25; % ���Ż�����: 25W
alpha_1 = 2; alpha_2 = 2; % ·��������Ӧ�1=��2=2;
L = 0.005; % ������
end_device =[633,958;98,486;859,801;547,142;576,650;60,732;235,648;354,451;234,453;487,125];  % �ն��û����� 
uav = [[250,250];[250,750];[500,250];[500,750];[750,250];[750,750]]; % randi(1000,uav_num,2); % ���˻�����
bs = [[250,500];[750,500]]; % ��վ������
% offload_rate = [0.038,0.0519,0.0589,0.0691,0.0784,0.0519,0.0589,0.0755;... %��������
%                 0,0.9481,0,0,0,0,0,0;... % ж������վ�ı���
%                 0.9620,0,0.9411,0.9309,0,0.9481,0.9411,0.9245;... % ж�������˻��ı���
%                 0,0,0,0,0.9216,0,0,0]; % �м�ж�ر���
user = get_user(end_device,uav,bs);%[34,98;12,45;76,45;33,56;57,90;63,24;25,12;13,78]; % ����ÿ���û�������
jammer = [1200,1200;0,1200;1200,0]; % ���Ż�������
distance = get_distance(user,jammer);
beita = rand(user_num,user_num,channel_num); % ˲ʱ˥��ϵ��
beita_jam = rand(user_num,channel_num);
save scenario
for r = 1:channel_num
    beita(:,:,r) = tril(beita(:,:,r),-1)+triu(beita(:,:,r)',0);
end
end