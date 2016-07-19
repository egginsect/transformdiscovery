%iconDir='/home/hwlee/Develop/Papers/ACMMM2016/images/6states/';
iconDir='/home/hwlee/Develop/Papers/ACMMM2016/images/4statestomato/'
iconFiles=dir(strcat(iconDir,'*.jpg'));
iconNames=cell(1,length(iconFiles));
for i = 1 : length(iconFiles)
    filename = strcat(iconDir,iconFiles(i).name);
    icon{i} = imread(filename);
    iconNames{i} = iconFiles(i).name;
end
%%
objects = unique(objectLabel);
objects(findStrInCell(objects,'berry'))=[];
objects(findStrInCell(objects,'vegetable'))=[];
objects(findStrInCell(objects,'persimmon'))=[];
objects(findStrInCell(objects,'persimmon'))=[];
objects(findStrInCell(objects,'potato'))=[];
%%
%for visualizationRound = 1:length(objects)
    %%
    figure(visualizationRound)
    object4visualize = objects{visualizationRound};
    visualizationIdx = findStrInCell(objectLabel,object4visualize);
    states4Visulization = unique(stateLabel(visualizationIdx));
    visualizationLabel = cell2mat(values(currentHashTable,stateLabel(visualizationIdx)));
    visualizationData = feature(visualizationIdx,:);
    A=sn.sparseCodingWithDictionary(visualizationData,stateLabel(visualizationIdx));
    yData=tsne(A,visualizationLabel,2);
    %title(['Visualization of ', num2str(length(states4Visulization)), ' states of ', object4visualize, ' with tSNE']);
    
    for i=1:length(states4Visulization)
        
        textPos=trimmean(yData(find(visualizationLabel==currentHashTable(states4Visulization{i})),:),20);

        if(visualizationRound==7)
            hold on
            iconIdx=findStrInCell(iconNames,states4Visulization(i));
            states4Visulization{i}(1)=upper(states4Visulization{i}(1));
            arg4text = [mat2cell(textPos,1,ones(1,numel(textPos))),states4Visulization(i)];
            text(arg4text{:},'FontSize',18,'FontWeight','bold','Color','k');
            image([textPos(1),textPos(1)-2],[textPos(2)+2,textPos(2)],icon{iconIdx});
        end
    end
    %%
%end
%%
figure;
A=sn.sparseCodingWithDictionary(trainImgs,trainLabels);
visualizationLabel = cell2mat(values(currentHashTable,trainLabels));
    states4Visulization = unique(trainLabels);

yData=tsne(A,visualizationLabel,2);
hold on
    for i=1:length(states4Visulization)
        textPos=trimmean(yData(find(visualizationLabel==currentHashTable(states4Visulization{i})),:),60);
        iconIdx=findStrInCell(iconNames,states4Visulization(i));
        states4Visulization{i}(1)=upper(states4Visulization{i}(1));
        arg4text = [mat2cell(textPos,1,ones(1,numel(textPos))),states4Visulization(i)];
        text(arg4text{:},'FontSize',18,'FontWeight','bold','Color','k');
        image([textPos(1),textPos(1)-8],[textPos(2)+8,textPos(2)],icon{iconIdx});
    end