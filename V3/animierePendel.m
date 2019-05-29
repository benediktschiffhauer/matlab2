function animierePendel( vT, mX, stPendel, hAxes, exportVideo)

prescaler = 1;
makeVideo = 0;

if nargin == 5
    makeVideo = 1;
%     vFrames = [];
end

nFrames = length(vT);
l1 = stPendel.l1;
l2 = stPendel.l2;
totalLength = l1 + l2;

axes(hAxes);
grid on;

axis(totalLength*[-1 1 -1 1]);

for i = 1:nFrames
    if i > 1
        delete(lastPlot);
    end
    title(strcat('t=',num2str(vT(i)),'s'));
    phi1 = mX(i,1);
    phi2 = mX(i,3);
    lastPlot = line([0, l1*sin(phi1), l1*sin(phi1)+l2*sin(phi2)],[0, -l1*cos(phi1), -l1*cos(phi1)-l2*cos(phi2)]);
    if i < nFrames
        pause((vT(i+1)-vT(i))*prescaler);
    end
    if makeVideo
        if i == 1
            vFrames = getframe(hAxes);
        else
            vFrames(end+1) = getframe(hAxes);
        end
    end
end

if makeVideo
    v = VideoWriter('animation.avi');
    open(v);
    writeVideo(v,vFrames);
    close(v);
end
end

