function [distance] = data_initial(N,J,M)
global channel_num user_num jammer_num power_user power_jammer ...
       alpha_1 alpha_2 beita beita_jam L
user_num = N; % 用户的个数
channel_num = M; % 信道个数
jammer_num = J; % 干扰机个数
power_user = 2; % 用户功率: 2W
power_jammer = 25; % 干扰机功率: 25W
alpha_1 = 2; alpha_2 = 2; % 路径损耗因子α1=α2=2;
L = 0.005; % 正常数
end_device =[633,958;98,486;859,801;547,142;576,650;60,732;235,648;354,451;234,453;487,125];  % 终端用户坐标 
uav = [[250,250];[250,750];[500,250];[500,750];[750,250];[750,750]]; % randi(1000,uav_num,2); % 无人机坐标
bs = [[250,500];[750,500]]; % 基站的坐标
% offload_rate = [0.038,0.0519,0.0589,0.0691,0.0784,0.0519,0.0589,0.0755;... %本地运算
%                 0,0.9481,0,0,0,0,0,0;... % 卸载至基站的比例
%                 0.9620,0,0.9411,0.9309,0,0.9481,0.9411,0.9245;... % 卸载至无人机的比例
%                 0,0,0,0,0.9216,0,0,0]; % 中继卸载比例
user = get_user(end_device,uav,bs);%[34,98;12,45;76,45;33,56;57,90;63,24;25,12;13,78]; % 生成每个用户的坐标
jammer = [1200,1200;0,1200;1200,0]; % 干扰机的坐标
distance = get_distance(user,jammer);
beita = rand(user_num,user_num,channel_num); % 瞬时衰落系数
beita_jam = rand(user_num,channel_num);
save scenario
for r = 1:channel_num
    beita(:,:,r) = tril(beita(:,:,r),-1)+triu(beita(:,:,r)',0);
end
end