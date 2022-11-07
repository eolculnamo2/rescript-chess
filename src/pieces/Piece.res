@react.component
let make = (~image: string, ~pieceName: string, ~turn) => {
  <div
    style={ReactDOM.Style.make(
      ~transform=`rotate(${turn == Game.Black ? "180deg" : "0"})`,
      ~width="100%",
      (),
    )}>
    <img style={ReactDOM.Style.make(~maxWidth="100%", ())} src=image alt=pieceName />
  </div>
}
