FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
WORKDIR /src
COPY ["HelloWorldAPI/HelloWorldAPI.csproj", "HelloWorldAPI/"]
RUN dotnet restore "HelloWorldAPI/HelloWorldAPI.csproj"
COPY . .
WORKDIR "/src/HelloWorldAPI"
RUN dotnet build "HelloWorldAPI.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "HelloWorldAPI.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "HelloWorldAPI.dll"]