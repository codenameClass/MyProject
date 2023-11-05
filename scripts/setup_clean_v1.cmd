@echo off
set "name=MyProject"
set "framework=net8.0"

cd ..

dotnet new sln -n "%name%"

:: Setup WebApi project
dotnet new webapi -f "%framework%" -n "WebApi" -o src/API/%name%.WebApi
:: Setup WebApp project
dotnet new webapp -f "%framework%" -n "WebApp" -o src/UI/%name%.WebApp
:: Setup Core projects
dotnet new classlib -f "%framework%" -n "%name%.Domain" -o src/Core/%name%.Domain
dotnet new classlib -f "%framework%" -n "%name%.Application" -o src/Core/%name%.Application
:: Setup External projects
dotnet new classlib -f "%framework%" -n "%name%.Persistence" -o src/External/%name%.Persistence
::dotnet new classlib -f "%framework%" -n "%name%.Infrastructure" -o src/External/%name%.Infrastructure
:: Setup Test projects
dotnet new xunit -f "%framework%" -n "%name%.Tests.Unit" -o test/%name%.Tests.Unit

:: Add Entity Framework to the Persistence layer
cd src/External/%name%.Persistence
dotnet add package Microsoft.EntityFrameworkCore.SqlServer
dotnet add package Microsoft.EntityFrameworkCore.Design
cd ../../..

:: Add FluentAssertions to the Unit Tests
cd test/%name%.Tests.Unit
dotnet add package FluentAssertions
cd ../..

:: Add projects to solution
dotnet sln add src/API/%name%.WebApi/WebApi.csproj
dotnet sln add src/UI/%name%.WebApp/WebApp.csproj
dotnet sln add src/Core/%name%.Domain/%name%.Domain.csproj
dotnet sln add src/Core/%name%.Application/%name%.Application.csproj
dotnet sln add src/External/%name%.Persistence/%name%.Persistence.csproj
::dotnet sln add src/External/%name%.Infrastructure/%name%.Infrastructure.csproj
dotnet sln add test/%name%.Tests.Unit/%name%.Tests.Unit.csproj