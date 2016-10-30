clear all;
close all;

%x = load('output.txt');
x = load('output 23.txt');
figure;
plot(x);
% title('raw x');%%30.7
% [lb, la] = butter(4, 0.2);
% x = filter(lb, la, x);
% figure;
% plot(x);
% title('filtered x');%30.2740

% [lb, la] = butter(4, 0.1);
% x = filter(lb, la, x);
% figure;
% plot(x);
% title('filtered 0.1 x');%30.2805


t = 1:length(x);
dt = 0.01;
dx = 0;
vx = 0;


for i=1:length(x)-1
    vx = vx + (x(i) + x(i+1)) / 2 * dt;
    if vx > 0
        dx = dx + vx * dt
    end
    Xarrary(i)=dx;
    vxarray(i) = vx;
end

dx * 9.81 * 100

figure;
% title('Before filter');
plot(vxarray);

max = max(vxarray);
min = min(vxarray);
diff = 0 - min;


startIdx = find(vxarray > 0.001, 1);
maxIdx = find(vxarray == max, 1);
minIdx = find(vxarray == min, 1);

% remove data after min
%vxarray = vxarray(1:minIdx);

% fix data after maxIdx
vxarray(maxIdx:end) = vxarray(maxIdx:end) + diff;

% fix data between startIdx and maxIdx-1
ratio = repmat((max + diff)/max - 1, [1, maxIdx-startIdx]);
i=1:maxIdx-startIdx
curve = (1.001.^i - 1) / (1.001^(maxIdx-startIdx) - 1);
ratio = ratio .* curve;
    
vxarray(startIdx:maxIdx-1) = vxarray(startIdx:maxIdx-1) .* (ratio + 1);

dx1 = 0
for i=1:length(vxarray)
    dx1 = dx1 + vxarray(i) * dt;
    XParrary1(i)=dx1;
end
dx1 * 9.81 * 100


hold on;
% title('After filter');
plot(vxarray);
hold off;
legend('Before filetered','After filtered')
title('Velocity');
ylabel('Velocity(m/s)');
xlabel('Sample');
figure;
plot(Xarrary*9.8*100);
hold on;
plot(XParrary1*9.8*100);
% plot()
hold off;
legend('Before filetered','After filtered')
title('position');
ylabel('Position(cm)');
xlabel('Sample');
