function distance = get_distance(user,jammer)
%   获取各用户之间以及和干扰机之间地距离
%   输入: user; jammer 用户 与 干扰机 的坐标信息
%   输出: dis 距离矩阵: N+1 * N
global user_num jammer_num
dis = zeros(user_num + jammer_num,user_num);
dis_func = @(x,y)sqrt((x(1)-y(1))^2 + (x(2)-y(2))^2); % 求距离的函数式
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