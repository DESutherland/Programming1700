<#
Name: Evan Sutherland W0443868
Date: 11/16/2020
Description: Part Two Assignment Three for PROG1700
#>
# Taking a user inputted message along with user inputted letters to redact, looping through the message and redacting the proper letters
# Outputting the redacted message along with a count of all letter redacted. Learning the use of nested for loops and input validation.

# This function loops through the inputted phrase and compares it to the inputted letters to redact. If a letter matches it gets replaced with an _
function Get-RedactedLetters($InMessage, $InRedacted) 
{
    $newMessage = ""

    for($j = 0; $j -lt $InMessage.length; $j++)
    {
        $replaced = $false

        for($i = 0; $i -lt $InRedacted.Length; $i++)
        {
            if($InMessage[$j] -eq $InRedacted[$i])
            {
                $InMessage[$j] = "_"
                $newMessage += $InMessage[$j]
                $replaced = $true 
                break  
            }           
        }
        if($replaced -ne $true){$newMessage += $InMessage[$j]}        
    }
    return $newMessage
}

# This function takes the newly redacted message, counts the instances of "_", and outputs the count  
function Get-NumbersRedacted($InFullMessage)
{
    
    $charCount = ($InFullMessage.ToCharArray() | Where-Object {$_ -eq '_'} | Measure-Object).Count

    return $charCount
}

# Main function
function Show-Message {

    # INPUT
    
    $count = 0
    $messageValidate = ""
    $message = ""

    while($message -ne "Quit")
    {
        $count = 0
        do
        {
            if($count -gt 0)
                {
                    Write-Output "Error"
                }        
                $messageValidate = Read-Host "Type a phrase (or quit to exit program)"
                Write-Output ""
                $count ++
        } while($messageValidate.length -eq 0)

        $message = $messageValidate
        $messageAsArray = $message.ToCharArray()

        if($message -eq "Quit")
        {
            break
        }

        $redactLetters = Read-Host "Type a comma-separated list of letters to redact"
        $lettersAsArray = $redactLetters -split ","

        # Processing

        $redactedMessage = Get-RedactedLetters -InMessage $messageAsArray -InRedacted $lettersAsArray
        $numberRedacted = Get-NumbersRedacted -InFullMessage $redactedMessage

        # Output
        Write-Output "Number of letters redacted: $numberRedacted"
        Write-Output $redactedMessage
        Write-Output ""
    }    
}

if ($MyInvocation.InvocationName -ne '.')
{
    # Trigger main function
    Show-Message
}

