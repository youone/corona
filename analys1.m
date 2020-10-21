clc
clear
close all
global rates;

rates = jsondecode(fileread('data\ft_rates_new.json'));

nmean = 14;

[seDeaths, seDates] = getDeathsSweden(getCountry('world', 'Sweden'), nmean, 0);
[dkDeaths, dkDates] = getDeaths('world', 'Denmark', nmean, 1);
[bgDeaths, bgDates] = getDeaths('world', 'Belgium', nmean, -2);
[spDeaths, spDates] = getDeaths('world', 'Spain', nmean, 7);
[geDeaths, geDates] = getDeaths('world', 'Germany', nmean, -4);
[nyDeaths, nyDates] = getDeaths('us', 'New York', nmean, -5);
[auDeaths, auDates] = getDeaths('world', 'Austria', nmean, 0);
[frDeaths, frDates] = getDeaths('world', 'France', nmean, -2);
[itDeaths, itDates] = getDeaths('world', 'Italy', nmean, 9);
% [skDeaths, skDates] = getDeaths('world', 'South Korea', nmean, 11);
[ukDeaths, ukDates] = getDeaths('world', 'United Kingdom', nmean, -5);

% Tde = array2table([days(dkDates' - datetime(2019,1,1)), dkDeaths']);
% Tsp = array2table([days(spDates' - datetime(2019,1,1)), spDeaths']);
% meanArray = table2array(innerjoin(...
%     array2table([days(dkDates' - datetime(2019,1,1)), dkDeaths']),...
%     array2table([days(bgDates' - datetime(2019,1,1)), bgDeaths']),...
%     array2table([days(spDates' - datetime(2019,1,1)), spDeaths']),...
%     'Keys', 1));

meanArray = muliOuterJoin(...
    array2table([datenum(dkDates'), dkDeaths']),...
    array2table([datenum(bgDates'), bgDeaths']),...
    array2table([datenum(spDates'), spDeaths']),...
    array2table([datenum(geDates'), geDeaths']),...
    array2table([datenum(nyDates'), nyDeaths']),...
    array2table([datenum(auDates'), auDeaths']),...
    array2table([datenum(frDates'), frDeaths']),...
    array2table([datenum(itDates'), itDeaths'])...
    )
%     array2table([datenum(ukDates'), ukDeaths'])...
meanDeaths =  mean(table2array(meanArray(:,2:end)),2);
meanDeaths = meanDeaths/max(meanDeaths);
meanHours =  datetime(table2array(meanArray(:,1)),'ConvertFrom','datenum');

%     array2table([days(spDates' - datetime(2019,1,1)), spDeaths']),...
%     array2table([days(geDates' - datetime(2019,1,1)), geDeaths']),...
%     array2table([days(nyDates' - datetime(2019,1,1)), nyDeaths']),...
%     array2table([days(auDates' - datetime(2019,1,1)), auDeaths']),...

DateString = {'3/1/2020', '4/1/2020',  '5/1/2020', '6/1/2020', '7/1/2020'};

color = [1 0 0 0.3];
opacity = 0.5;
linewidth = 0.7;
% plot(dkDates, dkDeaths, '-', 'Color', [rand(1,1),rand(1,1),rand(1,1),opacity], 'LineWidth', linewidth); hold on
% plot(bgDates, bgDeaths, '-', 'Color', [rand(1,1),rand(1,1),rand(1,1),opacity], 'LineWidth', linewidth); 
% plot(spDates, spDeaths, '-', 'Color', [rand(1,1),rand(1,1),rand(1,1),opacity], 'LineWidth', linewidth); 
% plot(geDates, geDeaths, '-', 'Color', [rand(1,1),rand(1,1),rand(1,1),opacity], 'LineWidth', linewidth); 
% plot(nyDates, nyDeaths, '-', 'Color', [rand(1,1),rand(1,1),rand(1,1),opacity], 'LineWidth', linewidth); 
% plot(auDates, auDeaths, '-', 'Color', [rand(1,1),rand(1,1),rand(1,1),opacity], 'LineWidth', linewidth); 
% plot(frDates, frDeaths, '-', 'Color', [rand(1,1),rand(1,1),rand(1,1),opacity], 'LineWidth', linewidth); 
% plot(itDates, itDeaths, '-', 'Color', [rand(1,1),rand(1,1),rand(1,1),opacity], 'LineWidth', linewidth); 
plot(dkDates, dkDeaths, '-', 'Color', color); hold on
plot(bgDates, bgDeaths, '-', 'Color', color); 
plot(spDates, spDeaths, '-', 'Color', color); 
plot(geDates, geDeaths, '-', 'Color', color); 
plot(nyDates, nyDeaths, '-', 'Color', color); 
plot(auDates, auDeaths, '-', 'Color', color); 
plot(frDates, frDeaths, '-', 'Color', color); 
plot(itDates, itDeaths, '-', 'Color', color); 
% plot(dkDates, dkDeaths, '-'); hold on
% plot(bgDates, bgDeaths, '-'); 
% plot(spDates, spDeaths, '-'); 
% plot(geDates, geDeaths, '-'); 
% plot(nyDates, nyDeaths, '-'); 
% plot(auDates, auDeaths, '-'); 
% plot(frDates, frDeaths, '-'); 
% plot(itDates, itDeaths, '-'); 
% plot(skDates, skDeaths, '-', 'Color', 'red'); 
plot(meanHours, meanDeaths, '-', 'Color', 'red', 'LineWidth', 2)
plot(seDates, seDeaths, '-', 'Color', 'black', 'LineWidth', 2)
% plot(ukDates - 0, ukDeaths/max(ukDeaths), '-', 'Color', 'blue'); 
hold off
grid on
legend(...
    'Denmark (1)',...
    'Belgium (-2)',...
    'Spain (7)',...
    'Germany (-4)',...
    'New York (-5)',...
    'Austria (0)',...
    'France (-2)',...
    'Italy (9)',...
    'mean value',...
    'Sweden (0)')
title('No. deaths / peak value (time shifted)');
% title('Sweden - New York - Belgium');% iso3(countryLd)]);
% set(gca, 'XLim', datetime({'02/18/2020', '07/20/2020'},'format','MM/dd/yyyy'))
% set(gca, 'XTick', datetime(DateString,'format','MM/dd/yyyy'))
% legend(['#deaths / peak value (' rates.world(country).area ')'], ...
%     ['#deaths / peak value (' rates.(continent)(comparecountry).area ')'], ...
%     ['#deaths / peak value (' rates.world(comparecountry2).area ')'], ...
%     'lockdown stringency (+20 days)')
ylim([0, 1.1])
xlim([min(meanHours), max(meanHours)])


function Joined = muliOuterJoin(varargin)
    Joined = varargin{1};
    for k = 2:nargin
      Joined = innerjoin(Joined, varargin{k}, 'Keys', 1);
    end
end

function country = getCountry(continent, name)
    global rates;
    index = 1;
    for c = {rates.(continent).area}
        if strcmp(c{1}, name)
            country = rates.(continent)(index);
        end
        index=index+1;
    end
end


function [deaths, day2] = getDeaths(continent, name, nmean, shift)
    country = getCountry(continent, name);
    dateindex.us = 8;
    dateindex.world = 6;
    countryData = struct2cell(country.timeSeries);
    countryPopulation = country.population;

    day0 = 1:length(countryData(dateindex.(continent),:));
    day1 = [];
    day2 = [];
    for i = (1:length(countryData(dateindex.(continent),:)))
      day1(i) = datenum(countryData(dateindex.(continent),i),'yyyy-mm-ddTHH:MM:ss.fffZ') + 5;
%       day(i) = datenum(countryData(6,i),'yyyy-mm-ddTHH:MM:ss.fffZ') - datenum([2020 3 1]);
    end

    day2 = datetime(day1,'ConvertFrom','datenum') + shift;

    deaths = 1000000*movmean([country.timeSeries.new_deaths], nmean);
    deaths = deaths /countryPopulation;
    deaths = deaths/max(deaths);
end

function [deaths, day2] = getDeathsSweden(sweden, nmean, shift)

    countryData = struct2cell(sweden.timeSeries);
    countryPopulation = sweden.population;

    day0 = 1:length(countryData(6,:));
    day1 = [];
    day2 = [];
    for i = (1:length(countryData(6,:)))
      day1(i) = datenum(countryData(6,i),'yyyy-mm-ddTHH:MM:ss.fffZ');
%       day(i) = datenum(countryData(6,i),'yyyy-mm-ddTHH:MM:ss.fffZ') - datenum([2020 3 1]);
    end

    day2 = datetime(day1,'ConvertFrom','datenum') + shift;
    
    sDeaths = load('data\sverige_new.txt');
    d = [sweden.timeSeries.new_deaths];
    
    d = zeros(size(d));
    d(74:74+122) = sDeaths(1:1+122);
    
    deaths = 1000000*movmean(d, nmean);
    deaths = deaths /countryPopulation;
    deaths = deaths/max(deaths);
end