function idx = findStrInCell(strlist,goalstr)
    idx = find(cellfun(@(x) ~isempty(strfind(x,goalstr)), strlist));
end