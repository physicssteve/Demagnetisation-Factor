%user defined variables.
xlength = 101;
ylength = 101;
zlength = 401;

%number of samples to take
msize = sum(sum(sum(Othello)));
frac = 0.05;
samples = round(msize*frac);

%select coordinates of particles to sample
for i = 1:samples
    cond = false;
    while cond == false
        p(i) = randi(xlength);
        q(i) = randi(ylength);
        r(i) = randi(zlength);
        if Othello(p(i), q(i), r(i)) == 1
            cond = true;
        end
    end
end

%define matrices
Nzfull = zeros ((2*xlength)-1,(2*ylength)-1,(2*zlength)-1);
Nzsub = zeros (xlength,ylength,zlength);
Demagmatrix = zeros (xlength,ylength,zlength);

%Nzfull set-up as "summation map"
for zg = -zlength+1:zlength-1 
    for yg = -ylength+1:ylength-1
        for xg = -xlength+1:xlength-1
            Nzfull(xg+xlength,yg+ylength,zg+zlength) = Nz(abs(xg)+1,abs(yg)+1,abs(zg)+1);    
        end
    end
end

%calculate demagnetisation factor of selected particle
for i = 1:samples
    Nzsub = Nzfull(xlength+1-p(i):(2*xlength)-p(i),...
        ylength+1-q(i):(2*ylength)-q(i),zlength+1-r(i):(2*zlength)-r(i));
    Nzsub = Nzsub.*Othello;
    Demagmatrix(p(i),q(i),r(i)) = sum(sum(sum(Nzsub,3)));
end

%stats for sample
Demagmatrix = abs(Demagmatrix)./(4*pi);
Demagmatrix = Demagmatrix.*Othello;
Demagmatrix(Demagmatrix == 0) = NaN;
valmin = min(Demagmatrix, [],"all","omitnan")
valmax = max(Demagmatrix, [],"all","omitnan")
valmean = mean(Demagmatrix,"all","omitnan")


