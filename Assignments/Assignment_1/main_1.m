%% Housekeeping
clc; clear; close all;

%% Problem 1

fprintf('-------------------------------------------------------')
fprintf('\nProblem 1: \n \n')
%prompting and getting user input 
theta = input('Enter a value for the initial angle (deg): ','s');
V = input('Enter a value for the initial airspeed (m/s): ','s');

check1 = isnan(str2double(theta));
check2 = isnan(str2double(V));
%check user inputs for error
k = 0; %used as counter for check loop
while check1 == 1 || check2 == 1
    fprintf('Please re-enter values that are either integers or floats \n')
    theta = input('Enter a value for the initial angle (deg): ','s');
    V = input('Enter a value for the initial airspeed (m/s): ','s');
    if isnan(str2double(theta)) || isnan(str2double(theta))
        k = k + 1;
        if k > 1 
            fprintf('you entered wrong values multiple times \n')
            ans1 = input('do you wish to quit? (yes or no): ', 's');
            if (ans1 == "no") || (ans1 == "NO") || (ans1 == "n") || (ans1 == "N")
                k = 0;
            else
                error('you have exited the script')
            end
        end
    else
        break
    end
end

%convert to double
theta = str2double(theta);
V = str2double(V);

%calulate stop time and trajectory
t_end = stop_time(theta, V);
plot_traject(theta, V, t_end)

fprintf('\nTime of impact: %0.3f',t_end)
fprintf('\n-------------------------------------------------------')

%% Problem 2
fprintf('\nProblem 2: \n \n')

%given vectors 
AOA = [ -5, -2, 0, 2, 3, 5, 7, 10, 14];
c_l = [ -0.008, -0.003, 0.001, 0.005, 0.007, 0.006, 0.009, 0.017, 0.019];

%best fit function
[m,b] = bestfit_squares(AOA, c_l);

%creating line of best fit using calculated values

x_fit = linspace(min(AOA),max(AOA),1000);%xvalues for best fit
y_fit = m*x_fit + b;%yvalues for best fit

%plotting
figure(2)
scatter(AOA,c_l);
hold on 
plot(x_fit,y_fit)
grid on
title('CL vs AOA')
xlabel('AOA (deg)')
ylabel('C_l')
hold off

%display
fprintf('m: %0.5f \n', m)
fprintf('b: %0.5f', b)

fprintf('\n------------------------------------------------------- \n')
%% Problem 3
fprintf('Problem 3: \n \n')

%Part d

%given values
radius = 3.0; %m
w_pay = 5; %kg
w_empt = 0.6; %kg
MW = 4.02; %molecular weight

max_alt = max_alt_balloon(radius, w_pay, w_empt, MW); %calculate max alt
max_alt = max_alt/1000; %convert to km

%print to command window
fprintf('The maximum attainable altitude is: %0.3f km \n\n', max_alt);

        
        

 