%% Plot the position for robots %%

%% RUNNABLE OPTIONS %%

% Size of communication arrows
ARROW_LENGTH = 2;

% Size of communications links
LINE_WIDTH = 1;

% Save data options
% 0: dont save
% 1: save .pdf
% 2: save .eps
% 3: save .avi
SAVE_OPTIONS = 0;

% Time of each iteration
LOOP_TIME = 0;

% Show communication and coverage radii
% 0: off
% 1: show
COM_RAD = 0;
COV_RAD = 1;

% Show velocity directions
% 0: off
% 1: show
VEL_DIR = 1;


%% MAIN CODE %%

% Vector of colors for each robots
colors = {'b','g','r','c','m','k','b','g','r','c','m','y','k','b','g','r','c','m','y','k'};

% Number of robots
n = size(x_plot,2)/2;

% Number of iterations
N = size(x_plot,1);

% Disable warnings
warning('off','all');

% Video writer
if SAVE_OPTIONS == 3
    mov = VideoWriter('sim');
    mov.Quality = 100;
    mov.FrameRate = 3;
    open(mov);
end

% Position for robots
for t = 1 : 230%[120 160 190 220 300] %1 : N
    newplot;
    hold on;
    
    % Reference number show
    if exist('ref')
        for i = 1 : size(ref,1)
%             plot(ref(i,1),ref(i,2),'xr','MarkerSize',15);
            
            % Show referece number
            str = strcat('     R',num2str(i));
%             text(ref(i,1),ref(i,2),'   ref','Color','r');
        end
    end
    
    % Show line communication between neighbors agents
    for i = 1 : n-1
        for j = i+1 : n
            xi = x_plot(t,2*i-1:2*i);
            xj = x_plot(t,2*j-1:2*j);
            d = sqrt((xi-xj)*(xi-xj)');
            
            if A_plot(i,j,t) > 0 && A_plot(j,i,t) > 0
                if d <= r_max(t,i) || d <= r_max(t,j) % Plot line when the distance is small who deletion area
                    line([xi(1) xj(1)],[xi(2) xj(2)],'LineStyle','-','Linewidth',LINE_WIDTH);
                elseif d > r_max(t,i) || d > r_max(t,j) % Plot dashed line when distance is greater than deletion area
                    line([xi(1) xj(1)],[xi(2) xj(2)],'LineStyle','--','Linewidth',LINE_WIDTH,'Color','m');
                end
            elseif (A_plot(i,j,t) > 0 && A_plot(j,i,t) == 0)
                if d <= r_max(t,i) % Plot line when the distance is small who communication area
                    if ARROW_LENGTH > 0
%                         draw_line2([xi(1) xi(2)],[xj(1) xj(2)],'LineStyle','-','LineColor','m','ArrowColor','m','ArrowEdgeColor','m','ArrowLength',ARROW_LENGTH,'LineWidth',LINE_WIDTH);
                          draw_line2([xi(1) xi(2)],[xj(1) xj(2)],'LineStyle','-','LineColor','b','ArrowColor','b','ArrowEdgeColor','b','ArrowLength',ARROW_LENGTH,'LineWidth',LINE_WIDTH);
                    else
%                         arrowline([xi(1) xj(1)],[xi(2) xj(2)],'LineStyle','-','Color','m');
                        arrowline([xi(1) xj(1)],[xi(2) xj(2)],'LineStyle','-','Color','b');
                    end
                elseif d > r_max(t,i) % Plot dashed line when distance is greater than communication area
                    if ARROW_LENGTH > 0
                        draw_line2([xi(1) xi(2)],[xj(1) xj(2)],'LineStyle','--','LineColor','m','ArrowColor','m','ArrowEdgeColor','m','ArrowLength',ARROW_LENGTH,'LineWidth',LINE_WIDTH);
                    else
                        arrowline([xi(1) xj(1)],[xi(2) xj(2)],'LineStyle','--','Color','m');
                    end
                end
            elseif  (A_plot(i,j,t) == 0 && A_plot(j,i,t) > 0)
                if d <= r_max(t,j) % Plot line when the distance is small who communication area
                    if ARROW_LENGTH > 0
%                         draw_line2([xj(1) xj(2)],[xi(1) xi(2)],'LineStyle','-','LineColor','m','ArrowColor','m','ArrowEdgeColor','m','ArrowLength',ARROW_LENGTH,'LineWidth',LINE_WIDTH);
                        draw_line2([xj(1) xj(2)],[xi(1) xi(2)],'LineStyle','-','LineColor','b','ArrowColor','b','ArrowEdgeColor','b','ArrowLength',ARROW_LENGTH,'LineWidth',LINE_WIDTH);
                    else
%                         arrowline([xj(1) xi(1)],[xj(2) xi(2)],'LineStyle','-','Color','m');
                        arrowline([xj(1) xi(1)],[xj(2) xi(2)],'LineStyle','-','Color','b');
                    end
                elseif d > r_max(t,j) % Plot dashed line when distance is greater than deletion area
                    if ARROW_LENGTH > 0
                        draw_line2([xj(1) xj(2)],[xi(1) xi(2)],'LineStyle','--','LineColor','m','ArrowColor','m','ArrowEdgeColor','m','ArrowLength',ARROW_LENGTH,'LineWidth',LINE_WIDTH);
                    else
                        arrowline([xj(1) xi(1)],[xj(2) xi(2)],'LineStyle','--','Color','m');
                    end
                end
            end
        end
    end
    
    % Plot positions for agents
    for agent = 2 : 2 : size(x_plot,2)
        
        % Plot agent in the position (x,y)
%         if isempty(find(A_plot(:,agent/2,t),1)) == 1 % Show root nodes as red point
%             plot(x_plot(t,agent-1),x_plot(t,agent),'r.','MarkerSize',15);
%         elseif isempty(find(A_plot(agent/2,:,t),1)) == 1 % Show well nodes as blue point
%             plot(x_plot(t,agent-1),x_plot(t,agent),'b.','MarkerSize',15);
%         else % Show normal nodes as black point
%             plot(x_plot(t,agent-1),x_plot(t,agent),'k.','MarkerSize',15);
%         end
        
        % Show velocities directions
        if VEL_DIR == 1
            start = x_plot(t,agent-1:agent);
            if t < N
                finish = start + 3*(x_plot(t+1,agent-1:agent)-start)/norm(x_plot(t+1,agent-1:agent)-start);
                if not(isnan(finish))
    %                 arrow(start,finish,'TipAngle',15,'BaseAngle',90,'Length',18);
                    draw_line2(start,finish,'ArrowLength',1,'ArrowAngle',20,'ArrowEdgeColor','r','LineColor','r','LineWidth',2.5);
                end
            end
        end
        
        % Show range of communication
        if COM_RAD == 1
            viscircles([x_plot(t,agent-1),x_plot(t,agent)],r_max(t,agent/2),'EdgeColor','k','LineWidth',0.1,'LineStyle','-.');
        end

        % Show coverage range
        if COV_RAD == 1
            viscircles([x_plot(t,agent-1),x_plot(t,agent)],r_min(t,agent/2),'EdgeColor','k','LineWidth',0.1,'LineStyle','-.');
        end
        
        % Plot path of the agent
        plot(x_plot(max(1,t-400):t,agent-1),x_plot(max(1,t-400):t,agent),'g-');
        
        % Show positions for each agent
%         str = strcat(' (',num2str(agent/2),')');
        str = num2str(agent/2);
        
%         % Show real robots names
%         if agent/2-1 == 1
%             str = 'p3dx';
%         elseif agent/2-1 == 3
%             str = 'p3at';                
%         end
        
%         str = strcat('  [',num2str(x_plot(t,agent-1)),',',num2str(x_plot(t,agent)),'] (',num2str(agent/2-1),')');
%          text(x_plot(t,agent-1),x_plot(t,agent),str);
        if not(t < 300 & (agent/2) == 11)
            text(x_plot(t,agent-1),x_plot(t,agent),str,'HorizontalAlignment','center','BackgroundColor','w','EdgeColor','k')
        end
    end
%     grid on;

    % Set the slack to graphic limits
    if COM_RAD == 1
        slack = max(r_max(:));
    elseif COV_RAD == 1
        slack = max(r_min(:));
    else
        slack = 3;
    end
    
    xpose = x_plot(:,1:2:end);
    ypose = x_plot(:,2:2:end);
    
    xmin = min(xpose(:));
    xmax = max(xpose(:));
    ymin = min(ypose(:));
    ymax = max(ypose(:));
        
    xmin = xmin - slack;
   
    if xmax < 0
        xmax = xmax - slack;
    elseif xmax > 0
        xmax = xmax + slack;
    end
    
    ymin = ymin - slack;
    
    if ymax < 0
        ymax = ymax - slack;
    elseif ymax > 0
        ymax = ymax + slack;
    end
    
    ymax=23
    xmax=30
    
    xlimit = [xmin xmax];
    ylimit = [ymin ymax];
    
%     axis([-6 27 -10 20]);
    axis([xlimit ylimit]);
    set(gca,'FontName','Helvetica');
    xlabel('x [m]');
    ylabel('y [m]');
    
    axis equal;
    axis manual;
    box on;
    
%     if t <= 12
%         text(3,-8,'Topologia inicial não bi-conexa','BackgroundColor',[.7 .9 .7]);
%     elseif t >= 88 && t <= 100
%         text(3,-8,'Bi-conectividade atingida','BackgroundColor',[.7 .9 .7]);
%     elseif t >= 144 && t <= 156
%         text(2,-8,'Robô 3 perde conexão com os demais','BackgroundColor',[.7 .9 .7]);
%     elseif t >= 164 && t <= 176
%         text(2,-8,'Robô 1 perde conexão com os demais','BackgroundColor',[.7 .9 .7]);
%     elseif t >= 177 && t <= 189
%         text(2,-8,'Topologia torna-se não biconexa','BackgroundColor',[.7 .9 .7]);
%     elseif t >= 264 && t <= 275
%         text(3,-8,'Bi-conectividade restaurada','BackgroundColor',[.7 .9 .7]);
%     end
    
    
    frame = getframe;
    
    % Write frame in video file
    if SAVE_OPTIONS == 3
        writeVideo(mov,frame);
    end
    
    hold off;
    
    % Save file options
    if SAVE_OPTIONS == 1
        imgname = strcat('test2_',int2str(t),'.pdf');
        print('-dpdf',imgname);
    elseif SAVE_OPTIONS == 2
        imgname = strcat('pose-',int2str(t),'.eps');
        print('-depsc2','-tiff',imgname);
    end
    
    t
    
    % Wait for LOOP_TIME
    pause(LOOP_TIME)
end

if SAVE_OPTIONS == 3
    close(mov);
end
