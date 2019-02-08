block2 = find_system(gcb,...
    'LookUnderMasks','on',...
    'FollowLinks','on','Name','In2');

block3 = find_system(gcb,...
    'LookUnderMasks','on',...
    'FollowLinks','on','Name','In3');

packingPorts = get_param([gcb '/Byte Packing'],'PortConnectivity');

switch length(packingPorts)
    case 2
        if (~isempty(block2) || ~isempty(block3))
            delete_block(block2)
            delete_block(block3)
            
            posX = packingPorts(1).Position(1) - 85;
            posY = packingPorts(1).Position(2) - 10;
            pos = [posX, posY, posX+35, posY+15];
            set_param([gcb '/In1'],'position',pos);
        end
    case 3
        if isempty(block2)
            add_block('Simulink/Ports & Subsystems/In1',[gcb '/In2'])
            posX = packingPorts(2).Position(1) - 85;
            posY = packingPorts(2).Position(2) - 10;
            pos = [posX, posY, posX+35, posY+15];
            set_param([gcb '/In2'],'position',pos);
            
            posX = packingPorts(1).Position(1) - 85;
            posY = packingPorts(1).Position(2) - 10;
            pos = [posX, posY, posX+35, posY+15];
            set_param([gcb '/In1'],'position',pos);
        end
    case 4
        if isempty(block3)
            add_block('Simulink/Ports & Subsystems/In1',[gcb '/In3'])
            posX = packingPorts(2).Position(1) - 85;
            posY = packingPorts(2).Position(2) - 10;
            pos = [posX, posY, posX+35, posY+15];
            set_param([gcb '/In2'],'position',pos);
            
            posX = packingPorts(1).Position(1) - 85;
            posY = packingPorts(1).Position(2) - 10;
            pos = [posX, posY, posX+35, posY+15];
            set_param([gcb '/In1'],'position',pos);
            
            posX = packingPorts(3).Position(1) - 85;
            posY = packingPorts(3).Position(2) - 10;
            pos = [posX, posY, posX+35, posY+15];
            set_param([gcb '/In3'],'position',pos);
        end
end 