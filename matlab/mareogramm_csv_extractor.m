data = dlmread('../data/Крузенштерн/K1,K2_3.csv', ';');
t = data(1:size(data, 1), 1)./60;
p1Data = data(1:size(data, 1), 2);
p2Data = data(1:size(data, 1), 4);
figure(),plot(t, p1Data, 'Color', 'black');
figure(),plot(t, p2Data, 'Color', 'black');

p1Data_int = zeros(1, 40000);
start_pos = 1;
j=1;
for j=1:45:length(p1Data)-45
    tmp1 = interp(p1Data(j:j+35), 34);
    tmp2 = interp(p1Data(j+36:j+44), 35);
    p1Data_int(start_pos:start_pos+36*34-1) = tmp1;
    p1Data_int(start_pos+36*34:start_pos+1538) = tmp2;
    start_pos = start_pos + 1539;
end
tmp = interp(p1Data(j+45:1022), 35);
p1Data_int(start_pos:start_pos+length(tmp)-1) = tmp;
p1Data_int = p1Data_int(1:34800);

figure(),plot(p1Data_int, 'Color', 'black');

p2Data_int = zeros(1, 40000);
start_pos = 1;
j=1;
for j=1:45:length(p2Data)-45
    tmp1 = interp(p2Data(j:j+35), 34);
    tmp2 = interp(p2Data(j+36:j+44), 35);
    p2Data_int(start_pos:start_pos+36*34-1) = tmp1;
    p2Data_int(start_pos+36*34:start_pos+1538) = tmp2;
    start_pos = start_pos + 1539;
end
tmp = interp(p2Data(j+45:1022), 35);
p2Data_int(start_pos:start_pos+length(tmp)-1) = tmp;
p2Data_int = p2Data_int(1:34800);

figure(),plot(p2Data_int, 'Color', 'black');