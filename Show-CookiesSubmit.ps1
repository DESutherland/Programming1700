<#
Name: Evan Sutherland W0443868
Date: 11/17/2020
Description: Part One Assignment Three for PROG1700
#>

#This function determines the average of all the boxes sold
function Show-Average($InBoxes)
{
    $average = ($InBoxes | Measure-Object -Average).Average
    return $average
}

# This function takes in the Guides names and their boxes sold and compares them to the prize critera. It then prints what prize each guide receives
function Get-Prizes($InAverage, $InGuides, $InSold)
{
    $prizeArray += ,("-Trip to Girl Guide Jamboree in Aruba!")
    $prizeArray += ,("-Super Seller Badge")
    $prizeArray += ,("-Left over cookies")
    $prizeArray += ,("-")

    for($i = 0; $i -lt $InGuides.length; $i++)
    {
        if($InSold[$i] -eq ($InSold | Measure-Object -Maximum).Maximum)
        {
            Write-Host $InGuides[$i]`t $prizeArray[0]
        }
        elseif($InSold[$i] -gt $InAverage)
        {
            Write-Host $InGuides[$i]`t $prizeArray[1]
        }
        elseif($InSold[$i] -le $InAverage -and $InSold[$i] -gt 0)
        {
            Write-Host $InGuides[$i]`t $prizeArray[2]
        }
        elseif($InSold[$i] -eq 0)
        {
            Write-Host $InGuides[$i]`t $prizeArray[3]
        }
       
      
    }
}



# RENAME FUNCTION: Change the name of the function to match the file name for now.*
function Show-Cookies {
# This validates that a number is enter to determine how many guides have sold cookies
    $guidesAsString = "0"
    $count = 0
    $guides = 0

    do{   
                if($count -gt 0)
                {
                    Write-Output "Error"
                }
            
                $guidesAsString = Read-Host "Enter the number of guides selling cookies: " 
                
                $count++
            
    } while(-Not [int]::TryParse($guidesAsString,[ref]$guides)) 
    
#  This takes in the names of the Guides and how many boxes they sold, validating that a number is entered for boxes
    $numberBoxesAsString = ""
    $count = 0

    [string[]]$nameGuides = @()
    [int[]]$numberBoxes = @()
    [int]$currentNumber = 0

    for ($i=0; $i -lt $guides; $i++)
    {
        Write-Output ""
        $nameGuides += Read-Host "Enter the name of guide #$($i + 1)"
        $count = 0
        do{

            if($count -gt 0)
            {
                Write-Output "Error"
            }
    
        $numberBoxesAsString = Read-Host ("Enter the number of boxes sold by {0}" -f $nameGuides[$i])

        $count++
            
        } while(-Not [int]::TryParse($numberBoxesAsString,[ref]$currentNumber))
        $numberBoxes += $currentNumber
    } 
    
    # Calling to functions and printing returns
    Write-Output ""
    $averageSold = Show-Average -InBoxes $numberBoxes

    Write-Output ("The average number of boxes sold was {0:n1}" -f $averageSold)
    Write-Output ""
    Write-Output "Guide`t Prizes Won:"
    Write-Output "------------------------------------------------------------------------------"

    Get-Prizes -InAverage $averageSold -InGuides $nameGuides -InSold $numberBoxes

}

if ($MyInvocation.InvocationName -ne '.')
{
    # EDIT: Trigger our main function to launch the program by using the name of the function above
    Show-Cookies
}

# * In IT, square brackets in an example generally mean they should be replaced along with text inside