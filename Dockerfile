FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
WORKDIR /src
COPY ["EBDemo.csproj", ""]
RUN dotnet restore "./EBDemo.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "EBDemo.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "EBDemo.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "EBDemo.dll"]