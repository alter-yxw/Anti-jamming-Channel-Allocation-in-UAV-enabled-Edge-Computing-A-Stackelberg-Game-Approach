function total_jamming = sum_jammer_utility(user,jammer,distance)
global user_num jammer_num power_jammer power_user beita_jam alpha_2
summer = 0;total_jamming = 0;
for k = 1:jammer_num
    for i = 1:user_num
        H_jam = distance(user_num+k,i) ^ (-alpha_2) * beita_jam(i,jammer(k));
        summer = summer + power_jammer * power_user * H_jam * (user(i)==jammer(k));
    end
    total_jamming = total_jamming + summer;
end
end