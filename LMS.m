%%
% This is an implementation of LMS
% To test LMS if it works correctly:
% I will estimate the weights/coefficients of a generated AR function

% Input parameters:
% N : is the number of observations to generate the input signal x using AR
% order : is the order of AR
% mu : mu is the step size

% Output paramers:
% weights=> original weights that are used to generate x using AR-order
% w => is the estimated weights

% test function
% [weights, w]= LMS(1000, 0.001, 3)
%%
function [weights, w] = LMS(N, mu, order)
    %clear
    %clc
    if nargin <3
        order = 3;
        N = 1000;
        mu = 0.001;
    end
    % generate data input by using Auto-regression with specified order
    [x_input, weights] = generateAR(N,order,-0.8, 0.8, 1, 5); % x=> is the desired signal
    w = zeros(1,order); % initally weights =0, weights has dim orderx1 (equi to dim of x)
    %[alpha_1, alpha_2,.. alpha_n]%
    for i=1:order
        x(i,:)= x_input(i:N-order+i-1);
    end
    d = x_input(order+1:N); % desired signal
    for n=1:length(d)
        e(n) = d(n) - w * x(:,n);
        w = w + mu * e(n) * x(:,n)';
        est_weights(:,n)=w;
    end
    fig = figure;
    subplot(2,2,1),plot([1:N],x_input),title('Input Signal'), 
    xlabel('x'), ylabel('y'), grid on,

    subplot(2,2,2),plot([order+1:N],d),title('Desired Signal'), 
    xlabel('x'), ylabel('y'), grid on,

    subplot(2,2,[3 4]),plot([1:N-order],e), title('error'),
    xlabel('x'), ylabel('y'), grid on;
    % save figure
    savefig(fig,'LMS.fig')
end
