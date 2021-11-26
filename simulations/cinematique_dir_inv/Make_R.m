function R = Make_R(axe, theta)
    if axe == 1 % rotation autour de x
        R = [1 0 0;
                 0 cos(theta) -sin(theta);
                 0 sin(theta) cos(theta)];
    elseif axe == 2 % rotation autour de y
        R = [cos(theta) 0 sin(theta);
                 0 1 0;
                 -sin(theta) 0 cos(theta)];
    elseif axe == 3 % rotation autour de z
        R = [cos(theta) -sin(theta) 0;
                 sin(theta) cos(theta) 0;
                 0 0 1];
    else 
        msg = 'Non existent axis';
        error(msg)
    end
end