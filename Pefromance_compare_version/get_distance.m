function distance = get_distance(user,jammer)
%   ��ȡ���û�֮���Լ��͸��Ż�֮��ؾ���
%   ����: user; jammer �û� �� ���Ż� ��������Ϣ
%   ���: dis �������: N+1 * N
global user_num jammer_num
dis = zeros(user_num + jammer_num,user_num);
dis_func = @(x,y)sqrt((x(1)-y(1))^2 + (x(2)-y(2))^2); % �����ĺ���ʽ
for i = 1:user_num
    for j = 1:i
        dis(i,j) = dis_func(user(i,:),user(j,:));
        dis(j,i) = dis(i,j);
    end
end
for k = 1:user_num
    for j = 1:jammer_num
        dis(user_num+j,k) = dis_func(user(k,:),jammer(j,:));
    end
end
distance = dis;
end