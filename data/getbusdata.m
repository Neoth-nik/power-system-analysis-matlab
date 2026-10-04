function [BaseMVA, Bus, Line] = getbusdata()
% GETBUSDATA Return the 4-bus system data (per unit)
%   Bus: [Bus | Type | V | Angle(deg) | P_g | Q_g | P_d | Q_d]
%   Type: 1 = Slack; 2 = PV; 3 = PQ
%   Line: [From | To | R | X]

BaseMVA = 100;

Bus = [
    1   1   1.06    0   0     0   0     0;
    2   2   1.04    0   0.5   0   0.2   0.1;
    3   3   1.00    0   0     0   0.9   0.3;
    4   3   1.00    0   0     0   1.0   0.35;
];

Line = [
    1   2   0.02    0.06;
    1   3   0.08    0.24;
    2   3   0.06    0.18;
    2   4   0.06    0.18;
    3   4   0.01    0.03;
];
end