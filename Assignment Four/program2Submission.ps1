<#
Evan Sutherland W0443868
11/26/2020
Assignment 4 Program 2 PROG1700
#>

#This function serves to replace the specific sections in the story with the users inputted selection
function Get-Selections($InSelections, $InStory)
{
   foreach($line in $InStory)
   {
       $newLine = ""
       if($line.Contains("_1_") -or $line.Contains("_2_") -or $line.Contains("_3_") -or $line.Contains("_4_") -or $line.Contains("_5_") -or
        $line.Contains("_6_") -or $line.Contains("_7_"))
       {
            $line -replace '\b_1_\b', $InSelections[0].ToUpper() -replace '\b_2_\b', $InSelections[1].ToUpper() -replace '\b_3_\b', `
             $InSelections[2].ToUpper() -replace '\b_4_\b', $InSelections[3].ToUpper() -replace '\b_5_\b', $InSelections[4].ToUpper() -replace '\b_6_\b', `
              $InSelections[5].ToUpper() -replace '\b_7_\b', $InSelections[6].ToUpper()
            $newLine += $line
       }
 
   }
   return $replacedLines
}


# RENAME FUNCTION: Change the name of the function to match the file name for now.*
function Show-Madlib {
    #Input the story file and the choices file, set headers for choices and convert it to a csv
    $headers = "Description", "A", "B", "C", "D", "E"
    $inputStoryFile = ".\Assignments\Assignment 4\the_story_file.txt"
    $fileStoryData = Get-Content -path $inputStoryFile
    $inputChoicesFile = ".\Assignments\Assignment 4\the_choices_file.csv"
    $fileChoicesData = Get-Content -path $inputChoicesFile | Convertfrom-Csv -Header $headers
    


    Write-Output "The Itsy Bitsy Aardvark"
    Write-Output ""

    # Run through a loop that shows the users the choices, and have them make their selections
    $selection = ""
    $savedSelection = @()
    foreach($line in $fileChoicesData)
    {
        Write-Output ("Please choose {0}:" -f $line.Description)
        Write-Output ("a){0}" -f $line.A)
        Write-Output ("b){0}" -f $line.B)
        Write-Output ("c){0}" -f $line.C)
        Write-Output ("d){0}" -f $line.D)
        Write-Output ("e){0}" -f $line.E)

       #Make sure only valid inputs are entered
        $lettersValidate = "^[a-e]$"
        do{
            $selection = Read-Host "Enter choice (a-e)"
            if(-Not ($selection -Match $lettersValidate))
                {}
            } while(-Not ($selection -Match $lettersValidate))

        if($selection -eq "A")
        {
            $savedSelection += ,$line.A
        }
        elseif($selection -eq "B") 
        {
            $savedSelection += ,$line.B
        }
        elseif($selection -eq "C") 
        {
            $savedSelection += ,$line.C
        }
        elseif($selection -eq "D") 
        {
            $savedSelection += ,$line.D
        }
        elseif($selection -eq "E") 
        {
            $savedSelection += ,$line.E
        }
        Write-Output "" 
    }
    
    #Call on the function to write the new story
    $newStory = Get-Selections -InSelections $savedSelection -InStory $fileStoryData
    Write-Output "Your Completed Story"
    Write-Output ""
    Write-Output $newStory


    
}

if ($MyInvocation.InvocationName -ne '.')
{
    # EDIT: Trigger our main function to launch the program by using the name of the function above
    Show-Madlib
}

# * In IT, square brackets in an example generally mean they should be replaced along with text inside