%user defined variables. 
xlength = 101;
ylength = 101;
zlength = 1001;
vpf = pi/6;

%set-up of the matrix Nz and lattice spacing m.
Nz = zeros (xlength, ylength, zlength);
m = (pi./(6.*vpf))^(1/3);

%calcultaion of Nz.
for zg = 0:zlength-1
    Rindex = 0;
    for yg = 0:ylength-1
        for xg = Rindex:xlength-1
            qsphere = @ (x,y) sqrt(1-y.^2-x.^2);
            ymax = @ (x) sqrt (1-x.^2);
            ymin = @ (x) -1.*sqrt (1-x.^2);
            negative = @ (x,y) ((2.*m.*zg)- qsphere(x,y))./(((2.*m.*xg)+x).^2 + ...
                ((2.*m.*yg) + y).^2 + ((2.*m.*zg)- qsphere(x,y)).^2).^1.5;
            positive = @ (x,y) ((2.*m.*zg)+ qsphere(x,y))./(((2.*m.*xg)+x).^2 + ...
                ((2.*m.*yg) + y).^2 + ((2.*m.*zg)+ qsphere(x,y)).^2).^1.5;
            fun = @ (x,y) negative(x,y) - positive(x,y);
            if xg == yg
                Nz (xg+1,yg+1,zg+1) = integral2 (fun,-1,1,ymin,ymax);
            else
                Nz (xg+1,yg+1,zg+1) = integral2 (fun,-1,1,ymin,ymax);
                Nz (yg+1,xg+1,zg+1) = Nz (xg+1,yg+1,zg+1);
            end
        end
            Rindex = Rindex+1;
    end 
end
