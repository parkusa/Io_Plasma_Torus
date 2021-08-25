
function M_lambda = mixing_ratio(A,lambda,phi,c)
     M_lambda = A.*cosd(lambda - phi) + c;
end
