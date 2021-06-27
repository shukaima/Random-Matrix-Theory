modenum = 21;
for ib = 1:Nbond
    
    ib
    
    
    clear data
    tempre=['lineTest_' num2str(ib) '.txt'];
    fname=['G:\Shared drives\Anlage Team Drive for Simulation\Shukai Ma\Comsol\trivialPC\' tempre];
    data = load(fname);
    
    [Ngrid,Nmode] = size(data); Nmode = Nmode - 3;
    Ltot(ib) = sqrt((data(end,1)-data(1,1))^2 + (data(end,2)-data(1,2))^2 ...
        + (data(end,3)-data(1,3))^2);
    
    dl(ib) = sqrt((data(2,1)-data(1,1))^2 + (data(2,2)-data(1,2))^2 ...
        + (data(2,3)-data(1,3))^2);
    
%     mdl(ib) = sqrt((data(end,1)-data(1,1))^2 + (data(end,2)-data(1,2))^2 ...
%         + (data(end,3)-data(1,3))^2)/length(data);
    
    for i = modenum:modenum
        temp = data(:,i+3);
        modeEz(1:length(temp),ib) = (temp);
        clear temp
    end

end
%%
L = sum(Ltot);
clear v aa ss

    aa = modeEz;
    ss = sum(sum(dl.*abs(aa).^2));
    psi2A = (L.*aa.^2/ss);

    v= abs(psi2A(:))';


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
title(['On-line field extract result for mode # ' num2str(modenum)])
set(gca, 'YScale', 'log')
legend