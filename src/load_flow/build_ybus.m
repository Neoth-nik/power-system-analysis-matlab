function Ybus = build_ybus(line_data, num_buses)
    % BUILD_YBUS Computes the complex Bus Admittance Matrix (Y-bus).
    % Inputs:
    %   line_data - [From_Bus, To_Bus, R_pu, X_pu, Half_B_pu]
    %   num_buses - Total number of buses in the system

    Ybus = zeros(num_buses, num_buses);
    num_lines = size(line_data, 1);

    for k = 1:num_lines
        from_node = line_data(k, 1);
        to_node   = line_data(k, 2);
        r         = line_data(k, 3);
        x         = line_data(k, 4);
        b_half    = line_data(k, 5);

        % Complex admittance of line branch
        z = r + 1i*x;
        y = 1 / z;

        % Off-diagonal mutual admittances
        Ybus(from_node, to_node) = Ybus(from_node, to_node) - y;
        Ybus(to_node, from_node) = Ybus(from_node, to_node);

        % Diagonal self-admittances (includes shunt line charging)
        Ybus(from_node, from_node) = Ybus(from_node, from_node) + y + 1i*b_half;
        Ybus(to_node, to_node)     = Ybus(to_node, to_node)     + y + 1i*b_half;
    end
end