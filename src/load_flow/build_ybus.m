function sys = build_ybus(Bus, Line)
%   Build network model from raw bus and line data
%
%   sys.nbus          number of buses
%   sys.Ybus          complex Y-bus
%   sys.Ymag/theta    polar Y-bus, Y_ik = Ymag*e^(-j*theta)
%   sys.slack/pv/pq   bus index lists by type
%   sys.ns            non-slack buses (angle unknowns)
%   sys.V, sys.delta  initial voltage magnitude (pu) and angle (rad)
%   sys.Pspec/Qspec   scheduled net injections (Pg-Pd, Qg-Qd)
%   sys.Qd            reactive load (needed for PV Q-limit check)

nbus = size(Bus, 1);

%%  Y-bus
Ybus = zeros(nbus);
for k = 1:size(Ybus)
    fb = Line(k, 1);
    tb = Line(k, 2);

    y = 1/ (Line(k, 3) + 1i*Line(k, 4));

    Ybus(fb, fb) = Ybus(fb, fb) + y;
    Ybus(tb, tb) = Ybus(tb, tb) + y;
    Ybus(fb, tb) = Ybus(fb, tb) - y;
    Ybus(tb, fb) = Ybus(fb, tb);
end

%% Polar form (Eq. 6.114): magnitude and theta = -angle
sys.nbus  = nbus;
sys.Ybus  = Ybus;
sys.Ymag  = abs(Ybus);
sys.theta = -angle(Ybus);

%% Bus classification
type      = Bus(:, 2);
sys.slack = find(type == 1);
sys.pv    = find(type == 2);
sys.pq    = find(type == 3);
sys.ns    = find(type ~= 1);

%% Initial state and schedules
sys.V     = Bus(:, 3);
sys.delta = deg2rad(Bus(:, 4));
sys.Pspec = Bus(:, 5) - Bus(:, 7);
sys.Qspec = Bus(:, 6) - Bus(:, 8);
sys.Qd    = Bus(:, 8);
end

