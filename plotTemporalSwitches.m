function plotTemporalSwitches(statesflips, Fs)
%Plot Temporal Switches
% INPUT:
% statesflips - vector with values of states for particular time steps.

if nargin < 2
    Fs = 0;
end
%TODO make sure that it works regardless of shape
statesflips = statesflips';
Ndat = length(statesflips);

statesflipscode = zeros(size(statesflips));
ii = 1;
for s = unique(statesflips)
    statesflipscode(find(statesflips==s)) = ii;
    ii = ii+1;
end

rectstates = repmat(statesflipscode,20,1);
imageX = 1:size(rectstates,2);
imageY = 1:size(rectstates,1);
imagesc(imageX,imageY,rectstates)
unx=unique(statesflipscode);

myColorMap = jet(length(unx));
myColorMap(1,:) = 0.1;
myColorMap(length(unx),:) = 0.9;
colormap(myColorMap);
h = colorbar('Ticks',unx);
set(gcf, 'Position', [300, 400, 1100, 300])
%if length(unique([unx(2) unx(end)]))==1
%   set(h, 'ylim', [unx(2)-10 unx(2)+10])
%else
%    set(h, 'ylim', [unx(2) unx(end)])
%end
set(gca,'ytick',[])

if Fs > 0
    set(gca,'xtick',linspace(1,Ndat,15))
    xticklabels(round(linspace(1/Fs,Ndat/Fs,15)))
    xlabel('time [s]')
end

end

