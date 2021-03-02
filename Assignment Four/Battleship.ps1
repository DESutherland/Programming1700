<#
Evan Sutherland W0443868
11/26/2020
Assignment 4 Program 3 PROG1700
#>
# A simple Battleship game type program. There is a separate input file used as a map with pre-determined location of ships. The program will input that file
# and then with user input determine the outcome of the game. This program makes use of all concepts learned in the PROG1700 course

#determine whether the target was a hit and change the corresponding coordinate on the array to the appropriate character 
#and set $hit to true/false
function Show-Hit($InMapArray,$InRowChosen,$InColumnChosen)
{
        if($InMapArray[$InRowChosen][$InColumnChosen] -eq "1")
        {
            $shipHit = $true
        }
        elseif($InMapArray[$InRowChosen][$InColumnChosen] -eq "0")
        {
            $shipHit = $false
        }
        return $shipHit
}
# Determine whether the player wins the game
function Get-Win($InHitCount,$InMaxHits)
{  
    if($InHitCount -eq $InMaxHits)
    {
        $gameWon = $true
    }
    else
    {
        $gameWon = $false    
    }
    return $gameWon
}
# Main Function
function Show-Battleship {

    $headers = "A","B","C","D","E","F","G","H","I","J"
    $inputFile = ".\Assignments\Assignment 4\map.txt"
    $mapData = Get-Content -path $inputFile | Convertfrom-Csv -header $headers
    #Create an array from the map file, Also create a blank array from that same file to display to the user
    $mapArray = @()
    $blankMapArray = @()
    $count = 1
    foreach($row in $mapdata)
    {
        $currentRow = (
            ($row.A),
            ($row.B),
            ($row.C),
            ($row.D),
            ($row.E),
            ($row.F),
            ($row.G),
            ($row.H),
            ($row.I),
            ($row.J)
        )
        $mapArray += ,$currentRow 
        $blankMapArray += ,($count," "," "," "," "," "," "," "," "," "," ")
        #This will add our numbers down the side
        $count++
    }
  
    Write-Output "Let's play Battleship!"
    Write-Output "You have 30 missles to fire to sink all five ships."
    #set the number of missles remaining, set a variable for the user inputted target, set the win condition, a hit counter, and set hit to false
    $misslesRemaining = 30
    $target = ""
    $win = $false
    $hitCount = 0
    $hit = $false
    #A win is always achieved at 17 hits
    Set-Variable MAXHITS -option Constant -value 17
    #When all parts of a ship are hit this variable will switch to true
    $cruiserSunk = $false
    $battleshipSunk = $false
    $destroyerSunk = $false
    $subSunk = $false
    $carrierSunk = $false

    #set a loop to determine whether the game continues. Game will end when missle count reaches 0 or all 17 targets are hit
    while ($misslesRemaining -gt 0 -and $win -eq $false)
    {
        #print the blank map for the player
        $outputHeaders = "  ","A","B","C","D","E","F","G","H","I","J"
        $outputHeaders -join " " 
        Write-Output ($blankMapArray | % {$_ -join " "})
        Write-Output ""

        #This validates the user inputs a correct coordinate. It must be a letter A-J and a number 1-10. 
        #It also changes the input to caps if needed to match the headers
        $validInput = "^\b[A-J]([1-9]|10)\b$"
        do{
            $target = Read-Host "Choose your target (Ex. A1)"
            $target = $target.ToUpper()
            if(-Not ($target -Match $validInput))
            {
                Write-Output "That coordinate doesn't exist! Please enter a valid coordinate"
            }
        } while(-Not ($target -Match $validInput))
        
        #subtract the missle just fired
        $misslesRemaining = $misslesRemaining - 1

        #Converting the input target to an array
        $targetArray = $target.ToCharArray()
        #Set the letter to position 0 in the array
        $letter = $targetArray[0]
        #make the array of headers into a string to reference
        $headerLetters = $headers -join ""
        #determine the X axis of the 2d array by indexing the letter inputted to the position of the header
        $columnChosen = $headerLetters.IndexOf($letter)
         
        #remove the letter from the target array leaving just the number entered
        $targetArray = $targetArray | Where-Object {$_ -ne $letter}
        #rowChosen becomes the number inputted
        $rowChosen = [int]($targetArray -join "")
        #subtract 1 from row chosen since arrays start at position [0]. This becomes your Y axis for the 2d array
        $rowChosen -= 1

       
        #Call on a function to determine whether the target was a hit and change the corresponding coordinate on the array to the appropriate character 
        #and set $hit to true/false
        $hit = Show-Hit -InMap $mapArray -InRow $rowChosen -InColumn $columnChosen
    
        #tell the user whether they hit or not. If a hit is registered the hitcount wil go up by 1
        if($hit -eq $true)
        {
            #Because we added a column of numbers we add 1 to the inputed column to match the map
            $columnChosen += 1
            $blankMapArray[$rowChosen][$columnChosen] = "X"
            $hitCount ++
            Write-Output "HIT!!!!!"
            #This will let the player know if they have sunk a particular ship. 
            #If the ship is sunk the variable will switch to true and the if statement will fail on subsequent attempts
            if($blankMapArray[0][4] -eq "X" -and $blankMapArray[0][5] -eq "X" -and $blankMapArray[0][6] -eq "X" -and $cruiserSunk -eq $false)
            {
                Write-Output "You sank my Cruiser!"
                $cruiserSunk = $true
            }
            if($blankMapArray[1][9] -eq "X" -and $blankMapArray[2][9] -eq "X" -and $blankMapArray[3][9] -eq "X" -and $blankMapArray[4][9] -eq "X" -and
             $battleshipSunk -eq $false)  
            {
                Write-Output "You sank my Battleship!"
                $battleshipSunk = $true
            }
            if($blankMapArray[4][4] -eq "X" -and $blankMapArray[5][4] -eq "X" -and $destroyerSunk -eq $false)  
            {
                Write-Output "You sank my Destroyer!"
                $destroyerSunk = $true
            }
            if($blankMapArray[7][7] -eq "X" -and $blankMapArray[7][8] -eq "X" -and $blankMapArray[7][9] -eq "X" -and $subSunk -eq $false)  
            {
                Write-Output "You sank my Submarine"
                $subSunk = $true
            } 
            if($blankMapArray[8][1] -eq "X" -and $blankMapArray[8][2] -eq "X" -and $blankMapArray[8][3] -eq "X" -and $blankMapArray[8][4] -eq "X" -and
             $blankMapArray[8][5] -eq "X" -and $carrierSunk -eq $false)  
            {
                Write-Output "You sank my Carrier!"
                $carrierSunk = $true
            }   
            #if all ships are sunk this line doesn't need to be printed    
            if($hitCount -ne 17)
            {
                Write-Output ("You have {0} missles remaining" -f $misslesRemaining)
            }  
        }
        elseif($hit -eq $false)
        {
            $columnChosen += 1
            $blankMapArray[$rowChosen][$columnChosen] = "O"
            Write-Output "Miss"
            Write-Output ("You have {0} missles remaining" -f $misslesRemaining)
        }

        # Call on a function to Determine whether the player wins the game 
        $win = Get-Win -InHitCount $hitCount -InMaxHits $MAXHITS            
    }

    # Print the win/loss statement depending on whether the player won or ran out of missles
    if($win -eq $true)
    {
        Write-Output "YOU SANK MY ENTIRE FLEET!"
        Write-Output "You had $hitCount of 17 hits, which sank all the ships"
        Write-Output "You won, congratulations!"
    }
    elseif($win -eq $false)
    {
        Write-Output "GAME OVER."
        Write-Output "You had $hitCount of 17 hits, but didn't sink all the ships"
        Write-Output "Better luck next time."
    }   
    
}

if ($MyInvocation.InvocationName -ne '.')
{
    # Trigger main function
    Show-Battleship
}

