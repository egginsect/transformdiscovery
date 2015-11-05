classdef StateNet < handle
    
properties
    nodeNames
    states
    distMat
    nearestNeighbor
    adjMat
end

methods
    function StateNetObj = StateNet()
        StateNetObj.states = containers.Map();
        StateNetObj.nodeNames = cell(0);
    end
    
    function addState(obj, state)
        obj.states(state.stateName) = state;
        obj.nodeNames = [obj.nodeNames, state.stateName];
    end
    
    function addStateSeq(obj, stateName, images, idx, numStates, subspaceDimension)
        if sum(cellfun(@(x) ~isempty(strfind(x,stateName)),obj.nodeNames))
            error(['The state ', stateName, 'already exists']);
        end
        newSeq = StateSeq(stateName, images, idx, numStates, subspaceDimension);
        for i=1:newSeq.numStates
            obj.addState(newSeq.getState(i));
        end
    end
    
    function listStates(obj)
        k = keys(obj.states);
        for i=1:length(k)
            disp(k{i})
        end
    end
    
    %function genNodes4graph(obj)
       % obj.nodeNames = cell(0);
        %k = keys(obj.states);
        %for i=1:length(k)
         %   for j=1:obj.states(k{i}).numStates
          %      str=[k{i},num2str(j)];
           %     obj.nodeNames = [obj.nodeNames,str];
            %end
        %end
   % end
    
  %  function state=node2state(obj,nodeName)
   %     tokens = regexp(nodeName,{'[a-zA-Z]+','\d+'},'match');
   %     state = obj.states(tokens{1}{1}).getState(str2double(tokens{2}{1}));
  %  end
    
    function computeMutualDist(obj)
        obj.distMat = zeros(length(obj.nodeNames));
        for i=1:length(obj.states)
            for j=1:length(obj.nodeNames)
                if(i<j)
                    obj.distMat(i,j) = stateDist(obj.states(obj.nodeNames{i}),obj.states(obj.nodeNames{j}));
                elseif(i>j)
                    obj.distMat(i,j)=obj.distMat(j,i);
                end
            end
        end
    end
    
    function g = constructNNgraph(obj,nNeighbor)
        obj.adjMat = zeros(size(obj.distMat));
        obj.nearestNeighbor = zeros(length(obj.nodeNames),nNeighbor);
        
        for i = 1:length(obj.nodeNames)
            dists = obj.distMat(i,:);
            [sorted idx] = sort(dists);
            obj.nearestNeighbor(i,:) = idx(2:nNeighbor+1);
        end
        for i=1:size(obj.nearestNeighbor,1)
            for j=1:size(obj.nearestNeighbor,2)
                obj.adjMat(i,obj.nearestNeighbor(i,j))=obj.distMat(i,obj.nearestNeighbor(i,j));
            end
        end
        g=biograph(obj.adjMat,obj.nodeNames);
        view(g);
    end
end
end