function y = sigmoid(x, u, a)
y = 1./(1+exp(-(x-u)/a));
end

