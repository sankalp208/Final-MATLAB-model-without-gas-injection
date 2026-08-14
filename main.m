clear
clc
close all

%==========================================
% LOAD PARAMETERS
%==========================================

p = initial_parameters();

%==========================================
% INITIALIZE STATE
%==========================================

state = initialize_state(p);

%==========================================
% RUN TRANSIENT MODEL
%==========================================

[state,history] = transient_solver(p,state);

%==========================================
% SPATIAL GRID
%==========================================

z = linspace(0,p.H,p.N);

%==========================================
% TIME GRID
%==========================================

time = linspace(0,...
                p.t_end,...
                size(history.Ts,2));

%==========================================
% FIGURE 1
% FINAL SOLID TEMPERATURE PROFILE
%==========================================

figure

plot(state.Ts,...
     z,...
     'LineWidth',2)

set(gca,'YDir','reverse')

xlabel('Temperature (K)')
ylabel('Bed Height (m)')

title('Final Bed Temperature Profile')

grid on

%==========================================
% FIGURE 2
% SOLID TEMPERATURE EVOLUTION
%==========================================

figure

imagesc(time,...
        z,...
        history.Ts)

set(gca,'YDir','reverse')

xlabel('Time (s)')
ylabel('Bed Height (m)')

title('Solid Temperature Evolution')

colorbar

%==========================================
% FIGURE 3
% COKE DISTRIBUTION
%==========================================

figure

imagesc(time,...
        z,...
        history.Coke)

set(gca,'YDir','reverse')

xlabel('Time (s)')
ylabel('Bed Height (m)')

title('Coke Distribution')

colorbar

%==========================================
% FIGURE 4
% LOGARITHMIC COMBUSTION FRONT
%==========================================

figure

imagesc(time,...
        z,...
        log10(history.R + 1e-8))

set(gca,'YDir','reverse')

xlabel('Time (s)')
ylabel('Bed Height (m)')

title('Logarithmic Combustion Front')

colorbar

%==========================================
% FIGURE 5
% FINAL GAS TEMPERATURE PROFILE
%==========================================

figure

plot(state.Tg,...
     z,...
     'LineWidth',2)

set(gca,'YDir','reverse')

xlabel('Gas Temperature (K)')
ylabel('Bed Height (m)')

title('Final Gas Temperature Profile')

grid on

%==========================================
% FIGURE 6
% FLAME FRONT PROPAGATION
%==========================================

front_depth = zeros(size(time));

for k = 1:length(time)

    idx = find(history.Ts(:,k) > 600,...
               1,...
               'last');

    if ~isempty(idx)

        front_depth(k) = z(idx);

    end

end

figure

plot(time,...
     front_depth,...
     'LineWidth',2)

xlabel('Time (s)')
ylabel('Flame Front Depth (m)')

title('Flame Front Propagation')

grid on

%==========================================
% SUMMARY METRICS
%==========================================

fprintf('\n')
fprintf('====================================\n')
fprintf('PHASE 1 TRANSIENT MODEL SUMMARY\n')
fprintf('====================================\n')

fprintf('Maximum Solid Temperature = %.2f K\n',...
        max(state.Ts))

fprintf('Maximum Gas Temperature   = %.2f K\n',...
        max(state.Tg))

fprintf('Maximum Reaction Rate     = %.4f\n',...
        max(history.R(:)))

fprintf('Minimum Final Coke        = %.6e\n',...
        min(state.Coke))

fprintf('Maximum Final Coke        = %.6e\n',...
        max(state.Coke))

fprintf('Final Flame Front Depth   = %.3f m\n',...
        max(front_depth))

fprintf('====================================\n')
%==========================================
% FIGURE 7
% TEMPERATURE HISTORY AT SELECTED DEPTHS
%==========================================

depth_nodes = [1 10 20 30 40 50 60];

figure
hold on

for n = depth_nodes

    plot(time,...
         history.Ts(n,:),...
         'LineWidth',2,...
         'DisplayName',...
         sprintf('%.2f m',z(n)));

end

xlabel('Time (s)')
ylabel('Temperature (K)')

title('Temperature Evolution at Different Bed Depths')

legend('show')

grid on

%==========================================
% ISOTHERM MAP
%==========================================

figure

contour(time,...
        z,...
        history.Ts,...
        [373 600 900 1100],...
        'LineWidth',2)

set(gca,'YDir','reverse')

xlabel('Time (s)')
ylabel('Bed Height (m)')

title('Temperature Isotherms')

grid on

legend('373 K','600 K','900 K','1100 K')

figure

contourf(time,z,history.Ts,...
         [300 373 600 900 1100 1300],...
         'LineColor','none')

set(gca,'YDir','reverse')

xlabel('Time (s)')
ylabel('Bed Height (m)')

title('Thermal Zones During Sintering')

colorbar
colormap(jet)