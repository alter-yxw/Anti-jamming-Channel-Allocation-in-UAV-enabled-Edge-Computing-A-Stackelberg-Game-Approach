function utility = utility_user_update(action,jamming,distance,index)
%   ����û������û�����action��Ч��ֵ
%   action: N*1
%   jamming: 1*1
%   distance: (N+1)*N ��N+1�� Ϊ����Ż��ľ���
%   index:��Ҫ���µ��û�������
global user_num jammer_num power_user power_jammer ...
       alpha_1 alpha_2 beita beita_jam L
summer = 0;
sum_jam = 0;
for i = 1:user_num
    if i ~= index
        H = distance(index,i) ^ (-alpha_1) * beita(index,i,action(index)); % ˲ʱ����
        summer = summer + power_user * power_user * H * (action(index)==action(i));
    end
end
for j = 1:jammer_num
    H_jam = distance(user_num+j,index)^(-alpha_2) * beita_jam(index,jamming(j));
    sum_jam = sum_jam + power_user * power_jammer * H_jam * (action(index) == jamming(j));
end
utility = L - summer - sum_jam;
end