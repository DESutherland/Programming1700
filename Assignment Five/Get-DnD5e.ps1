<#
Evan Sutherland W0443868
12/09/2020
Assignment 5 PROG 1700
#>

# Using a public API to take user input to give the user a selection of DnD5e mosters and there full list of stats.
# Main Function
function Get-DnD5e {

    # Pulls from DnD5e Monsters API
    $dataset = Invoke-RestMethod -URI 'https://www.dnd5eapi.co/api/monsters'
    
    # Set an empty array to store our API data in
    $datasetArray = @()

    # Prompts for user input and does validation ********Need to add validation************
    Write-Output "Welcome to the DnD 5e Monster Selector!"
    Write-Output ("=" * 60)
    Write-Output "Please enter the name of the monster you would like information on, or leave blank and press enter to select from the full list of monsters"
    Write-Output "If your selection does not match a name from the list you will be prompted to select from the full list of monsters"
    Write-Output ("=" * 60)
    $userInput = Read-Host "Enter monster name here (Please use only Upper and lower case letters, no numbers or special characters)"
    Write-Output ("=" * 60)

    # Runs through each object in the API and stores them in our Array
    foreach($monster in $dataset.results)
    {
        $datasetArray += $monster
    }

    # Determines if the user inputted a monster name and if they did if it matches a name from the Monsters API
    # **********Need to match User input name if matches to the URL from the array****************
    $userChosenMonster = ""
    $userSelectedMonster = $false
    foreach($name in $datasetArray.name)
    {
        if($datasetArray.name -eq $userInput)
        {
            $userSelectedMonster = $true
        }
        elseif($datasetArray.name -ne $userInput) 
        {
            $userSelectedMonster = $false
        }
        
    }

    # If the user did not input a monster name or it did not match open a Grid View window to allow the user to select a monster
    # A message will be outputted showing the user which monster they selected
    if($userSelectedMonster -eq $false)
    {
        $chosenMonster = $datasetArray | Out-GridView -Title "DnD5e Mosters" -PassThru
        Write-Output ("Done. You selected the following monster: {0}" -f $chosenMonster.name)
    }
    else 
    {
        Write-Output ("Done. You selected the following monster: {0}" -f $userInput)
    }

    # Takes the URL to the chosen monsters info page and stores it in a variable
    $chosenMonsterURL = $chosenMonster.url

    # Takes the variable we just created and adds it to the full API URL
    $monsterURL = "https://www.dnd5eapi.co$chosenMonsterURL"

    # Creates a new variable for the selected monsters info page
    $monsterInfo = Invoke-RestMethod -URI $monsterURL

    # Opens a new grid view window to the info page of the chosen monster for the user to browse
    $monsterInfo | Out-GridView -Title $chosenMonster.name 
    
}

if ($MyInvocation.InvocationName -ne '.')
{
    # Trigger main function
    Get-DnD5e
}

