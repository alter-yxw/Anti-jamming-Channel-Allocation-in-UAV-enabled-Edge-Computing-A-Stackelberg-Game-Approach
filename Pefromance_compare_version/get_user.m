function user = get_user(device,uav,bs)
global user_num
user = zeros(user_num,2);
user(1,:) = (device(1,:) + uav(4,:)) / 2;
user(2,:) = (device(2,:) + bs(1,:)) / 2;
user(3,:) = (device(3,:) + uav(6,:)) / 2;
user(4,:) = (device(4,:) + uav(3,:)) / 2;
user(5,:) = (device(5,:) + uav(4,:) + bs(2,:)) / 3;
user(6,:) = (device(6,:) + uav(2,:)) / 2;
user(7,:) = (device(7,:) + uav(2,:)) / 2;
user(8,:) = (device(8,:) + uav(1,:)) / 2;
user(9,:) = (device(9,:) + uav(1,:)) / 2;
user(10,:)= (device(10,:)+ uav(1,:)) / 2;
end