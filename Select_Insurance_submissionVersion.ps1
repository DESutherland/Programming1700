<#
Name: Evan Sutherland W0443868
Date: 10/23/2020
Description: Part Three Assignment Two for Prog1700
#>

# A program for determining insurance rates based off user input. Learning the use of if statements
# This function determines the customers gender and stores it for future use
function Select-Gender($InGender)
{
    if ($InGender -eq "Male")
    {
        Return "Male"
    }
    elseif ($InGender -eq "Female") 
    {
        return "Female"
    }   
}

# This function determines what age bracket the customer falls in based on their age input value
function Select-Age($InAge)
{
    if ($InAge -ge 15 -and $InAge -lt 25)
    {
        return "bracketOne"
    }
    elseif ($InAge -ge 25 -and $InAge -lt 40)
    {
        return "bracketTwo"
    }
    elseif ($InAge -ge 40 -and $InAge -lt 70)
    {
        return "bracketThree"
    }
    else 
    {
        Write-Output "Please call our office for further assistance"
    }
}

# This function determines the monthly insurance price based on the input value for the vehicle price, the customer gender, and what age bracket they fall in
# The third bracket for each gender is the same rate while bracket one and two differ
function Get-Cost($InCost, $InCustGender, $InBracket)
{
    if ($InCustGender -eq "Male" -and $InBracket -eq "bracketOne")
    {
        $insurancePrice = [float]($InCost * 0.25 / 12)

        return $insurancePrice
    }
    elseif ($InCustGender -eq "Male" -and $InBracket -eq "bracketTwo")
    {
        $insurancePrice = [float]($InCost * 0.17 / 12)

        return $insurancePrice
    }
    elseif ($InCustGender -eq "Female" -and $InBracket -eq "bracketOne")
    {
        $insurancePrice = [float]($InCost * 0.20 / 12)

        return $insurancePrice
    }
    elseif ($InCustGender -eq "Female" -and $InBracket -eq "bracketTwo")
    {
        $insurancePrice = [float]($InCost * 0.15 / 12)

        return $insurancePrice
    }
    elseif ($InCustGender -eq "Male" -or $InCustGender -eq "Female" -and $InBracket -eq "bracketThree")
    {
        $insurancePrice = [float]($InCost * 0.10 / 12)

        return $insurancePrice
    }
  
}
# Main Function
function Get-InsuranceCost {

    # INPUT AND VARIABLES

    $customerGender =  Read-Host "Are you 'Male' or 'Female'"
    Write-Output       ""
    $customerAge    = [int](Read-Host "Enter your age")
    Write-Output       ""
    $purchasePrice  = [float](Read-Host "Enter the purchase price of the vehicle")


    # PROCESSING
    $gender     = Select-Gender -InGender $customerGender
    $ageBracket = Select-Age -InAge $customerAge
    $finalCost  = Get-Cost -InCost $purchasePrice -InCustGender $gender -InBracket $ageBracket
    
    # OUTPUT 
    Write-Output  ""
    Write-Output ("Your monthly insurance will be {0:C}" -f $finalCost)
}

# Trigger main function
if ($MyInvocation.InvocationName -ne '.')
{
  
    Get-InsuranceCost
}

