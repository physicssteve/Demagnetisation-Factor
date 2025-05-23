Othello = zeros(101,101,901); 
syms x y z 

%rough check: test to see if the centre of the particles lies within the 
%ellipsoid. 

for k = 0.5:900.5 
    for j = 0.5:100.5 
        for i = 0.5:100.5 
            ellip=((i-50.5)/50.5)^2 + ((j-50.5)/50.5)^2 + ((k-450.5)/450.5)^2; 
            if ellip < 1 
                Othello(i+0.5, j+0.5, k+0.5) = 1; 
            end 
        end 
    end 
end 

%detailed check to test if the full particle resides within the ellipsoid. 
for j = 1:101 
    for i = 1:101 
        k = 1; 
        if sum(Othello(i, j, 1:901)) == 0  
            cond = false; 
        else 
            cond = true; 
        end 
        while cond == true && k <=451 
            if Othello(i, j, k) == 1 
                eqns = [((x-50.5)/50.5)^2 + ((y-50.5)/50.5)^2 + ((z-450.5)/450.5)^2 == 1, (x-i-0.5)^2 + (y-j-0.5)^2 + (z-k-0.5)^2 == 0.5^2]; 
                vars = [x y z]; 
                [X Y Z] = solve(eqns, vars); 
                X = double(X); 
                testX = isreal(X); 
                Y = double(Y); 
                testY = isreal(Y); 
                Z = double(Z); 
                testZ = isreal(Z); 
                if testX == true && testY == true && testZ == true 
                    Othello(i, j, k) = 0; 
                    Othello(i, j, 901-k+1) = 0; 
                else 
                    cond = false; 
                end 
            end 
            k = k+1; 
        end 
    end 
end 
clearvars -except Othello 