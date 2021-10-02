function [P_out] = format_P(P_in)
%FORMAT_P Formats P into a two-dimension array because Simulink gets pissy
%with three dimensional arrays...

[num_states, ~, num_ind] = size(P_in);
P_out = zeros(num_states, num_ind);

for ii = 1 : num_states
    for jj = 1 : num_ind
        
        P_out(ii,jj) = sqrt(abs(P_in(ii,ii,jj)));
    end
end
    
end

