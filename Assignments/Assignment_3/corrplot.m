function [] = corrplot(avgnum,diri,dirq, refi,refq, refcomp, refdef)

%Inputs
    % avgnum: user input msec to avg
    %other inputs are figure handles of respective gui graphs
    
%reflected spacings  (same as those used in processing)
spacing=-28.1:0.05:1.1; %recognize these spacings are reversed
[a,b]=size(spacing);
spacing2=spacing(find(spacing==(-spacing(end))):end);
[aa,bb]=size(spacing2);

%set filenames
fid1=fopen('OutDI.bin','rb');
fid2=fopen('OutDQ.bin','rb');
fid3=fopen('OutRI.bin','rb');
fid4=fopen('OutRQ.bin','rb');

%set avging - typical value is 200msec
disp('BiStatic Radar Processing')


%get the first set of data to initiate loop
contloop=1;
[corri,cnt]=fread(fid1,avgnum*bb,'float');
if (cnt ~= avgnum*bb)
    fclose all
    disp('got all the data possible corr_dir_in')
    contloop=0;
end
[corrq,cnt]=fread(fid2,avgnum*bb,'float');
if (cnt ~= avgnum*bb)
    fclose all
    disp('got all the data possible corr_dir_qd')
    contloop=0;
end
[corrii,cnt]=fread(fid3,avgnum*b,'float');
if (cnt ~= avgnum*b)
    fclose all
    disp('got all the data possible corr_rfct_in')
    contloop=0;
end
[corrqq,cnt]=fread(fid4,avgnum*b,'float');
if (cnt ~= avgnum*b)
    fclose all
    disp('got all the data possible corr_rfct_in')
    contloop=0;
end

loopcnt=1;
while (contloop==1) %infinite loop to continue while data in the files
    
    corri=reshape(corri,bb,avgnum);
    corrq=reshape(corrq,bb,avgnum);
    corrii=reshape(corrii,b,avgnum);
    corrqq=reshape(corrqq,b,avgnum);
    
    %----------------------------------------------------------------------
    
    coherent=0;  %set equal to 1 for coherent, or 0 for noncoherent
    if (coherent)
        for inda = 1:avgnum
            [signmax,signind]=max(abs(corri(:,inda)));
            if (corri(signind,inda) >= 0)
                %no need to do anything as already post
            else
                %flip sign to make it pos
                corri(:,inda) = -1 .* corri(:,inda);
                corrq(:,inda) = -1 .* corrq(:,inda);
                corrii(:,inda) = -1 .* corrii(:,inda);
                corrqq(:,inda) = -1 .* corrqq(:,inda);
            end
        end
        di2=sum((corri'));
        dq2=sum((corrq'));
        ri2=sum((corrii'));
        rq2=sum((corrqq'));
    else
        di2=sum(abs(corri'));
        dq2=sum(abs(corrq'));
        ri2=sum(abs(corrii'));
        rq2=sum(abs(corrqq'));
    end
    %----------------------------------------------------------------------
    
    %do the averaging
    %reorder
    di2=di2(bb:-1:1);
    dq2=dq2(bb:-1:1);
    d3=sqrt(di2 .* di2 + dq2 .* dq2);
    d3save(loopcnt,:)=d3;
    
    %find max and normalize
    ddmax=max(d3);
    di2=di2 ./ ddmax;
    dq2 = dq2 ./ ddmax;
    d3 = d3 ./ ddmax;
    
    %do avg
    %reorder
    ri2=ri2(b:-1:1);
    rq2=rq2(b:-1:1);
    r3=sqrt(ri2 .* ri2 + rq2 .* rq2);
    r3save(loopcnt,:)=r3;
    
    %find max and normalize
    rrmax=max(r3); %use for normalization
    [rrmaxrat,jj]=max(r3(66:b)); %use for max ratio
    ii=jj+55;
    ri2=ri2 ./ rrmax;
    rq2 = rq2 ./ rrmax;
    r3 = r3 ./ rrmax;
    
    %% update plots to plot to corressponding gui figures using UIaxes
    %%handles
    dmin=min([di2 dq2]);
    d3min=min([d3]);
    plot(diri,spacing2,di2,'r.');
    hold(diri,'on');
    plot(diri,spacing2,di2,'c');
    hold(diri,'off');
    axis([(spacing2(1)-0.1) (spacing2(end)+0.1) (dmin-0.05) 1.05])
    title(diri,'direct (I)')
    
    plot(dirq,spacing2,dq2,'g.');
    hold(dirq,'on');
    plot(dirq,spacing2,dq2,'c');
    hold(dirq,'off');
    axis([(spacing2(1)-0.1) (spacing2(end)+0.1) (dmin-0.05) 1.05])
    title(dirq,'direct (Q)')
    
    plot(refdef,spacing2,d3,'b.');
    hold(refdef,'on');
    plot(refdef,spacing2,d3,'m');
    hold(refdef,'off')
    axis([(spacing2(1)-0.1) (spacing2(end)+0.1) (d3min-0.05) 1.05])
    powerrat(loopcnt) = rrmaxrat / ddmax;
    
    %reflected signal
    title(refdef,['reflected/direct ratio: ',num2str(powerrat(loopcnt))])
    rmin=min([ri2 rq2]);
    r3min=min([r3]);
    plot(refi,-spacing(end:-1:1),ri2,'r.');
    hold(refi,'on');
    plot(refi,-spacing(end:-1:1),ri2,'c');
    hold(refi,'off');
    axis([(-spacing(end)-0.1) (-spacing(1)+0.1) (rmin-0.05) 1.05])
    title(refi,'reflect (I)')
    plot(refq,-spacing(end:-1:1),rq2,'g.');
    hold(refq,'on')
   plot(refq,-spacing(end:-1:1),rq2,'c');
   hold(refq, 'off')
    axis([(-spacing(end)-0.1) (-spacing(1)+0.1)  (rmin-0.05) 1.05])
    title(refq,'reflect (Q)')
   plot(refcomp,-spacing(end:-1:1),r3,'b.');
   hold(refcomp, 'on')
    plot(refcomp,-spacing(end:-1:1),r3,'m');
    hold(refcomp,'off')
    axis([(-spacing(end)-0.1) (-spacing(1)+0.1)  (r3min-0.05) 1.05])
    
    %set lower bound on where max can be, in case of direct creeping in
    spthresh=find(spacing > 0.75);
    lwbnd=spthresh(1);
    upbnd=b;
    pathdelay(loopcnt)=293*ii*0.05;
    title(refcomp,['reflected composite; path delay of ',num2str(pathdelay(loopcnt),6),'m '])
    xlabel(refcomp,['time elapsed : ',num2str(loopcnt*avgnum/(60*1000),4),' min; Int#:',int2str(loopcnt)])
    
    [corri,cnt]=fread(fid1,avgnum*bb,'float');
    if (cnt ~= avgnum*bb)
        disp('  got all the data possible corr_dir_in')
        contloop=0;
    end
    [corrq,cnt]=fread(fid2,avgnum*bb,'float');
    if (cnt ~= avgnum*bb)
        disp('  got all the data possible corr_dir_qd')
        contloop=0;
    end
    [corrii,cnt]=fread(fid3,avgnum*b,'float');
    if (cnt ~= avgnum*b)
        disp('  got all the data possible corr_rfct_in')
        contloop=0;
    end
    [corrqq,cnt]=fread(fid4,avgnum*b,'float');
    if (cnt ~= avgnum*b)
        disp('  got all the data possible corr_rfct_in')
        contloop=0;
    end
    loopcnt = loopcnt +1 ;
    %% added longer pause to allow graphs to be seen 
    pause(0.5)
end
loopcnt=loopcnt-1;  %adjust for not doing one last iteration

%draw fig of path delay as function of time
figure(200)
subplot(2,1,1),plot((1:loopcnt)*(avgnum/1000),pathdelay,'c');hold on
subplot(2,1,1),plot((1:loopcnt)*(avgnum/1000),pathdelay,'c.');
title(['Estimated Path Delay for Reflected Signal (',int2str(avgnum),' msec avg)'])
ylabel('meters')
xlabel('seconds')
grid
subplot(2,1,2),plot((1:loopcnt)*(avgnum/1000),powerrat,'b.');hold on
subplot(2,1,2),plot((1:loopcnt)*(avgnum/1000),powerrat,'g');hold off
title(['Amplitude Ratio ((reflected max)/(direct max))'])
ylabel('ratio')
xlabel('seconds')
grid
fclose all;

