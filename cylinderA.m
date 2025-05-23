Othello = zeros(101);

for j = 0.5:1:100.5
    for i = 0.5:1:100.5
        d = sqrt((50.5-i)^2 + (50.5-j)^2);
        
        if d <= 50.5 - 0.5
            Othello(i+0.5, j+0.5) = 1;
        else
            Othello(i+0.5, j+0.5) = 0;
        end
    end
end

clearvars -except Othello
