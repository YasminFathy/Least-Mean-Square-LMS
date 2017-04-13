%%
% generate data using auto regression model AR(order). Assume order=3
% x_t = rho_1 x_(t-1) + rho_2 x_(t-2) + rho_3 x_(t-3) + eps_t
% eps_t ~ NID(0, segma^2) for t = 1,2,...n

% Input parameters:
% obs_num: the number of generated observations
% order: is the order of AR
% lower_alpha : lower bound of alpha generated values.
% upper_alpha : upper bound of alpha generated values.
% lower_y : lower bound of y generated values.
% upper_y : upper bound of y generated values.
% output parameters:
% y : the generated observations based on given parameter values
% alpha: the generated values of alpha. 
% test function
% [x,alpha] = generateAR(1000,3,-0.5, 0.5,1, 5)
%%
function [y,alpha] = generateAR(obs_num, order,lower_alpha,upper_alpha,lower_y,upper_y)
    %clear
    %clc
    if nargin<6
        obs_num = 1000;
        order =3;
        lower_alpha = -0.5;
        upper_alpha = 0.5;
        lower_y = 1;
        upper_y = 5;
    end        
    % generate noise as NID (noraml and independely distributed) params
    % where mu =0 and sigma = 1
    eps = normrnd(0,1,obs_num,1); % eps is vector of dim obs_numx1
    
    % generate alphs between specific range e.g ]-0.5, 0.5[
    % the number of alphas= the number of order 
    % alphas are the coefficients of the AR order
    alpha = (upper_alpha-lower_alpha).*rand(order,1) + lower_alpha;
    % rounding alpha to 1 decimal value
    alpha = round(alpha,1);
    % generate the values of y(n) where n= 1,2.. order
    % between specific range e.g ]1, 5[
    y = (upper_y-lower_y).*rand(order,1)+lower_y;
    %y=[0,0,0];
    temp = 0;
    for t=order+1:obs_num
        for i=1:order
            temp = temp+alpha(i)*y(t-i);
        end
            y(t) = temp+eps(t);
        temp=0;
    end
    % plot AR-order
    fig = figure;
    plot(y);
    xlabel('x');
    ylabel('y');
    title(['Auto-Regression-' num2str(order)]);
    savefig(fig,'generateAR.fig')
end
