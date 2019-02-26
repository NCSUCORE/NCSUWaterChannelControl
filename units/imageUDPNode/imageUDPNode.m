block1 = find_system(gcb,...
    'LookUnderMasks','on',...
    'FollowLinks','on','Name','pixelCompA');

block2 = find_system(gcb,...
    'LookUnderMasks','on',...
    'FollowLinks','on','Name','pixelCompB');


packingPorts = get_param([gcb '/Byte Packing'],'PortConnectivity');

switch length(packingPorts)
    case 1
        if (~isempty(block1) || ~isempty(block3))
            delete_block(block1)
            delete_block(block3)
            
            posX = packingPorts(1).Position(1) - 85;
            posY = packingPorts(1).Position(2) - 10;
            pos = [posX, posY, posX+35, posY+15];
            set_param([gcb  '/In1'],'position',pos);
        end
    case 2
        if isempty(block1)
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
end 