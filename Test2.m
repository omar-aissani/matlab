close all; clc; 

%% Setting Up Figure
fig = figure(1);
clf(fig);
ax = axes(fig);
ax.XLim = [-5 5];
ax.YLim = [-5 5];
ax.ZLim = [-5 5];
ax.NextPlot = 'add';
ax.XAxisLocation = 'origin';
%ax.XAxis.Color = [223, 32, 35]/255;
ax.XAxis.LineWidth = 0.75;
ax.XAxis.TickLabelColor = 0.5*[1 1 1];
ax.YAxisLocation = 'origin';
%ax.YAxis.Color = [32, 223, 32]/255;
ax.YAxis.LineWidth = 0.75;
ax.YAxis.TickLabelColor = 0.5*[1 1 1];
% ax.ZAxisLocation = 'origin'; % Property doesn't exist
%ax.ZAxis.Color = [65, 105, 225]/255;
ax.ZAxis.LineWidth = 0.75;
ax.ZAxis.TickLabelColor = 0.5*[1 1 1];
ax.Box = 'on';
ax.BusyAction = 'cancel';
ax.HitTest = 'off';
ax.PickableParts = 'none';

%grid(ax);
pbaspect(ax, [1 1 1]);
view(ax, 45, 25);

%% Code
c = Cube(1, 3, 2);
d = Cube(4.5, 0.5, 0.5);

c.ax = ax;
d.ax = ax;

c.FaceColor = [153, 51, 102] / 255;
d.FaceColor = [1 1 0];

d.type = 'bottom';
c = c.Create();
d = d.Create();

x = 0;
theta = 0; dtheta = 1;
phi = 25; dphi = 1.5;
psi = -15; dpsi = -1.8;

%c.Hide();
for t = 0:0.01:15
    x = 2*sin(0.8*2*pi*t);

    c.HT(1:3, 1:3) = rotz(theta)*roty(phi)*rotx(psi);
    c.HT(1, 4) = x;

    d.HT(1:3, 1:3) = rotx(phi);
    
    
    c = c.Update();
    d = d.Update();

    theta = theta + dtheta;
    phi = phi + dphi;
    psi = psi - dpsi;
    
    pause(0.01);
end

clearvars -except c fig
