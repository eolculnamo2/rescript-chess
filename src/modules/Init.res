module Cells = {
  let blackKing = 4
  let whiteKing =  36 //60
  let whiteQueen = 59
  let blackQueen = 3
  let blackRook = (0, 7)
  let whiteRook = (56, 63)
  let blackKnight = (1, 6)
  let whiteKnight = (57, 62)
  let blackBishop = (2, 5)
  let whiteBishop = (58, 61)
  let whitePawns = [48, 49, 50, 51, 52, 53, 54, 55]
  let blackPawns = [8, 9, 10, 11, 12, 13, 14, 15]

  let make = (): array<Game.cell> => {
    let cells: array<Game.cell> = []
    for i in 0 to Game.area - 1 {
      let whitePawn = whitePawns->Js.Array2.find(c => c == i)
      let blackPawn = blackPawns->Js.Array2.find(c => c == i)
      let (blackRookOne, blackRookTWo) = blackRook
      let (whiteRookOne, whiteRookTwo) = whiteRook
      let (blackKnightOne, blackKnightTwo) = blackKnight
      let (whiteKnightOne, whiteKnightTwo) = whiteKnight
      let (blackBishopOne, blackBishopTwo) = blackBishop
      let (whiteBishopOne, whiteBishopTwo) = whiteBishop

      let _ = cells->Js.Array2.push({
        id: i,
        cellState: Game.None,
        pieceType: if whitePawn->Belt.Option.isSome {
          Game.PawnCell(Game.White)
        } else if blackPawn->Belt.Option.isSome {
          Game.PawnCell(Game.Black)
        } else if i == blackRookOne || i == blackRookTWo {
          Game.RookCell(Game.Black)
        } else if i == whiteRookOne || i == whiteRookTwo {
          Game.RookCell(Game.White)
        } else if i == whiteKnightOne || i == whiteKnightTwo {
          Game.KnightCell(Game.White)
        } else if i == blackKnightOne || i == blackKnightTwo {
          Game.KnightCell(Game.Black)
        } else if i == whiteBishopOne || i == whiteBishopTwo {
          Game.BishopCell(Game.White)
        } else if i == blackBishopOne || i == blackBishopTwo {
          Game.BishopCell(Game.Black)
        } else if i == whiteKing {
          Game.KingCell(Game.White)
        } else if i == blackKing {
          Game.KingCell(Game.Black)
        } else if i == whiteQueen {
          Game.QueenCell(Game.White)
        } else if i == blackQueen {
          Game.QueenCell(Game.Black)
        } else {
          Blank
        },
      })
    }
    cells
  }
}
