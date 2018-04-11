clear; clc;
load Distribution_1;
%load Distribution_2;
%load Distribution_3;
%load Distribution_4;

temp = Rod_Temp_Gradient;
oldN = Rod_Temp_Gradient;
deviation = 100;
count = 0;

while(deviation > .5)
    
    maxTemp = temp(1); %setting the max and min to be the first value each loop.
    minTemp = temp(1);
    
    for(x = 1:length(temp))
        if x == 1
            temp(x) = (oldN(x) + oldN(x + 1))/2;
        elseif x == length(temp)
            temp(x) = (oldN(x) + oldN(x - 1))/2;
        else
            temp(x) = (oldN(x) + oldN(x + 1) + oldN(x - 1))/3;
        end
        
        %recording the max temp each time a temperature changes in a
        %section
        if temp(x) > maxTemp;
            maxTemp = temp(x);
        end
        
        %recording min temp each temp change in section
        if temp(x) < minTemp
            minTemp = temp(x);
        end
    end
    %Updates old values
    oldN = temp;
    
    deviation = abs(minTemp - maxTemp);
    
    
    plot(1:length(Rod_Temp_Gradient),temp);
    ylim([min(Rod_Temp_Gradient) max(Rod_Temp_Gradient)]);
    pause(0.001);
    count = count + 1;
end

fprintf('It took %i iterations to reach equilibrium\n', count);
fprintf('It has an equilibrium temperature of %.02f\n', (maxTemp+minTemp)/2);
plot(1:length(Rod_Temp_Gradient), temp,1:length(Rod_Temp_Gradient), Rod_Temp_Gradient);
legend('New temp deistribution', 'Old temp distribution');

