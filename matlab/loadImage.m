function imcell=loadImage(current_dir,file_ext)
    D = dir([current_dir, '/*.' ,file_ext]);
    imcell = cell(1,numel(D));
    for i = 1:numel(D)
        ['current file is', current_dir,'/',D(i).name];
        img = imread([current_dir,'/',D(i).name]);
        if(ndims(img)>2) 
            %['convert RGB image to color'];
            img = rgb2gray(img);
        end
        %if(~prod(size(img)==[480,640]))
        %   ['resizing image'];
         %   img = imresize(img,[480,640]);
        %end
        imcell{i}=img;
    end
end