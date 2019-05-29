function [ mat_int ] = interpMat( t, vT, mat )

dims = size(mat);
n = length(t);
mat_int = zeros(dims(1),dims(2),n);

for j = 1 : dims(1)
    for k = 1 : dims(2)
        mat_int(j,k,1:n) = interp1(vT,squeeze(mat(j,k,:)),t);
    end 
end

end

