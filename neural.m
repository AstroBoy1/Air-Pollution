data = xlsread('reflectData.xlsx');
x = data(:,1)';
t = data(:,2)';
net = fitnet(10);
net = train(net,x,t);
y = net(x);
perf = perform(net,y,t); % mean squared error