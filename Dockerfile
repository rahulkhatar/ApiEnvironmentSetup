FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app
COPY . . /app

# Build and publish a release version
RUN dotnet publish -c Release -o out

# Build runtime image

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app/out .

# Set the environment variable to make the app listen on port 0.0.0.0.8

ENV ASPNETCORE_URLS="http://0.0.0.0:80";

# Expose the port 80

EXPOSE 80

# Run the api

ENTRYPOINT ["dotnet", "environmentAPI.dll"]