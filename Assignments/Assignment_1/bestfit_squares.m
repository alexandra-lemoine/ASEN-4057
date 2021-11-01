function [m,b] = bestfit_squares(x_vec, y_vec)
N = length(x_vec);

A = sum(x_vec); B = sum(y_vec); C = dot(x_vec,y_vec); D = sum(x_vec .* x_vec);

m = (A*B - N*C)/(A^2 - N*D);
b = (A*C - B*D)/(A^2 - N*D);
end

