function total_jam = sum_user_utility(action,jam_channel,distance)
global user_num jammer_num power_jammer power_user ...
       alpha_1 alpha_2 beita beita_jam
summer = 0;sum_jam = 0;total_jam = 0;
for i = 1:user_num
    for j = 1:user_num
        if j~=i 
            H = distance(i,j) ^ (-alpha_1) * beita(i,j,action(i));
            summer = summer + power_user * power_user * H * (action(i)==action(j));
        end        
    end
    for k = 1:jammer_num
        if action(i) == jam_channel(k)
            H_jam = distance(user_num+k,i) ^ (-alpha_2) * beita_jam(i,jam_channel(k));
            sum_jam = sum_jam + power_user * power_jammer * H_jam;
        end
    end
    total_jam = total_jam + summer + sum_jam;
end
end

