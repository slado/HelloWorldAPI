FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-buster-slim AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS build
WORKDIR /src
COPY HelloWorldAPI.sln HelloWorldAPI.sln
COPY ["HelloWorldAPI/HelloWorldAPI.csproj", "HelloWorldAPI/"]
COPY ["HelloWorldAPItest/HelloWorldAPItest.csproj", "HelloWorldAPItest/"]
RUN dotnet restore "HelloWorldAPI/HelloWorldAPI.csproj"
COPY . .
WORKDIR "/src/HelloWorldAPI"
RUN dotnet build "HelloWorldAPI.csproj" -c Release -o /app
WORKDIR /src/HelloWorldAPItest
RUN dotnet test -c Release
WORKDIR "/src/HelloWorldAPI"


FROM build AS publish
RUN dotnet publish "HelloWorldAPI.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "HelloWorldAPI.dll"]