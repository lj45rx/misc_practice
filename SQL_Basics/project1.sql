select TOP(10) *
from CovidDeaths
order by location, date

select TOP(10) *
from CovidVaccinations
order by location, date

select location, date, total_cases, new_cases, total_deaths, population
from CovidData..CovidDeaths
Order by location, date



-- case fatality rate (total deaths / total cases)
--- integer division
select location, date, total_cases, total_deaths, (100*total_deaths/total_cases) as CaseFatalityPerc
from CovidData..CovidDeaths
Order by location, date

--- float division
select location, date, total_cases, total_deaths, (100*total_deaths/cast(total_cases as float)) as CaseFatalityPerc
from CovidData..CovidDeaths
where location like '%states%' --"fuzzy" matching
Order by location, date

---eigen
--- find first day with 1mio+ total_deaths in the us
select top(1) location, date, total_cases, total_deaths, (100*total_deaths/cast(total_cases as float)) as CaseFatalityPerc
from CovidData..CovidDeaths
where location like '%states%' and total_deaths > 1000000
Order by location, date


-- total cases/deaths vs population
select location, date, population, total_cases, total_deaths
, (total_cases/cast(population/100000 as float)) as TotalCasesPer100k
, 100*(total_cases/cast(population as float)) as 'CasesByPop%'
, (total_deaths/cast(population/100000 as float)) as TotalDeathsPer100k
, 100*(total_deaths/cast(population as float)) as 'DeathsByPop%'
from CovidData..CovidDeaths
where location like '%germany%' --"fuzzy" matching
Order by location, date



-- which contries have highest infection rates by population
--- eigen
select location, population
, 100*(MAX(total_cases)/cast(population as float)) as CasesByPopulation
, 100*(MAX(total_deaths)/cast(population as float)) as DeathsByPopulation
from CovidData..CovidDeaths
group by location, population
order by DeathsByPopulation DESC

--- via tut
select location, population
, MAX(total_cases) as HighestInfectionCount
, MAX(total_deaths) as HighestDeathCount
, MAX(100*(total_cases/cast(population as float))) as HighestInfectedP
, MAX(100*(total_deaths/cast(population as float))) as HighestDeathP
from CovidData..CovidDeaths
group by population, location
Order by 6 DESC


----TODO warum nicht continent etc selektierbar hier?
--- maximun total_deaths per "location"
select location
, MAX(total_deaths) as HighestDeathCount
from CovidData..CovidDeaths
group by location
Order by 2 DESC

-- some locations are not countries - eg world, high income, asia --> those have "continent" == 'nan'
select location
, MAX(total_deaths) as HighestDeathCount
from CovidData..CovidDeaths
where continent != 'nan'
group by location
Order by 2 DESC

---eigen
-- "continent is not NULL" not working - why?
select top(10) *
from CovidData..CovidDeaths
where location like '%world%'
-- in tutorial NULL - here 'nan'



-- showing continents with the highest death count
---wrong example:
--- this will show the hightst value PER continent
select continent
, MAX(total_deaths) as HighestDeathCount
from CovidData..CovidDeaths
where continent != 'nan'
group by continent
Order by 2 DESC
---correct example:
--- this will show the actuall values for the continent entries (location=<continent>, continent=nan)
select location
, MAX(total_deaths) as HighestDeathCount
from CovidData..CovidDeaths
where continent = 'nan'
group by location
Order by 2 DESC



-- global numbers
--- total new cases worldwide per date
select date
, sum(new_deaths) as NewDeaths
, sum(new_cases) as NewCases
, 100*(sum(new_deaths)/cast(sum(new_cases) as float)) as FatalityRate
from CovidData..CovidDeaths
where continent  != 'nan' 
and new_cases != 0 --only weekly data -> remove dates without data
group by date
Order by date

--- remove date to get single total value
select sum(new_deaths) as NewDeaths
, sum(new_cases) as NewCases
, 100*(sum(new_deaths)/cast(sum(new_cases) as float)) as FatalityRate
from CovidData..CovidDeaths
where continent  != 'nan' 
and new_cases != 0 --only weekly data -> remove dates without data






-- Total population vs vaccinations
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from CovidData..CovidDeaths as dea
join CovidData..CovidVaccinations as vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent != 'nan'
order by 1,2,3


---eigen
---when did each country begin vaccinating
select dea.location, MIN(dea.date) as DateFirstVaccine
from CovidData..CovidDeaths as dea
join CovidData..CovidVaccinations as vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent != 'nan'
and vac.new_vaccinations > 0
group by dea.location
order by 2



-- vaccinations by location, cummulative by date ("rolling count")
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location order by dea.location, dea.date) as CummulativeVaccinations
-- , 100*(CummulativeVaccinations/dea.population) -- cannot use for calculations
from CovidData..CovidDeaths as dea
join CovidData..CovidVaccinations as vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent != 'nan'
order by 1,2,3



-- idea - CummulativeVaccinations/population 
-- problem - cant use CummulativeVaccinations to calculate on
-- possible solution a) CTE
With PopVsVat (continent, location, date, population, new_vaccinations, CummulativeVaccinations)
as (
	select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
	, SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location order by dea.location, dea.date) as CummulativeVaccinations
	-- , 100*(CummulativeVaccinations/dea.population) -- cannot use for calculations
	from CovidData..CovidDeaths as dea
	join CovidData..CovidVaccinations as vac
		on dea.location = vac.location
		and dea.date = vac.date
	where dea.continent != 'nan'
	--order by 1,2,3
)
Select *
, 100*(CummulativeVaccinations/cast(population as float)) as VaccinationsVsPop
from PopVsVat
where location = 'Germany'
order by 1,2,3

-- possible solution b) TempTable
Drop Table If Exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location  nvarchar(255),
date date,
Population numeric, 
New_vaccinations numeric,
Cummulative_vaccinations numeric
)

Insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
	, SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location order by dea.location, dea.date) as CummulativeVaccinations
	-- , 100*(CummulativeVaccinations/dea.population) -- cannot use for calculations
	from CovidData..CovidDeaths as dea
	join CovidData..CovidVaccinations as vac
		on dea.location = vac.location
		and dea.date = vac.date
	where dea.continent != 'nan'
	--order by 1,2,3

Select *
, 100*(Cummulative_vaccinations/cast(population as float)) as VaccinationsVsPop 
from #PercentPopulationVaccinated
where location = 'Germany'
order by 1,2,3






-- Creating views to store data for laret visualizations
Create View CummulativeVaccinationsView as 
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location order by dea.location, dea.date) as CummulativeVaccinations
-- , 100*(CummulativeVaccinations/dea.population) -- cannot use for calculations
from CovidData..CovidDeaths as dea
join CovidData..CovidVaccinations as vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent != 'nan'

---MEMO views can be called like tables
select *
from CummulativeVaccinationsView


















