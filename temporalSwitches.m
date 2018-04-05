% Temporal Switches

%%%%%%%%%%%%% Test data
%data = randi([0 1], 4,100)*2-1;
%fromvec = 1:16;
%tovec   = [1 1 1 1 1 1 1 10 10 10 10 10 16 16 16 16];
%%%%%%%%%%%%% Real data
Ndat = 4000;
bltz = randsample(1:length(Eavg), Ndat, true, exp(-Eavg)/sum(exp(-Eavg)));
load('BasinGraph.mat')
fromvec = BasinGraph(:,1);
tovec   = BasinGraph(:,3);

nn = log2(fromvec(end));
binStates = mfunc_VectorList(nn);

data = binStates(:,bltz);

statesflips = zeros(1,size(data,2));
for i = 1:size(data,2)
   idx = find(sum(binStates==data(:,i))==nn);
   statesflips(i) = tovec(idx);
end

statesflipscode = zeros(size(statesflips));
ii = 1;
for s = unique(statesflips)
    statesflipscode(find(statesflips==s)) = ii;
    ii = ii+1;
end
%statesflipscode(find(statesflips==1))   = 0;
%statesflipscode(find(statesflips==ii-1)) = -1;

rectstates = repmat(statesflipscode,20,1);
imageX = 1:size(rectstates,2);
imageY = 1:size(rectstates,1);
imagesc(imageX,imageY,rectstates)
unx=unique(statesflipscode);
myColorMap = jet(length(unx));
myColorMap(1,:) = 0.1;
myColorMap(length(unx),:) = 0.9;
colormap(myColorMap);
h = colorbar('Ticks',unx)%,'TickLabels',[0 2:length(unx)]);
set(gcf, 'Position', [300, 400, 800, 250])
%if length(unique([unx(2) unx(end)]))==1
%   set(h, 'ylim', [unx(2)-10 unx(2)+10])
%else
%    set(h, 'ylim', [unx(2) unx(end)])
%end
set(gca,'ytick',[])
set(gca,'xtick',linspace(1,Ndat,10))
xticklabels(round(linspace(1/fs,Ndat/fs,10)*100)/100)
xlabel('time [s]')
