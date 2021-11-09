function [w,h] = guess_sides(points)
    % guess the sides (w,h) of a rectangle with same area and
    % perimeter of the input quadrilateral with vertices in "points"
    
    
    perimeter = 0;
    for i = 1:size(points, 1)-1
        perimeter = perimeter + norm(points(i, :) - points(i+1, :));
    end
    % Last point to first
    hp = (perimeter + norm(points(end, :) - points(1, :)))/2;
    % hp is half-perimeter
    
    y = points(:,1);
    x = points(:,2);
    area = 1/2*sum(x.*y([2:end,1])-y.*x([2:end,1]));
    
    % the greatest side
    r = (hp + sqrt(hp^2-4*area))/2;
    
    % portrait or landscape?
    foo = abs(points - circshift(points, 1));
    if  foo(2,2) < foo(1,1)
        w = r;
        h = area/r;
    else
        h = r;
        w = area/r;
        
    end
    
end

