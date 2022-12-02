import System.IO
import Data.List
import Data.String

data Symbol = Rock | Paper | Scissors deriving (Enum, Eq, Show)

-- Input formatting
toSymbol :: String -> Symbol
toSymbol item
  | item `elem` ["A", "X"] = Rock
  | item `elem` ["B", "Y"] = Paper
  | item `elem` ["C", "Z"] = Scissors

matchToSymbol :: [String] -> [Symbol]
matchToSymbol list = map toSymbol list

toSymbolList :: [[String]] -> [[Symbol]]
toSymbolList list = map matchToSymbol list

groupByPlayers :: [String] -> [[String]]
groupByPlayers list
  | length (list) == 0 = []
  | otherwise = (fst (splitAt 2 list)):groupByPlayers (snd (splitAt 2 list))

winnerAgainst :: Symbol -> Symbol
winnerAgainst symbol
  | symbol == Rock = Paper
  | symbol == Paper = Scissors
  | symbol == Scissors = Rock

loserAgainst :: Symbol -> Symbol
loserAgainst symbol
  | symbol == Rock = Scissors
  | symbol == Paper = Rock
  | symbol == Scissors = Paper

toSymbolWithStrategy :: String -> Symbol -> Symbol
toSymbolWithStrategy item otherSymbol
  | item == "X" = (loserAgainst otherSymbol) -- Loss
  | item == "Y" = otherSymbol
  | item == "Z" = (winnerAgainst otherSymbol) -- Win

matchToSymbolWithStrategy :: [String] -> [Symbol]
matchToSymbolWithStrategy (a:b:[]) = [toSymbol a, toSymbolWithStrategy b (toSymbol a)]

toSymbolListWithStrategy :: [[String]] -> [[Symbol]]
toSymbolListWithStrategy list = map matchToSymbolWithStrategy list

-- Point values
victoryPoints = 6 :: Int
drawPoints = 3 :: Int
defeatPoints = 0 :: Int

-- Game end conditions
isVictory :: [Symbol] -> Bool
isVictory (a:b:[])
  | a == Rock && b == Scissors = True
  | a == Paper && b == Rock = True
  | a == Scissors && b == Paper = True
  | otherwise = False

isDefeat :: [Symbol] -> Bool
isDefeat (a:b:[])
  | a == Rock && b == Paper = True
  | a == Paper && b == Scissors = True
  | a == Scissors && b == Rock = True
  | otherwise = False

-- Determine match points
getItemPointValue :: Symbol -> Int
getItemPointValue item
  | item == Rock = 1
  | item == Paper = 2
  | item == Scissors = 3
  | otherwise = 0

getMatchItemPoints :: [Symbol] -> [Int]
getMatchItemPoints match = map getItemPointValue match

getMatchResultPoints :: [Symbol] -> [Int]
getMatchResultPoints match
  | isVictory match = [victoryPoints, defeatPoints]
  | isDefeat match = [defeatPoints, victoryPoints]
  | otherwise = [drawPoints, drawPoints]

getMatchPoints :: [Symbol] -> [Int]
getMatchPoints match = zipWith (+) (getMatchResultPoints match) (getMatchItemPoints match)

-- Results
--
-- Task 1
taskOne rawMoves = do
  let groupedMoves = groupByPlayers rawMoves :: [[String]]
  let symbols = toSymbolList groupedMoves :: [[Symbol]]
  let allMatchPoints = map (getMatchPoints) symbols :: [[Int]]
  let totalPoints = map sum (transpose allMatchPoints) :: [Int]

  print "- Task 2 -"
  print ("Opponent points: " ++ show (totalPoints!!0))
  print ("Player points:   " ++ show (totalPoints!!1))

-- Task 2
taskTwo rawMoves = do
  let groupedMoves = groupByPlayers rawMoves :: [[String]]
  let symbols = toSymbolListWithStrategy groupedMoves
  let allMatchPoints = map (getMatchPoints) symbols :: [[Int]]
  let totalPoints = map sum (transpose allMatchPoints) :: [Int]

  print "- Task 1 -"
  print ("Opponent points: " ++ show (totalPoints!!0))
  print ("Player points:   " ++ show (totalPoints!!1))

main :: IO()
main = do
  file <- openFile "resources/input.txt" ReadMode
  contents <- hGetContents file

  taskOne (words contents)
  taskTwo (words contents)

  hClose file
