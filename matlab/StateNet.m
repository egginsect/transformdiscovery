classdef StateNet < handle
    
properties
    stateSeqs
    seq2nodeTable
end

methods
    function StateNetObj = StateNet()
        StateNetObj.stateSeqs = containers.Map();
        StateNetObj.seq2nodeTable = containers.Map();
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
    
    function constructStateNet(obj)
        
    end
end

end