%% Generate training data

path = "C:\Users\endre\Documents\Skole\Master\Notebooks\";


n = 1000; % size of training set
ne = 10; % number of beam elements

X = zeros(ne-1,n); 
Y = zeros(1,n);
for i =1:n
    
    d = randi([0,9]);
    f = rand()*0.3+0.05;
    [V,D] = damagedBeam(d,10,f);
    
    %First eigenmode
    X(:,i) = V(2:2:end-2,1);
    
    Y(i) = d;
    
    
    
end

csvwrite(strcat(path, 'X_data_f.txt'),X);
csvwrite(strcat(path, 'Y_data_f.txt'),Y);