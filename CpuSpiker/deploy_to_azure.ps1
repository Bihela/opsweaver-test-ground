# Deploy CpuSpiker to Azure App Service (Free Tier)
# Note: F1 Tier quota is limited in some regions. Using 'Central US' as tested.

# Configuration
$resourceGroup = "rg-opsweaver-hackathon"
$location = "centralus"                   # Central US has better F1 availability
$appName = "cpuspiker-" + (Get-Random)    # Unique app name
$sku = "F1"                               # Free Tier
$planName = "asp-cpuspiker-free-central"  # Plan name

# Login to Azure (if not already logged in)
# az login

# Create Resource Group if it doesn't exist
Write-Host "Creating/Checking Resource Group..."
az group create --name $resourceGroup --location $location

# Create App Service Plan (Free Tier, Linux)
Write-Host "Creating App Service Plan ($sku in $location)..."
az appservice plan create --name $planName --resource-group $resourceGroup --sku $sku --is-linux --location $location

# Create Web App (DotNet 8)
Write-Host "Creating Web App ($appName)..."
# Using DOTNETCORE:8.0 runtime stack
az webapp create --name $appName --plan $planName --resource-group $resourceGroup --runtime "DOTNETCORE:8.0"

# Disable remote build (since we are deploying pre-built artifacts)
Write-Host "Configuring app settings..."
az webapp config appsettings set --name $appName --resource-group $resourceGroup --settings SCM_DO_BUILD_DURING_DEPLOYMENT=false

# Publish the application
Write-Host "Publishing application..."
dotnet publish -c Release -o ./publish

# Remove nested publish folder if exists (cleanup)
if (Test-Path ".\publish\publish") {
    Remove-Item -Path ".\publish\publish" -Recurse -Force
}

# Zip the publish folder
Write-Host "Zipping artifacts..."
if (Test-Path "publish.zip") { Remove-Item "publish.zip" -Force }
Compress-Archive -Path ".\publish\*" -DestinationPath ".\publish.zip" -Force

# Deploy via Zip Deploy
Write-Host "Deploying to Azure..."
az webapp deploy --resource-group $resourceGroup --name $appName --src-path publish.zip --type zip --clean true

Write-Host "Deployment Complete!"
Write-Host "URL: https://$appName.azurewebsites.net/spike"
