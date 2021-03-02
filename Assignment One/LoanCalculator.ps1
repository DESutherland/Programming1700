<#
Name: Evan Sutherland W0443868
Date: 09/26/2020
Description: Part two Assignment one for Prog1700
#>

# A simple loan calculator
function Get-WeeklyPayment {
    
    #BANNER
    Write-Output "Weekly Loan Calculator"
    Write-Output ""

    #INPUT AND VARIABLES
    $loanAmount = [float](Read-Host "Enter the amount of loan")
    $interestRate = [float](Read-Host "Enter the interest rate")
    $loanYear = [float](Read-Host "Enter the number of years")


    #PROCESSING
    $weeklyRate = $interestRate / 5200

    #exponant = -52 * $loanYear
    #Break equation down in to steps

    # First step in 1 + the weekly rate we already calculated
    $firstStep = 1 + $weeklyRate

    # Second step is getting your value from Step one to the negative power of 52 times the number of loan years
    $secondStep = [math]::POW($firstStep, -52 * $loanYear)

    # Third step is subtracting the total of our second step from 1
    $thirdStep = 1 - $secondStep

    # Fourth step is dividing our weekly rate by the value of our third step
    $fourthStep = $weeklyRate / $thirdStep

    # Our final step is multiplying the value of our fourth step by the value of the loan amount
    $weeklyPayment = $fourthStep * $loanAmount
    

    #OUTPUT    
    
    Write-Output ""
    Write-Output ("The Weekly payment will be: {0:C}" -f $weeklyPayment)
  
}

if ($MyInvocation.InvocationName -ne '.')
{
   
    Get-WeeklyPayment
}

