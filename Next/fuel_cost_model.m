function [cost, total_violation] = fuel_cost_model(x)
    x_H2 = x(1); % 氫燃料占比
    x_Gas = x(2); % 汽油占比

    % === 單位價格 ===(可根據實際調整)
    H2_price = 5.5; % €/kg
    Gas_price = 1.8; % €/L
    ETS_price = 95; % €/ton CO2

    % === 單位CO2排放量 ===
    CO2_H2 = 0.0; % kg CO2/kg(理想為0)
    CO2_Gas = 2.31; % kg CO2/L

    % === 計算總成本 ===
    fuel_cost = H2_price * x_H2 + Gas_price * x_Gas;
    CO2_emissions = CO2_H2 * x_H2 + CO2_Gas * x_Gas;
    carboon_cost = ETS_price * (CO2_emissions / 1000); % 換成 ton

    cost = fuel_cost + carboon_cost;

    % === 限制條件 ===
    g1 = abs(x_H2 + x_Gas - 1); % 必須滿足總量為1(轉為等式違規)

    g2 = abs(x_GAS - min_ration);

    % 可加入其他條件，如x_H2 >= min_ratio

    total_violation = g1 + g2; % 單一等式違反量
end