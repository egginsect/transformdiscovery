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
        if(length(obj.nodeNames)>1)
            for i=1:(length(obj.nodeNames)-1)
                obj.distMat(i,length(obj.nodeNames)) = stateDist(obj.states(obj.nodeNames{i}),obj.states(obj.nodeNames{length(obj.nodeNames)}));
                obj.distMat(length(obj.nodeNames),i) = obj.distMat(i,length(obj.nodeNames));
            end
        end
    end
    
    function sampledIdx=addStateSeq(obj, stateName, images, idx, numStates, subspaceDimension)
        if sum(cellfun(@(x) ~isempty(strfind(x,stateName)),obj.nodeNames))
            error(['The state ', stateName, 'already exists']);
        end
        newSeq = StateSeq(stateName, images, idx, numStates, subspaceDimension);
        for i=1:newSeq.numStates
            obj.addState(newSeq.getState(i));
        end
        sampledIdx = newSeq.sampledIdx;
    end
    
    function listStates(obj)
        k = keys(obj.states);
        for i=1:length(k)
            disp(k{i})
        end
    end
    
    function removeState(obj,stateName)
        idx = find(cellfun(@(x) ~isempty(strfind(x,stateName)),obj.nodeNames));
        obj.distMat(idx,:) = [];
        obj.distMat(:,idx) = [];
        obj.nodeNames(idx) = [];
        remove(obj.states,stateName);
        %obj.constructNNgraph(2);
    end
    
    function renameState(obj, originName, newName)
        idx = find(cellfun(@(x) ~isempty(strfind(x,originName)),obj.nodeNames));
        obj.nodeNames{idx} = newName;
        state = obj.states(originName);
        remove(obj.states,originName);
        obj.states(newName) = state;
    end
    
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
    
    function constructNNgraph(obj,nNeighbor)
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

    end
    
    function mergeState(obj, stateNames, mergedName)
        imgs = cell(0);
        %meanImg=zeros(size(obj.states(stateNames{1}).meanImg));
        for i=1:length(stateNames)
            imgs = [imgs, obj.states(stateNames{i}).images];
        end
        state = State(imgs, mergedName, size(obj.states(stateNames{1}).getSubspace,2));
        obj.addState(state);
        for i = 1:length(stateNames)
            obj.removeState(stateNames{i});
        end
    end
    
    function g = showNNgraph(obj,nNeighbor)
        obj.constructNNgraph(nNeighbor);
        g=biograph(obj.adjMat, obj.nodeNames);
        view(g);
    end
    function state = getState(obj,name)
        state = obj.states(name);
    end
end
end