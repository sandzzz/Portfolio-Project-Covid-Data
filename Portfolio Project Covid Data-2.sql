--select * from Portfolio..CovidDeaths where continent is not null order by 3,4

--select * from Portfolio..CovidVaccination order by 3,4 ;

select location,date,total_cases,new_cases,total_deaths,population from Portfolio..CovidDeaths where continent is not null order by 1,2;

--Looking at Total Cases vs Total Deaths

select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage from Portfolio..CovidDeaths 
where continent is not null order by 1,2;

--Looking at Total Cases vs Population
--%population that got covid
select location,date,Population,total_cases,(total_cases/population)*100 as CovidPercentage from Portfolio..CovidDeaths 
where location='India' and continent is not null
order by 2;

--Countries with highest Infection Rate compared to Population

select location,Population,max(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
from Portfolio..CovidDeaths 
where continent is not null
group by location,population 
order by 4 DESC;

--Showing country with highest Death Count per Population

select location,max(cast(total_deaths as int)) as TotalDeathCount
from Portfolio..CovidDeaths 
where continent is not null
group by location
order by TotalDeathCount desc;

-- Break down into continent
select continent,max(cast(total_deaths as int)) as TotalDeathCount
from Portfolio..CovidDeaths 
where continent is not null
group by continent
order by TotalDeathCount desc;

--Continents with Highest Death Count per population
select continent,max(cast(total_deaths as int)) as TotalDeathCount
from Portfolio..CovidDeaths 
where continent is not null
group by continent
order by TotalDeathCount desc;

--GlobalNUmbers
select date,sum(new_cases) as Global_Daily_New_Cases, sum(cast(new_deaths as int)) as Global_Daily_New_Deaths,
sum(cast(new_deaths as int))/sum(new_cases)*100 as Death_Percent
from Portfolio..CovidDeaths 
where continent is not null
group by date
order by 1

select sum(new_cases) as Total_Cases, sum(cast(new_deaths as int)) as Total_Deaths,
sum(cast(new_deaths as int))/sum(new_cases)*100 as Death_Percent
from Portfolio..CovidDeaths 
where continent is not null
--group by date
order by 1