clear;clc
tempre='lineTest_10.txt';
fname=['G:\Shared drives\Anlage Team Drive for Simulation\Shukai Ma\Comsol\trivialPC\' tempre];

data = load(fname);
%%
[Ngrid,Nmode] = size(data); Nmode = Nmode - 3;
Ltot = sqrt((data(end,1)-data(1,1))^2 + (data(end,2)-data(1,2))^2 ...
    + (data(end,3)-data(1,3))^2);
meanEz = zeros(1,Nmode);
midEz = zeros(1,Nmode);
for i = 1:Nmode
    temp = data(:,i+3);
    meanEz(i) = mean(temp);
    midEz(i) = temp(floor(Ngrid/2));
    clear temp
end

