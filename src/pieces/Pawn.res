let getMoveOptions = (id, team, cells: array<Game.cell>) => {
  switch team {
  | Game.White => {
      let previews = [id - Game.width]
      let leftDiaganolTeam =
        cells
        ->Belt.Array.get(id - Game.width - 1)
        ->Belt.Option.flatMap(c => Utils.getTeamFromPieceType(c.pieceType))
      let rightDiaganolTeam =
        cells
        ->Belt.Array.get(id - Game.width + 1)
        ->Belt.Option.flatMap(c => Utils.getTeamFromPieceType(c.pieceType))
      if Init.Cells.whitePawns->Js.Array2.includes(id) {
        let _ = previews->Js.Array2.push(id - Game.width * 2)
      }
      switch leftDiaganolTeam {
      | Some(t) =>
        if t != Game.White {
          let _ = previews->Js.Array2.push(id - Game.width - 1)
        }
      | _ => ()
      }
      switch rightDiaganolTeam {
      | Some(t) =>
        if t != Game.White {
          let _ = previews->Js.Array2.push(id - Game.width + 1)
        }
      | _ => ()
      }
      previews
    }

  | Game.Black => {
      let previews = [id + Game.width]
      let leftDiaganolTeam =
        cells
        ->Belt.Array.get(id + Game.width - 1)
        ->Belt.Option.flatMap(c => Utils.getTeamFromPieceType(c.pieceType))
      let rightDiaganolTeam =
        cells
        ->Belt.Array.get(id + Game.width + 1)
        ->Belt.Option.flatMap(c => Utils.getTeamFromPieceType(c.pieceType))
      if Init.Cells.blackPawns->Js.Array2.includes(id) {
        let _ = previews->Js.Array2.push(id + Game.width * 2)
      }
      switch leftDiaganolTeam {
      | Some(t) =>
        if t != Game.Black {
          let _ = previews->Js.Array2.push(id + Game.width - 1)
        }
      | _ => ()
      }
      switch rightDiaganolTeam {
      | Some(t) =>
        if t != Game.Black {
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
