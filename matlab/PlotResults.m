close all
xlb=11:25;
%%
figure;
plot(xlb,precision4Save(:,7)/100,xlb,precision4Save(:,5)/100,xlb,precision4Save(:,3)/100,xlb,precision4Save(:,1)/100);
title('Testing MeanAp of varying number of persons for training')
legend('GFCDL','DL','PCA','SVM','Location','northwest');
xlabel('Number of different person during training');
ylabel('MeanAp');
%%
figure;
plot(xlb,precision4Save(:,8)/100,xlb,precision4Save(:,6)/100,xlb,precision4Save(:,4)/100,xlb,precision4Save(:,2)/100)
title('Training MeanAp of varying number of persons for training')
legend('GFCDL','DL','PCA','SVM','Location','southwest');
xlabel('Number of different person during training');
ylabel('MeanAp');