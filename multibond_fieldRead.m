clear;clc
Nbond = 14;
clear meanEz midEz temp
Ltot = zeros(Nbond,1);

for ib = 1:Nbond
    
    ib
    
    clear data
    tempre=['lineTest_' num2str(ib) '.txt'];
    fname=['G:\Shared drives\Anlage Team Drive for Simulation\Shukai Ma\Comsol\trivialPC\' tempre];
    data = load(fname);
    
    [Ngrid,Nmode] = size(data); Nmode = Nmode - 3;
    Ltot(ib) = sqrt((data(end,1)-data(1,1))^2 + (data(end,2)-data(1,2))^2 ...
        + (data(end,3)-data(1,3))^2);

    for i = 1:Nmode
        temp = data(:,i+3);
        meanEz(ib,i) = mean(temp);
        midEz(ib,i) = temp(floor(Ngrid/2));
        clear temp
    end

end

%%
L = sum(Ltot);
clear v
for i = 1:Nmode
%     aa = midEz(:,i);
    aa = meanEz(:,i);
    clear ss
    ss = sum(Ltot.*abs(aa).^2);
    psi2A = (L*aa.^2/ss);

    v(i,:) = abs(psi2A(:))';
end

v = v(:);
h=figure;

x1=min(min(v));
x2=max(max(v));

dx=0.2;
xx=[x1:dx:x2];
xd=[x1/10:dx/10:7];
yd=hist(v,xx);
yall=sum(yd)*dx;
yt = 1./(2*pi*xd).^0.5.*exp(-xd/2);
ys = 4*xd.*exp(-xd*2);
plot(xx,yd/yall,'-o'); hold on
plot(xd,yt,'DisplayName','GOE');hold on
plot(xd,exp(-xd),'DisplayName','GUE');hold on
plot(xd,ys,'DisplayName','GSE');hold on
ylim([1e-3,10])
xlim([0,7])
xlabel('v');
ylabel('P(v)');
% title(['12GHz, bin = ' num2str(dx)])
set(gca, 'YScale', 'log')
legend