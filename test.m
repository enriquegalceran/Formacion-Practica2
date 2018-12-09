dinfo = dir(['Variables\', '*.mat']);
n_data = length(dinfo);
MaxC = -inf;
MaxI = -inf;
MinC = inf;
MinI = inf;
for K = 1:n_data
    filename = dinfo(K).name;
    load(sprintf('Variables/cmd%s.mat', filename(4:end-4)));
    BandaI = Data(:,19);
    BandaV = Data(:,17);
    Color = BandaV-BandaI;
    maxC = max(Color);
    minC = min(Color);
    maxI = max(BandaI);
    minI = min(BandaI);
    
    if maxC > MaxC
        MaxC = maxC;
    end
    if minC < MinC
        MinC = minC;
    end
    if maxI > MaxI
        MaxI = maxI;
    end
    if minI < MinI
        MinI = minI;
    end
end