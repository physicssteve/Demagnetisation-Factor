%user defined variables.
xlength = 79;
ylength = 79;
zlength = 79;

%create matrices for later use
Demagmatrix = zeros (xlength,ylength,zlength);
Downstack = zeros ((2*xlength)-1, (2*ylength)-1, zlength);
Nzfull = zeros ((2*xlength)-1,(2*ylength)-1,(2*zlength)-1);
xslice = zeros ((2*xlength)-1,ylength,zlength);

%Nzfull set-up as "summation map"
for zg = -zlength+1:zlength-1 
    for yg = -ylength+1:ylength-1
        for xg = -xlength+1:xlength-1
            Nzfull(xg+xlength,yg+ylength,zg+zlength) = Nz(abs(xg)+1,abs(yg)+1,abs(zg)+1);    
        end
    end
end


% find column (z direction) sums
for k = (2*zlength)-1:-1:zlength
    for j = (2*ylength)-1:-1:1
        for i = (2*xlength)-1:-1:1
            Downstack(i, j, k-(zlength-1)) = sum(Nzfull(i, j, k-(zlength-1):k));
        end
    end
end

%calculating all the x slice summations
for k = zlength:-1:1
    for j = 0:ylength-1
        for i = (2*xlength)-1:-1:1
            xslice(i, ylength-j, k) = sum(Downstack(i, ylength-j:(2*ylength)-1-j, k));
        end
    end
end

for k = 0:zlength-1
    for j = 0:ylength-1
        for i = 0:xlength-1
            Demagmatrix(i+1, j+1, k+1) = sum(xslice(xlength-i:(2*xlength)-1-i, ylength-j, zlength-k));
        end
    end
end

Demagmatrix = abs(Demagmatrix)./(4*pi);
valmin = min(min(min(Demagmatrix)))
valmax = max(max(max(Demagmatrix)))
valmean = mean(mean(mean(Demagmatrix)))
