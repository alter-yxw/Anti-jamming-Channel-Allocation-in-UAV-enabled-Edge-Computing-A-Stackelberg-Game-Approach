function utility = utility_user_update(action,jamming,distance,index)
%   逐个用户计算用户动作action的效用值
%   action: N*1
%   jamming: 1*1
%   distance: (N+1)*N 第N+1行 为与干扰机的距离
%   index:需要更新的用户索引号
global user_num jammer_num power_user power_jammer ...
       alpha_1 alpha_2 beita beita_jam L
summer = 0;
sum_jam = 0;
for i = 1:user_num
    if i ~= index
        H = distance(index,i) ^ (-alpha_1) * beita(index,i,action(index)); % 瞬时干扰
        summer = summer + power_user * power_user * H * (action(index)==action(i));
    end
end
for j = 1:jammer_num
    H_jam = distance(user_num+j,index)^(-alpha_2) * beita_jam(index,jamming(j));
    sum_jam = sum_jam + power_user * power_jammer * H_jam * (action(index) == jamming(j));
end
utility = L - summer - sum_jam;
end