block = find_system(gcb,...
    'LookUnderMasks','on',...
    'FollowLinks','on','Name','In2');

switch numIn
    case 1
        if ~isempty(block)
            delete_block(block)
        end
    case 2
        
        if isempty(block)
            add_block('built-in/Inport',[gcb '/In2'])
        end
end 