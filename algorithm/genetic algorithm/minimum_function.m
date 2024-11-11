% Define a custom function as an example (since ps_example is undefined)
function z = ps_example(x)
    % Example function to minimize: Himmelblau's function
    z = (x(:,1).^2 + x(:,2) - 11).^2 + (x(:,1) + x(:,2).^2 - 7).^2;
end

% Main script
xi = linspace(-6, 6, 300); % Adjusted range for visualization
yi = linspace(-6, 6, 300); 
[X,Y] = meshgrid(xi, yi);
Z = ps_example([X(:), Y(:)]); % Call the custom function

% Use the Genetic Algorithm (GA) to minimize the function
rng default % For reproducibility
[x_opt, fval] = ga(@ps_example, 2); % Optimize over 2 variables

% Reshape the Z values for surface plot
Z = reshape(Z, size(X));

% Plotting the surface of the function
figure;
surf(X, Y, Z, 'MeshStyle', 'none')
colormap 'jet'
view(-26, 43)
xlabel('x(1)')
ylabel('x(2)')
title('Optimization Surface for ps\_example')

% Display the GA results
fprintf('Optimal solution found by GA: x = [%f, %f]\n', x_opt(1), x_opt(2));
fprintf('Function value at the optimum: fval = %f\n', fval);