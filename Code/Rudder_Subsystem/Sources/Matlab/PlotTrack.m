%% Plot waypoints and the vehicle track
Busses;

figure;
hold on;
axis equal;

% Clean up some variables that may have singleton dimensions:
position = squeeze(position);
velocity = squeeze(velocity);

% Fix velocity + position orientation
if size(velocity, 1) == 3
    velocity = velocity';
end
if size(position, 1) == 3
    position = position';
end

% Keep track of what's on the plot for a legend() call
myLegend = {};

% Plot waypoints (red, green, and blue)
% Here we do some predicate indexing to ignore the -1 values at the end
wp_length = length(test_waypoints);
tmp = zeros(wp_length, 3);
for i=1:wp_length
    tmp(i,:) = double(test_waypoints(i).coordinates(:));
end
plot(tmp(:,2), tmp(:,1), 'r^', 'MarkerSize', 10);
text(tmp(:,2)+10, tmp(:,1)-10, cellstr({int2str((1:wp_length)')}), 'Color', 'r');
myLegend{end + 1} = 'Test waypoints';

% The extra two tracks are offset by the current boat position when it
% reset to properly illustrate where the boat thought the waypoints were.
offsets = position(nextTrack > 0,:);
if size(offsets,1) > 0
    wp_length = length(figure8_waypoints);
    tmp = zeros(wp_length, 3);
    for i=1:wp_length
        tmp(i,:) = double(figure8_waypoints(i).coordinates(:));
    end
    figure8_waypoints_offset = double(tmp) + repmat(offsets(1,:),wp_length,1);
    plot(figure8_waypoints_offset(:,2)', figure8_waypoints_offset(:,1)', 'g^', 'MarkerSize', 10);
    text(figure8_waypoints_offset(:,2)'+10, figure8_waypoints_offset(:,1)'-10, cellstr({int2str((1:wp_length)')}), 'Color', 'g');
    myLegend{end + 1} = 'Figure-8 waypoints';
end
if size(offsets,1) > 1
    wp_length = length(sampling_waypoints);
    tmp = zeros(wp_length, 3);
    for i=1:wp_length
        tmp(i,:) = double(sampling_waypoints(i).coordinates(:));
    end
    sampling_waypoints_offset = double(tmp) + repmat(offsets(2,:),wp_length,1);
    plot(sampling_waypoints_offset(:,2)', sampling_waypoints_offset(:,1)', 'b^', 'MarkerSize', 10);
    text(sampling_waypoints_offset(:,2)'+10, sampling_waypoints_offset(:,1)'-10, cellstr({int2str((1:wp_length)')}), 'Color', 'b');
    myLegend{end + 1} = 'Search waypoints';
end

% Add the boat path
% TODO: This should be changed to iterate through a cells array of the
% various waypoint arrays instead of this hackey code.
title('Boat position');
transitions = find(nextTrack > 0);
switch size(transitions,1)
    case 1
        plot(position(1:transitions(1),2),position(1:transitions(1),1), 'r');
        plot(position(transitions(1)+1:end,2),position(transitions(1)+1:end,1), 'g');
    case 2
        plot(position(1:transitions(1),2),position(1:transitions(1),1), 'r');
        plot(position(transitions(1)+1:transitions(2),2),position(transitions(1)+1:transitions(2),1), 'g');
        plot(position(transitions(2)+1:end,2),position(transitions(2)+1:end,1), 'b');
    case 3
        plot(position(1:transitions(1),2),position(1:transitions(1),1), 'r');
        plot(position(transitions(1)+1:transitions(2),2),position(transitions(1)+1:transitions(2),1), 'g');
        plot(position(transitions(2)+1:transitions(3),2),position(transitions(2)+1:transitions(3),1), 'b');
        plot(position(transitions(3)+1:end,2),position(transitions(3)+1:end,1), 'r');
    otherwise
        plot(position(:,2),position(:,1), 'k');
        myLegend{end + 1} = 'Position';
end
grid on;
%% Add additional decorations

decoration_steps = 1:1000:length(position);

% Display the L2 vectors if we have them. Generally we won't have them for
% HIL runs.
if exist('L2', 'var') && ~isempty(L2)
    quiver(position(decoration_steps,2),position(decoration_steps,1),L2(decoration_steps,2),L2(decoration_steps,1), 0, 'm-');
    myLegend{end + 1} = 'L2 Vectors';
end

% Plot velocity vectors
quiver(position(decoration_steps,2),position(decoration_steps,1),velocity(decoration_steps,2), velocity(decoration_steps,1), 0);
myLegend{end + 1} = 'Velocity Vectors';

legend(myLegend);

hold off;
%% Plot the vehicle commands
figure;
subplot(3,1,1);
plot(commands_rudder_up > 0);
title('Rudder Commands');

subplot(3,1,2);
plot(commands_throttle_data);
title('Throttle Commands');

subplot(3,1,3);
plot(commands_ballast_enable);
title('Ballast Commands');