--Percentage Population Vaccinated
select dth.continent,dth.location,dth.date,dth.population,vcn.new_vaccinations,
sum(cast(vcn.new_vaccinations as bigint)) over (partition by dth.location order by dth.location,dth.date) as Rolling_people_vaccinated 
	from Portfolio..CovidDeaths dth
	join Portfolio..CovidVaccination vcn
		on 
		dth.date=vcn.date and
		dth.location=vcn.location
	where dth.continent is not null
	and dth.location='India'
	order by 2,3;

--With CTE

With PolnVsVcn (Continent,Location,Date,Population,New_Vaccination,Rolling_people_vaccinated)
as
(
select dth.continent,dth.location,dth.date,dth.population,vcn.new_vaccinations,
sum(cast(vcn.new_vaccinations as bigint)) over (partition by dth.location order by dth.location,dth.date) as Rolling_people_vaccinated 
	from Portfolio..CovidDeaths dth
	join Portfolio..CovidVaccination vcn
		on 
		dth.date=vcn.date and
		dth.location=vcn.location
	where dth.continent is not null
	and dth.location='India'
--	order by 2,3
)

select *, (Rolling_people_vaccinated/Population)*100 as PercentVaccination from PolnVsVcn

--Temp Table


Create table  #PercentPopulationVaccinated(
Continent nvarchar(255),
Location nvarchar(255),
population int,
New_Vaccinations numeric,
Rolling_people_vaccinated numeric
)
Insert into #PercentPopulationVaccinated
select dth.continent,dth.location,dth.population,vcn.new_vaccinations,
sum(cast(vcn.new_vaccinations as bigint)) over (partition by dth.location order by dth.location,dth.date) as Rolling_people_vaccinated 
	from Portfolio..CovidDeaths dth
	join Portfolio..CovidVaccination vcn
		on 
		dth.date=vcn.date and
		dth.location=vcn.location
	where dth.continent is not null
	and dth.location='India'
--	order by 2,3

select *, (Rolling_people_vaccinated/Population)*100 as PercentVaccination from #PercentPopulationVaccinated

--drop table if exists #PercentPopulationVaccinated

--Create View to store dta for visualization
create view PercentPopulationVaccinated as
select dth.continent,dth.location,dth.date,dth.population,vcn.new_vaccinations,
sum(cast(vcn.new_vaccinations as bigint)) over (partition by dth.location order by dth.location,dth.date) as Rolling_people_vaccinated 
	from Portfolio..CovidDeaths dth
	join Portfolio..CovidVaccination vcn
		on 
		dth.date=vcn.date and
		dth.location=vcn.location
	where dth.continent is not null
	and dth.location='India'
	--order by 2,3;