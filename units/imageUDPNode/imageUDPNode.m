block1 = find_system(gcb,...
    'LookUnderMasks','on',...
    'FollowLinks','on','Name','pixelCompA');

block2 = find_system(gcb,...
    'LookUnderMasks','on',...
    'FollowLinks','on','Name','pixelCompB');

packingPorts = get_param([gcb '/Byte Packing'],'PortConnectivity');

switch length(packingPorts)
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
    case 2
        if ~isempty(block2)
            block2Ports = get_param(block2,'PortConnectivity');
            pos = block2Ports{1,1}.Position;
            delete_line(gcb,[pos(1)+10, pos(2)]);
            delete_block(block2);
        end
        if isempty(block1)
            add_block('simulink/Ports & Subsystems/In1',[gcb '/pixelCompA'])
            posX = packingPorts(1).Position(1) - 85;
            posY = packingPorts(1).Position(2) - 10;
            pos = [posX, posY, posX+35, posY+15];
            set_param([gcb '/pixelCompA'],'position',pos);
        end
    case 3
        if isempty(block2)
            add_block('simulink/Ports & Subsystems/In1',[gcb '/pixelCompB'])
            posX = packingPorts(1).Position(1) - 85;
            posY = packingPorts(1).Position(2) - 10;
            pos = [posX, posY, posX+35, posY+15];
            set_param([gcb '/pixelCompA'],'position',pos);
            
            posX = packingPorts(2).Position(1) - 85;
            posY = packingPorts(2).Position(2) - 10;
            pos = [posX, posY, posX+35, posY+15];
            set_param([gcb '/pixelCompB'],'position',pos);
            linePos = [posX+35, posY+10; posX+85, posY+10];
            bLine = add_line(gcb,linePos);
        end
end 