%% Script to initialize imageUDPNode block

% Find pixelCompA port in block
block1 = find_system(gcb,...
    'LookUnderMasks','on',...
    'FollowLinks','on','Name','pixelCompA');

% Find pixelCompB port in block
block2 = find_system(gcb,...
    'LookUnderMasks','on',...
    'FollowLinks','on','Name','pixelCompB');

% Find pixelCompC port in block
block3 = find_system(gcb,...
    'LookUnderMasks','on',...
    'FollowLinks','on','Name','pixelCompC');

% Get current ports of Byte Packing block
packingPorts = get_param([gcb '/Byte Packing'],'PortConnectivity');

% Switch case determined by length of packingPorts
switch length(packingPorts)

%     % Case with no inputs to Byte Packing block (never used)
%     case 1
%         if (~isempty(block1) || ~isempty(block2))
%             delete_block(block1)
%             delete_block(block2)
%             
%             posX = packingPorts(1).Position(1) - 85;
%             posY = packingPorts(1).Position(2) - 10;
%             pos = [posX, posY, posX+35, posY+15];
%             set_param([gcb  '/In1'],'position',pos);
%         end

    % Case with one input to Byte Packing block
    case 2
        % If third port visible in block, delete port and signal line
        if ~isempty(block3)
            block3Ports = get_param(block3,'PortConnectivity');
            pos = block3Ports{1,1}.Position;
            delete_line(gcb,[pos(1)+10, pos(2)]);
            delete_block(block3);
        end
        % If second port visible in block, delete port and signal line
        if ~isempty(block2)
            block2Ports = get_param(block2,'PortConnectivity');
            pos = block2Ports{1,1}.Position;
            delete_line(gcb,[pos(1)+10, pos(2)]);
            delete_block(block2);
        end
        % If first port not visible in block, add port
        if isempty(block1)
            add_block('simulink/Ports & Subsystems/In1',[gcb '/pixelCompA'])
            posX = packingPorts(1).Position(1) - 85;
            posY = packingPorts(1).Position(2) - 10;
            pos = [posX, posY, posX+35, posY+15];
            set_param([gcb '/pixelCompA'],'position',pos);
        end

    % Case with two inputs to Byte Packing block
    case 3
        if ~isempty(block3)
            block3Ports = get_param(block3,'PortConnectivity');
            pos = block3Ports{1,1}.Position;
            delete_line(gcb,[pos(1)+10, pos(2)]);
            delete_block(block3);
        end
        % If second port not visible in block, add port and signal line
        if isempty(block2)
            add_block('simulink/Ports & Subsystems/In1',[gcb '/pixelCompB'])
            
            % Re-adjust position of pixelCompA port
            posX = packingPorts(1).Position(1) - 85;
            posY = packingPorts(1).Position(2) - 10;
            pos = [posX, posY, posX+35, posY+15];
            set_param([gcb '/pixelCompA'],'position',pos);
            
            % Re-adjust position of pixelCompB port and add signal line
            posX = packingPorts(2).Position(1) - 85;
            posY = packingPorts(2).Position(2) - 10;
            pos = [posX, posY, posX+35, posY+15];
            set_param([gcb '/pixelCompB'],'position',pos);
            linePos = [posX+35, posY+10; posX+85, posY+10];
            bLine = add_line(gcb,linePos);
        end
        
    % Case with three inputs to Byte Packing block
    case 4
        % If second port not visible in block, add port and signal line
        if isempty(block2)
            add_block('simulink/Ports & Subsystems/In1',[gcb '/pixelCompB'])
            
            % Re-adjust position of pixelCompA port
            posX = packingPorts(1).Position(1) - 85;
            posY = packingPorts(1).Position(2) - 10;
            pos = [posX, posY, posX+35, posY+15];
            set_param([gcb '/pixelCompA'],'position',pos);
            
            % Re-adjust position of pixelCompB port and add signal line
            posX = packingPorts(2).Position(1) - 85;
            posY = packingPorts(2).Position(2) - 10;
            pos = [posX, posY, posX+35, posY+15];
            set_param([gcb '/pixelCompB'],'position',pos);
            linePos = [posX+35, posY+10; posX+85, posY+10];
            bLine = add_line(gcb,linePos);
        end
        % If third port not visible in block, add port and signal line
        if isempty(block3)
            add_block('simulink/Ports & Subsystems/In1',[gcb '/pixelCompC'])
            
            % Re-adjust position of pixelCompA port
            posX = packingPorts(1).Position(1) - 85;
            posY = packingPorts(1).Position(2) - 10;
            pos = [posX, posY, posX+35, posY+15];
            set_param([gcb '/pixelCompA'],'position',pos);
            
            % Re-adjust position of pixelCompB port
            posX = packingPorts(2).Position(1) - 85;
            posY = packingPorts(2).Position(2) - 10;
            pos = [posX, posY, posX+35, posY+15];
            set_param([gcb '/pixelCompB'],'position',pos);
%             linePos = [posX+35, posY+10; posX+85, posY+10];
%             bLine = add_line(gcb,linePos);
            
            % Re-adjust position of pixelCompC port and add signal line
            posX = packingPorts(3).Position(1) - 85;
            posY = packingPorts(3).Position(2) - 10;
            pos = [posX, posY, posX+35, posY+15];
            set_param([gcb '/pixelCompC'],'position',pos);
            linePos = [posX+35, posY+10; posX+85, posY+10];
            cLine = add_line(gcb,linePos);
        end
end 