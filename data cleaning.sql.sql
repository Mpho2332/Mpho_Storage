
select *
 from [portfolioproject].[dbo].[coviddeaths]
 order by 6 desc


/* data that we are going to use*/

select location, population, date, total_cases, new_cases, total_deaths
from [portfolioproject].[dbo].[coviddeaths]
order by 5, 6

/* Total case vs total deaths ( likelyhood of dieying if you contact covid in African continent)*/

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathpercentage
from [portfolioproject].[dbo]. [coviddeaths]
where continent = 'Africa'
order by 3,4,5

/* Total cases vs Population*/

select location, date, total_cases, population, (total_deaths/population)*100 as deathpercentage 
from [portfolioproject].[dbo].[coviddeaths]
where continent = 'Africa'
order by 3,4,5

/* contries with the highest infection ratecompared to the population*/

select location, population, max(total_cases) as highestinfection, max(total_cases/population)*100 as infectionpercentage 
from [portfolioproject].[dbo].[coviddeaths]
where continent = 'Africa'
group by  population, location
order by 3 desc

/* contries with highest deaths in Africa*/

select location, population, total_deaths
from [portfolioproject].[dbo].[coviddeaths]
where continent = 'Africa'
order by 3 desc

/* the continent with the highest death count per population */

select continent, max(cast(total_deaths as int) ) as highestdeaths
from [portfolioproject].[dbo].[coviddeaths]
where  continent is not NULL
group by continent
order by 2 desc
 
 /* global numbers*/

 select date, sum(new_cases) as newcases, sum(cast(new_deaths as int)) as sumofdeaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from [portfolioproject].[dbo].[coviddeaths]
where continent is not NULL
group by date
order by 1

/* total population vs vaccinations*/

select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) over (partition by dea.location) as PeopleVaccined
from [portfolioproject].[dbo].[coviddeaths] as dea
    join [portfolioproject].[dbo].[covidvaccine] as vac
	   ON dea.location = vac.location and dea.date = vac.date
where dea.continent is not NULL

/*use CTE*/

with popvsvac ( continent, location, date, population, new_vaccinations, PeopleVaccinated) 
as
(
select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) over (partition by dea.location) as PeopleVaccined
from [portfolioproject].[dbo].[coviddeaths] as dea
    join [portfolioproject].[dbo].[covidvaccine] as vac
	   ON dea.location = vac.location and dea.date = vac.date
where dea.continent is not NULL
)
select*, (PeopleVaccinated/population)*100 as VaccinePercentage
from  popvsvac

/*TEMP TABLE*/

drop table if exists #PercentageVaccinatedPeople 
create table #PecentageVaccinatedPeople
(
continent nvarchar(255), location nvarchar(255), date datetime, population numeric, new_vaccinations numeric, PeopleVaccinated numeric
)
insert into #PecentageVaccinatedPeople
  
select dea.continent, dea.location,dea.date,dea.population,vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) over (partition by dea.location) as PeopleVaccined
from [portfolioproject].[dbo].[coviddeaths] as dea
    join [portfolioproject].[dbo].[covidvaccine] as vac
	   ON dea.location = vac.location and dea.date = vac.date
where dea.continent is not NULL

select*, (PeopleVaccinated/population)*100 as VaccinePercentage
from  #PecentageVaccinatedPeople



