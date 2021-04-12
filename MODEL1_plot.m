sim('Model_1_Three_Winding_Distribution_Transformer');
yyaxis left
ylabel('Voltage (V)');
plot(V_Load_1,V_Load_2,V_Load_3);
hold on;
yyaxis right
ylabel('Current (A)');
xlabel('Time (s)');
legend('Load 1 Voltage', 'Load 2 Voltage', 'Load 3 Voltage', 'Neutral Current');
