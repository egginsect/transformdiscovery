function alignedImg = arrangeImgHorizontal(images,maxPhoto)
        if maxPhoto>length(images)
           maxPhoto = length(images)
        end
        [colDim, rowDim] = size(images{1});
        alignedImg = zeros(colDim,rowDim*maxPhoto);
        for i=1:maxPhoto
            size(alignedImg(:,(i-1)*rowDim+1:i*rowDim))
            size(images{i})
            alignedImg(:,(i-1)*rowDim+1:i*rowDim) = images{i};
        end
        figure;
        imshow(alignedImg,[]);
    end