// todo think about a way to combine functions even with inverse relationships
let getMoveOptions = (id, team, cells: array<Game.cell>) => {
  switch team {
  | Game.White => {
      let previews = []

      if Utils.isCellOccupied(id - Game.width, cells) == false {
        let _ = previews->Js.Array2.push(id - Game.width)
      }
      if (
        // only include second option if no piece is blocking from code above
        previews->Belt.Array.length > 0 &&
        Init.Cells.whitePawns->Js.Array2.includes(id) &&
        Utils.isCellOccupied(id - Game.width * 2, cells) == false
      ) {
        let _ = previews->Js.Array2.push(id - Game.width * 2)
      }

      let leftDiaganolTeam =
        cells
        ->Belt.Array.get(id - Game.width - 1)
        ->Belt.Option.flatMap(c => Utils.getTeamFromPieceType(c.pieceType))
      let rightDiaganolTeam =
        cells
        ->Belt.Array.get(id - Game.width + 1)
        ->Belt.Option.flatMap(c => Utils.getTeamFromPieceType(c.pieceType))
      switch leftDiaganolTeam {
      | Some(t) =>
        if t != Game.White && Boundaries.isLeftBoundary(id) == false {
          let _ = previews->Js.Array2.push(id - Game.width - 1)
        }
      | _ => ()
      }
      switch rightDiaganolTeam {
      | Some(t) =>
        if t != Game.White && Boundaries.isRightBoundary(id) == false {
          let _ = previews->Js.Array2.push(id - Game.width + 1)
        }
      | _ => ()
      }
      previews
    }

  | Game.Black => {
      let previews = []
      if Utils.isCellOccupied(id + Game.width, cells) == false {
        let _ = previews->Js.Array2.push(id + Game.width)
      }
      if (
        // only include second option if no piece is blocking from code above
        previews->Belt.Array.length > 0 &&
        Init.Cells.blackPawns->Js.Array2.includes(id) &&
          Utils.isCellOccupied(id + Game.width * 2, cells) == false
      ) {
        let _ = previews->Js.Array2.push(id + Game.width * 2)
      }
      let leftDiaganolTeam =
        cells
        ->Belt.Array.get(id + Game.width - 1)
        ->Belt.Option.flatMap(c => Utils.getTeamFromPieceType(c.pieceType))
      let rightDiaganolTeam =
        cells
        ->Belt.Array.get(id + Game.width + 1)
        ->Belt.Option.flatMap(c => Utils.getTeamFromPieceType(c.pieceType))
      switch leftDiaganolTeam {
      | Some(t) =>
        if t != Game.Black && Boundaries.isLeftBoundary(id) == false {
          let _ = previews->Js.Array2.push(id + Game.width - 1)
        }
      | _ => ()
      }
      switch rightDiaganolTeam {
      | Some(t) =>
        if t != Game.Black && Boundaries.isRightBoundary(id) == false {
          let _ = previews->Js.Array2.push(id + Game.width + 1)
        }
      | _ => ()
      }
      previews
    }
  }
}

@react.component
let make = (~team: Game.team) => {
  <Piece
    image={switch team {
    | White => "/images/white_pawn.png"
    | Black => "/images/black_pawn.png"
    }}
    pieceName="Pawn"
  />
}
