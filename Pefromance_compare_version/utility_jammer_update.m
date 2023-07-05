function utility = utility_jammer_update(user,jammer,distance,episode,index)
global user_num power_jammer power_user beita_jam alpha_2
summer = 0;
jamming = jammer(index,episode);
for i = 1:user_num
    H_jam = distance(user_num+index,i) ^ (-alpha_2) * beita_jam(i,jamming);
    summer = summer + power_jammer * power_user * H_jam * (user(i)==jamming);
end
utility = summer;
end