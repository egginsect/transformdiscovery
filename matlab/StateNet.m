classdef StateNet < handle
    
properties
    stateSeqs
    nodeNames
    distMat
    nearestNeighbor
    adjMat
end

methods
    function StateNetObj = StateNet()
        StateNetObj.stateSeqs = containers.Map();
    end
    
    function addExistingStateSeq(obj, stateSeq)
        obj.stateSeqs(stateSeq.stateName) = stateSeq;
    end
    
    function createNewStateSeq(obj, stateName, images, idx, numStates, subspaceDimension)
        if(isKey(obj.stateSeqs,stateName))
            error(['The states ', stateName, 'already exists']);
        end
        newSeq = StateSeq(stateName, images, idx, numStates, subspaceDimension);
        obj.addExistingStateSeq(newSeq);
    end
    
    function listStates(obj)
        k = keys(obj.stateSeqs);
        for i=1:length(k)
            disp([k{i},':', num2str(obj.stateSeqs(k{i}).numStates)])
        end
    end
    
    function genNodes4graph(obj)
        obj.nodeNames = cell(0);
        k = keys(obj.stateSeqs);
        for i=1:length(k)
            for j=1:obj.stateSeqs(k{i}).numStates
                str=[k{i},num2str(j)];
                obj.nodeNames = [obj.nodeNames,str];
            end
        end
    end
    
    function state=node2state(obj,nodeName)
        tokens = regexp(nodeName,{'[a-zA-Z]+','\d+'},'match');
        state = obj.stateSeqs(tokens{1}{1}).getState(str2double(tokens{2}{1}));
    end
    
    function computeMutualDist(obj)
        obj.genNodes4graph()
        obj.distMat = zeros(length(obj.nodeNames));
        for i=1:length(obj.nodeNames)
            for j=1:length(obj.nodeNames)
                if(i<j)
                    obj.distMat(i,j) = stateDist(obj.node2state(obj.nodeNames{i}),obj.node2state(obj.nodeNames{j}));
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
    
    function g=constructRelationGraph(obj)
        obj.adjMat = zeros(size(obj.distMat));
        k = keys(obj.stateSeqs);
        for i = 1:length(k)
            for j = 1:obj.stateSeqs(k{i}).numStates
                if j<obj.stateSeqs(k{i}).numStates && j==i+1
                    obj.adjMat(i,j) = obj.distMat(i,j);
                end
            end
        end
        g=biograph(obj.adjMat,obj.nodeNames);
        view(g);
     end
end
end