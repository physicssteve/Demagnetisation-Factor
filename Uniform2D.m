%user defined variables.
xlength = 101;
ylength = 101;
zlength = 101;

%create matrices for later use
Demagmatrix = zeros (xlength,ylength,zlength);
Downstack = zeros ((2*xlength)-1, (2*ylength)-1, zlength);
Nzfull = zeros ((2*xlength)-1,(2*ylength)-1,(2*zlength)-1);

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

%isolating required columns per particle and populating Demagmatrix
layer = 0;
for k = zlength:-1:1
    layer = layer + 1;
    for j = 0:ylength-1
        for i = 0:xlength-1
            isolate = Downstack(xlength-i:(2*xlength)-1-i, ylength-j:(2*ylength)-1-j, k);
            tosum = isolate.*Othello;
            Demagmatrix(i+1,j+1,layer) = sum(sum(tosum));
        end
    end
end

%"shaping" Demagnetmatrix; only for present particles
for z = 1:zlength
    Demagmatrix(:,:,z) = Demagmatrix(:,:,z).*Othello;
end


Demagmatrix = abs(Demagmatrix)./(4*pi);
Demagmatrix(Demagmatrix == 0) = NaN;
valmin = min(Demagmatrix, [],"all","omitnan")
valmax = max(Demagmatrix, [],"all","omitnan")
valmean = mean(Demagmatrix,"all","omitnan")


